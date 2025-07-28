//
//  ChatBotView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//

import SwiftUI

struct Message: Identifiable, Equatable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
    var isStreaming: Bool = false
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}

struct QuickReply: Identifiable {
    let id = UUID()
    let text: String
}

struct ChallengeChatAssistantView: View {
    @State private var messages: [Message] = []
    @State private var inputText = ""
    @State private var isTyping = false
    @State private var currentStreamingMessage: Message?
    @State private var streamingText = ""
    @State private var selectedTab = 1 // Chat tab selected
    @State private var showQuickReplies = true
    @Environment(\.presentationMode) var presentationMode
    
    private let maxCharacters = 500
    private let assistantAvatar = "🤖"
    private let userAvatar = "👤"
    
    // Quick reply suggestions based on context
    @State private var quickReplies: [QuickReply] = [
        QuickReply(text: "What's today's challenge?"),
        QuickReply(text: "I need motivation"),
        QuickReply(text: "Give me a hint"),
        QuickReply(text: "How do I get started?")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Challenge Assistant")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Invisible spacer for centering
                Image(systemName: "arrow.left")
                    .font(.system(size: 18, weight: .medium))
                    .opacity(0)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
            
            // Chat messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        // Initial messages
                        if messages.isEmpty {
                            initialMessages
                        }
                        
                        // Dynamic messages
                        ForEach(messages) { message in
                            MessageBubble(
                                message: message,
                                isStreaming: message.isStreaming,
                                streamingText: message.id == currentStreamingMessage?.id ? streamingText : ""
                            )
                            .id(message.id)
                        }
                        
                        // Typing indicator
                        if isTyping {
                            TypingIndicator()
                                .id("typing")
                        }
                        
                        // Quick replies
                        if showQuickReplies && !isTyping {
                            QuickRepliesView(replies: quickReplies) { reply in
                                sendMessage(reply.text)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.vertical, 16)
                }
                .onChange(of: messages.count) { _ in
                    if let lastMessage = messages.last {
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: isTyping) { typing in
                    if typing {
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo("typing", anchor: .bottom)
                        }
                    }
                }
            }
            
            // Input area
            VStack(spacing: 12) {
                // Character count and input
                VStack(spacing: 8) {
                    if !inputText.isEmpty {
                        HStack {
                            Spacer()
                            Text("\(inputText.count)/\(maxCharacters)")
                                .font(.system(size: 12))
                                .foregroundColor(inputText.count > maxCharacters ? .red : .gray)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    HStack(spacing: 12) {
                        // Plus button
                        Button(action: {}) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.gray)
                        }
                        
                        // Text input
                        HStack {
                            TextField("Type your message...", text: $inputText, axis: .vertical)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(.system(size: 16))
                                .lineLimit(1...4)
                                .disabled(isTyping)
                            
                            if !inputText.isEmpty {
                                Button(action: {
                                    inputText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.1))
                        )
                        
                        // Send button
                        Button(action: {
                            if !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && inputText.count <= maxCharacters {
                                sendMessage(inputText)
                                inputText = ""
                            }
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputText.count > maxCharacters ? .gray : .blue)
                        }
                        .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputText.count > maxCharacters || isTyping)
                    }
                    .padding(.horizontal, 20)
                }
                
                // Bottom tab bar
                HStack(spacing: 0) {
                    ChatTabBarItem(
                        icon: "house.fill",
                        title: "Home",
                        isSelected: selectedTab == 0
                    ) { selectedTab = 0 }
                    
                    Spacer()
                    
                    ChatTabBarItem(
                        icon: "message.fill",
                        title: "Chat",
                        isSelected: selectedTab == 1
                    ) { selectedTab = 1 }
                    
                    Spacer()
                    
                    ChatTabBarItem(
                        icon: "person.fill",
                        title: "Profile",
                        isSelected: selectedTab == 2
                    ) { selectedTab = 2 }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(Color.white)
            }
            .background(Color.white)
        }
        .background(Color(red: 0.97, green: 0.97, blue: 0.98))
        .navigationBarHidden(true)
    }
    
    private var initialMessages: some View {
        VStack(spacing: 16) {
            MessageBubble(
                message: Message(
                    content: "Hi there! I'm your Challenge Assistant. Ready to tackle today's personalized challenge? Let's make it a great day!",
                    isUser: false,
                    timestamp: Date().addingTimeInterval(-300)
                ),
                isStreaming: false,
                streamingText: ""
            )
            
            MessageBubble(
                message: Message(
                    content: "Yes, I'm ready! What's the challenge for today?",
                    isUser: true,
                    timestamp: Date().addingTimeInterval(-240)
                ),
                isStreaming: false,
                streamingText: ""
            )
            
            MessageBubble(
                message: Message(
                    content: "Today's challenge is to learn a new skill. How about trying a 30-minute online course on a topic you've always been curious about?",
                    isUser: false,
                    timestamp: Date().addingTimeInterval(-180)
                ),
                isStreaming: false,
                streamingText: ""
            )
            
            MessageBubble(
                message: Message(
                    content: "That sounds interesting! I'll look for a course now.",
                    isUser: true,
                    timestamp: Date().addingTimeInterval(-120)
                ),
                isStreaming: false,
                streamingText: ""
            )
            
            MessageBubble(
                message: Message(
                    content: "Great! Remember, the goal is to learn something new, so choose a topic that genuinely interests you. Good luck!",
                    isUser: false,
                    timestamp: Date().addingTimeInterval(-60)
                ),
                isStreaming: false,
                streamingText: ""
            )
        }
        .padding(.horizontal, 20)
    }
    
    private func sendMessage(_ text: String) {
        let userMessage = Message(content: text, isUser: true, timestamp: Date())
        messages.append(userMessage)
        showQuickReplies = false
        
        // Show typing indicator after a brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isTyping = true
            
            // Generate response after typing delay
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5...3.0)) {
                isTyping = false
                let response = generateResponse(for: text)
                streamResponse(response)
            }
        }
    }
    
    private func streamResponse(_ response: String) {
        let aiMessage = Message(content: "", isUser: false, timestamp: Date(), isStreaming: true)
        currentStreamingMessage = aiMessage
        messages.append(aiMessage)
        streamingText = ""
        
        // Stream the response character by character
        for (index, character) in response.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.03) {
                streamingText += String(character)
                
                // Complete streaming
                if index == response.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let messageIndex = messages.firstIndex(where: { $0.id == currentStreamingMessage?.id }) {
                            messages[messageIndex] = Message(
                                content: response,
                                isUser: false,
                                timestamp: Date()
                            )
                        }
                        currentStreamingMessage = nil
                        streamingText = ""
                        updateQuickReplies(for: response)
                        showQuickReplies = true
                    }
                }
            }
        }
    }
    
    private func generateResponse(for input: String) -> String {
        let lowercaseInput = input.lowercased()
        
        if lowercaseInput.contains("challenge") && (lowercaseInput.contains("what") || lowercaseInput.contains("today")) {
            return "Your challenge today is to learn a new skill! Try a 30-minute online course on something you've always wanted to explore. It could be photography, coding, cooking, or any topic that sparks your curiosity."
        }
        
        if lowercaseInput.contains("motivation") || lowercaseInput.contains("motivate") {
            return "You've got this! 💪 Remember, every expert was once a beginner. Taking just 30 minutes to learn something new today will expand your horizons and boost your confidence. Small steps lead to big achievements!"
        }
        
        if lowercaseInput.contains("hint") || lowercaseInput.contains("help") {
            return "Here's a hint: Start with platforms like YouTube, Coursera, or Khan Academy. Pick something that genuinely interests you - maybe a skill you could use at work, a hobby you've wanted to try, or knowledge that's always fascinated you."
        }
        
        if lowercaseInput.contains("started") || lowercaseInput.contains("begin") {
            return "Great question! Here's how to get started:\n\n1. Think of 2-3 topics you're curious about\n2. Search for beginner-friendly courses\n3. Set a timer for 30 minutes\n4. Take notes on key learnings\n5. Celebrate your progress!\n\nReady to dive in?"
        }
        
        if lowercaseInput.contains("done") || lowercaseInput.contains("completed") || lowercaseInput.contains("finished") {
            return "Awesome! 🎉 How did it go? What did you learn? I'd love to hear about your experience and what insights you gained from the course."
        }
        
        if lowercaseInput.contains("difficult") || lowercaseInput.contains("hard") {
            return "I understand it can feel challenging! Remember, learning is supposed to stretch you a bit. If it feels too difficult, try finding a more beginner-friendly resource, or break it into smaller 10-minute chunks. You're doing great by stepping out of your comfort zone!"
        }
        
        if lowercaseInput.contains("time") {
            return "The challenge is designed to take about 30 minutes, but feel free to go longer if you're enjoying it! The key is to dedicate focused time to learning something new. Quality over quantity."
        }
        
        // Default response
        return "That's a great point! Keep exploring and asking questions - that's the spirit of today's learning challenge. Is there anything specific about the challenge you'd like to discuss?"
    }
    
    private func updateQuickReplies(for response: String) {
        if response.contains("challenge today is") {
            quickReplies = [
                QuickReply(text: "How do I get started?"),
                QuickReply(text: "What if it's too difficult?"),
                QuickReply(text: "I need motivation"),
                QuickReply(text: "How much time should I spend?")
            ]
        } else if response.contains("You've got this") {
            quickReplies = [
                QuickReply(text: "Thanks! I'm ready to start"),
                QuickReply(text: "Give me a hint"),
                QuickReply(text: "What topics do you recommend?")
            ]
        } else {
            quickReplies = [
                QuickReply(text: "I completed the challenge!"),
                QuickReply(text: "I need more help"),
                QuickReply(text: "This is interesting!"),
                QuickReply(text: "What's next?")
            ]
        }
    }
}

struct MessageBubble: View {
    let message: Message
    let isStreaming: Bool
    let streamingText: String
    
    private let assistantAvatar = "🤖"
    private let userAvatar = "👤"
    
    var displayText: String {
        isStreaming ? streamingText : message.content
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if !message.isUser {
                // Assistant avatar
                Text(assistantAvatar)
                    .font(.system(size: 24))
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(Color.gray.opacity(0.1)))
            } else {
                Spacer()
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                // Message bubble
                Text(displayText)
                    .font(.system(size: 16))
                    .foregroundColor(message.isUser ? .white : .black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(message.isUser ? Color.blue : Color.white)
                    )
                    .overlay(
                        // Streaming cursor
                        Group {
                            if isStreaming {
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .fill(Color.black.opacity(0.7))
                                        .frame(width: 2, height: 16)
                                        .opacity(isStreaming ? 1 : 0)
                                        .animation(.easeInOut(duration: 0.8).repeatForever(), value: isStreaming)
                                }
                                .padding(.trailing, 16)
                            }
                        }
                    )
                
                // Timestamp
                Text(formatTime(message.timestamp))
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            }
            
            if message.isUser {
                // User avatar
                Text(userAvatar)
                    .font(.system(size: 24))
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(Color.blue.opacity(0.1)))
            } else {
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct TypingIndicator: View {
    @State private var animating = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            // Assistant avatar
            Text("🤖")
                .font(.system(size: 24))
                .frame(width: 32, height: 32)
                .background(Circle().fill(Color.gray.opacity(0.1)))
            
            // Typing animation
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                        .scaleEffect(animating ? 1.0 : 0.5)
                        .animation(
                            .easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                            value: animating
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
            )
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .onAppear {
            animating = true
        }
    }
}

struct QuickRepliesView: View {
    let replies: [QuickReply]
    let onReplyTapped: (QuickReply) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(replies) { reply in
                    Button(action: {
                        onReplyTapped(reply)
                    }) {
                        Text(reply.text)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue, lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.white)
                                    )
                            )
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct ChatTabBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSelected ? .blue : .gray)
                
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Preview
struct ChallengeChatAssistantView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeChatAssistantView()
    }
}

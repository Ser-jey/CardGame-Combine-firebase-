//
//  FormViewModel.swift
//  ReadDataFromDB (iOS)
//
//  Created by Сергей Кривошеев on 10.03.2022.
//

import Foundation
import Combine
import SwiftUI

class FormViewModel: ObservableObject {
    @Published var question: String = ""
    @Published var answer: String = ""
    
    @Published var inlineErrorForQuestion: String = ""
    @Published var inlineErrorforAnswer: String = ""
    @Published var isValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isQuestionLenthValidPublisher: AnyPublisher<Bool,Never> {
        $question
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ $0.isEmpty }
            .eraseToAnyPublisher()
        
    }
    
    private var isQuestionValidPublisher: AnyPublisher<QuestionStatus, Never> {
        isQuestionLenthValidPublisher
            .map {
                if $0 { return QuestionStatus.empty }
                return QuestionStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isAnswerLenthValidPublisher: AnyPublisher<Bool,Never> {
        $answer
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ $0.isEmpty}
            .eraseToAnyPublisher()
    }
    
    private var isAnswerValidPublisher: AnyPublisher<AnswerStatus, Never> {
        isAnswerLenthValidPublisher
            .map{
                if $0 { return AnswerStatus.empty}
                return AnswerStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormViewValidPublisher: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest(isAnswerValidPublisher, isQuestionValidPublisher)
            .map{ $0 == .valid && $1 == .valid }
            .eraseToAnyPublisher()
    }
    
    init(){
        
        isQuestionValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map{ questionStatus in
                switch questionStatus{
                case .empty:
                    return "This field can not be empty"
                case .valid:
                    return ""
                }
            }.assign(to: \.inlineErrorForQuestion, on: self)
            .store(in: &cancellables)
           
        isAnswerValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map{
                answerStatus in
                switch answerStatus{
                case .empty:
                    return "This field can not be empty"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlineErrorforAnswer, on: self)
            .store(in: &cancellables)
        
        isFormViewValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
    }
    
    
    
    
}

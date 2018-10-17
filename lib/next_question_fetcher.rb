# frozen_string_literal: true

class NextQuestionFetcher
  # TODO: Ideas
  # 1. Make sure equal number of questions are sampled from each category
  # 2. Add weights to questions, select questions based on how the interviewee is answering ( Eg:- Ask tougher questions
  # if the interviewee is performing well)
  #

  def find_next_question(attempt)
    # already assigned questions
    assigned_questions = attempt.questions
    # attempted questions - saved answers
    attempted_questions = attempt.response&.dig("answers")&.map { |a| a.keys[0].to_i } || []
    # check if there are questions assigned but not answered yet
    to_be_answered = assigned_questions.pluck(:id) - attempted_questions
    # if yes, return that question
    unless to_be_answered.blank?
      return Question.find(to_be_answered.first)
    end

    # selected categories of attempt
    attempt_categories = Category.parents_and_children(attempt.categories)
    # questions in above categories
    interview_questions = Question.joins(:categories_questions).
                          where(categories_questions: { category_id: attempt_categories })
    remaining_questions = (interview_questions - assigned_questions)
    # no more questions left
    if remaining_questions.blank?
      return "Completed"
    end

    # randomly select one question
    remaining_questions.sample(1)[0]
  end
end

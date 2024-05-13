# frozen_string_literal: true

module AttemptsHelper
  # Helper method to calculate score per question
  def calculate_score_per_question(question, answered_options)
    if question.questionable_type == "Mcq" && answered_options.present?
      correct_options = question.questionable.correct_options
      num_correct_selected = (correct_options & answered_options).size
      total_options = correct_options.size
      (num_correct_selected.to_f / total_options)
    elsif question.questionable_type == "Essay" && answered_options.present?
      return 1 # For simplicity, assuming 1 point for each essay question
    else
      0 # No score if question is skipped or unanswered
    end
  end

  # Helper method to calculate final aggregate score
  def calculate_aggregate_score(attempt)
    total_score = 0
    attempt.response&.dig("answers")&.each do |answer|
      question = @indexed_questions[answer.keys[0].to_i]
      answered_options = answer.values[0]
      score = calculate_score_per_question(question, answered_options)
      total_score += score
    end
    return total_score
  end
end

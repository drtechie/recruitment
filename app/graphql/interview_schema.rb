# frozen_string_literal: true

class InterviewSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end

# frozen_string_literal: true

class RecruitmentSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end

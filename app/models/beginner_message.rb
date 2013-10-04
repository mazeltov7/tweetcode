# coding:utf-8

class BeginnerMessage < ActiveRecord::Base
  belongs_to :user

  def self.text_search(query)
    if query.present?
      rank =  <<-RANK
        ts_rank(to_tsvector(body),plainto_tsquery(#{sanitize(query)}))
      RANK
      where("body @@ :q ", q: query).order("#{rank} desc")
    else
      scope
    end
  end
end

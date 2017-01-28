# frozen_string_literal: true
class ApplicationController < ActionController::API
protected
  
  def current_user
    nil # TODO
  end

  def meta_for(relation)
    {
      page:  relation.current_page,
      next:  relation.next_page,
      prev:  relation.prev_page,
      size:  relation.size,
      count: relation.total_count,
      pages: relation.total_pages
    }
  end
end

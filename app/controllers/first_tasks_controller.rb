class FirstTasksController < ApplicationController
  def data; end

  def calculation
    puts params
    render :result
  end

  def result

  end
end
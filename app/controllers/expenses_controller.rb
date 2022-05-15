class ExpensesController < ApplicationController
  def index
    if params[:start_date].nil?
      today = Time.now
      today = today.to_s
      @expenses = Expense.where('date like ?', "#{today.slice(0..6)}%")
      @expenses = Expense.where(user_id: current_user.id)
    else
      @expenses = Expense.where('date like ?', "#{params[:start_date].slice(0..6)}%")
      @expenses = Expense.where(user_id: current_user.id)
    end
    @total_value = 0
    @expenses.each do |expense|
      @total_value += expense.value
    end
    @category_count = Category.count
  end

  def new
    @date = params[:format]
    @expenses = Expense.where(date: @date, user_id: current_user.id).order('created_at DESC')
    @total_value = 0
    @expenses.each do |expense|
      @total_value += expense.value
    end
    @expense = Expense.new
  end

  def create
    post = Expense.new(expense_params)
    if post.save
      name = post.category.name
      render json:{ post: post, name: name }
    end

  end

  private

  def expense_params
    params.require(:expense).permit(:name, :value, :category_id, :date).merge(user_id: current_user.id)
  end
end

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
    @expenses = Expense.where(date: @date).order('created_at DESC')
    @expenses = Expense.where(user_id: current_user.id)
    @total_value = 0
    @expenses.each do |expense|
      @total_value += expense.value
    end
    @expense = Expense.new
  end

  def create
    @expense = Expense.create(expense_params)
    render json:{ post: post }
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :value, :category_id, :date).merge(user_id: current_user.id)
  end
end

class ExpensesController < ApplicationController
  def index
    @expenses = Expense.where('date like ?', "#{params[:start_date].slice(0..6)}%")
    @total_value = 0
    @expenses.each do |expense|
      @total_value += expense.value
    end
    @category_count = Category.count

  end

  def new
    @expense = Expense.new
    @date = params[:format]
    @expenses = Expense.where(date:@date).order("created_at DESC")
    @total_value = 0
    @expenses.each do |expense|
      @total_value += expense.value
    end
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to action: :index
    else
      render :index
    end
  end

  private
  def expense_params
    params.require(:expense).permit(:name, :value, :category_id, :date)
  end

end

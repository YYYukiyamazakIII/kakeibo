class ExpensesController < ApplicationController
  def index

  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to action: :index
    else
      render :index
    end
  end

  def show
    @expense = Expense.new
    @expenses = Expense.all
    @total_value = 0
    @expenses.each do |expense|
      @total_value += expense.value
    end
  end

  private
  def expense_params
    params.require(:expense).permit(:name, :value, :category_id, :date)
  end

end

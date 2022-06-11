class ExpensesController < ApplicationController
  def index
    set_expenses
    set_total_expense
    @category = Category.all
  end

  def new
    @date = params[:format].to_date
    @expenses = Expense.where(date: @date, user_id: current_user.id).order('created_at DESC')
    @expense = Expense.new
  end

  def create
    expense = Expense.new(expense_params)
    if expense.save
      render json:{ expense: expense, categoryName: expense.category.name }
    else
      render json:{ judge: "false", message: expense.errors.full_messages }
    end
  end

  def edit
    render json:{ expense: Expense.find(params[:id]) }
  end

  def update
    expense = Expense.find(params[:id])
    if expense.user_id == current_user.id
      if  expense.update(expense_params)
        render json:{ expense: expense, categoryName: expense.category.name }
      else
        render json:{ judge: "false", message: expense.errors.full_messages }
      end
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    if expense.user_id == current_user.id
      expense.destroy
    end
  end

  private

  def set_expenses
    @current_user_expense = Expense.where(user_id: current_user.id)
    if params[:start_date].nil?
      today = Time.now.to_s
      @expenses = @current_user_expense.where('date like ?', "#{today.slice(0..6)}%")
      @current_month = Time.now.month
    else
      @expenses = @current_user_expense.where('date like ?', "#{params[:start_date].slice(0..6)}%")
      @current_month = params[:start_date].slice(5..6).to_i
    end
  end

  def set_total_expense
    @total_expense = 0
    @expenses.each do |expense|
      @total_expense += expense.value
    end
  end

  def expense_params
    params.require(:expense).permit(:name, :value, :category_id, :date).merge(user_id: current_user.id)
  end

end

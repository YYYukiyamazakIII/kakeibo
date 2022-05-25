class ExpensesController < ApplicationController
  def index
    @current_user_expense = Expense.where(user_id: current_user.id)
    if params[:start_date].nil?
      today = Time.now
      today = today.to_s
      @expenses = @current_user_expense.where('date like ?', "#{today.slice(0..6)}%")
    else
      @expenses = @current_user_expense.where('date like ?', "#{params[:start_date].slice(0..6)}%")
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
    @expense = Expense.new
  end

  def create
    post = Expense.new(expense_params)
    if post.save
      name = post.category.name
      render json:{ post: post, name: name }
    else
      judge = false
      message = post.errors.full_messages
      render json:{ judge: judge, message: message }
    end
  end

  def edit
    expense = Expense.find(params[:id])
    render json:{ expense: expense }
  end

  def update
    expense = Expense.find(params[:id])
    if expense.user_id == current_user.id
      if  expense.update(expense_params)
        name = expense.category.name
        render json:{ update: expense, name: name }
      else
        judge = false
        message = expense.errors.full_messages
        render json:{ judge: judge, message: message }
      end
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    if expense.user_id == current_user.id
      Expense.destroy(params[:id])
      text = "削除しました"
      render json:{ text:text }
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :value, :category_id, :date).merge(user_id: current_user.id)
  end
end

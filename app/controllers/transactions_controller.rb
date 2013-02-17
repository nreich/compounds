class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def create
    @user = current_user
    @batch = Batch.find(params[:batch_id])
    @transaction = @batch.transactions.build(params[:transaction])
    if @transaction.save
      flash[:success] = "Transaction successful"
    else
      flash[:notice] = "Transaction failed"
    end
    redirect_to @batch
  end
end

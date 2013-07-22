class TransactionsController < ApplicationController
  
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    @batch = Batch.find(params[:batch])
  end

  def create
    @batch = Batch.find(params[:transaction][:batch_id])
    @transaction = @batch.transactions.build(params[:transaction])
    authorize! :create, @transaction
    @transaction.user = current_user
    if @transaction.save
      flash[:success] = "Transaction successful"
    else
      flash[:notice] = "Transaction failed"
    end
    redirect_to @batch
  end
end

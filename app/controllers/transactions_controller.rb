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

  def edit
    @transaction = Transaction.find(params[:id])
    @batch = Batch.find(@transaction.batch_id)
    authorize! :edit, @transaction
  end

  def update
    @transaction = Transaction.find(params[:id])
    original_amount = @transaction.amount
    @batch = Batch.find(@transaction.batch_id)
    authorize! :update, @transaction

    if @transaction.update_attributes(params[:transaction])
      @batch.reload
      @batch.amount += original_amount
      @batch.save
      redirect_to @transaction, notice: 'Transaction was successfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
  end
end

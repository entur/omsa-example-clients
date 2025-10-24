from pydantic import BaseModel, Field


class TransactionModel(BaseModel):
    amount: str
    currency: str
    payment_type: str = Field(alias="paymentType")

    model_config = {"populate_by_name": True, "extra": "allow"}


class PaymentRequest(BaseModel):
    order_id: str = Field(alias="orderId")
    order_version: int = Field(alias="orderVersion")
    total_amount: str = Field(alias="totalAmount")
    transaction: TransactionModel

    model_config = {"populate_by_name": True, "extra": "allow"}


class PaymentTerminalRequest(BaseModel):
    redirect_url: str = Field(alias="redirectUrl")
    terminal_language: str = Field(alias="terminalLanguage")

    model_config = {"populate_by_name": True, "extra": "allow"}


class PaymentAppClaimRequest(BaseModel):
    description: str
    phone_number: str = Field(alias="phoneNumber")
    redirect_url: str = Field(alias="redirectUrl")

    model_config = {"populate_by_name": True, "extra": "allow"}

import httpx
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
from typing import List


class OrderIn(BaseModel):
    """Model for an incoming order request."""
    product_id: int
    quantity: int


class OrderOut(OrderIn):
    """Model for a created order response."""
    id: int
    total_price: float
    status: str = "completed"


app = FastAPI(
    title="Order Service",
    description="Manages customer orders.",
    version="1.0.0",
)

db_orders: List[OrderOut] = []


INVENTORY_SERVICE_URL = "http://localhost:8000"


@app.post("/orders", response_model=OrderOut, status_code=status.HTTP_201_CREATED, tags=["Orders"])
async def create_order(order_in: OrderIn):
    """
    Creates a new order by validating the product with the Inventory Service.
    """
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(f"{INVENTORY_SERVICE_URL}/products/{order_in.product_id}")
            response.raise_for_status()
            product_data = response.json()

        except httpx.HTTPStatusError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Product with id {order_in.product_id} is not valid or inventory is down."
            )
        except httpx.RequestError:
            raise HTTPException(
                status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
                detail="Inventory service is unavailable."
            )

    total_price = product_data["price"] * order_in.quantity

    new_order = OrderOut(
        id=len(db_orders) + 1,
        product_id=order_in.product_id,
        quantity=order_in.quantity,
        total_price=total_price,
    )
    db_orders.append(new_order)

    return new_order
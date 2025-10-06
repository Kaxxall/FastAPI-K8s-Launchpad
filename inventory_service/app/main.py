from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List


class Product(BaseModel):
    id: int
    name: str
    price: float
    quantity: int


app = FastAPI(
    title="Inventory Service",
    description="Manages product inventory.",
    version="1.0.0",
)


db_products = {
    1: Product(id=1, name="Laptop", price=1200.00, quantity=10),
    2: Product(id=2, name="Mouse", price=25.50, quantity=50),
    3: Product(id=3, name="Keyboard", price=75.00, quantity=30),
}


@app.get("/products", response_model=List[Product], tags=["Products"])
async def get_all_products():
    """
    Returns a list of all products in the inventory.
    """
    return list(db_products.values())


@app.get("/products/{product_id}", response_model=Product, tags=["Products"])
async def get_product_by_id(product_id: int):
    """
    Returns the details of a specific product by its ID.
    Raises a 404 error if the product is not found.
    """
    product = db_products.get(product_id)
    if not product:
        raise HTTPException(status_code=404, detail=f"Product with id {product_id} not found.")
    return product


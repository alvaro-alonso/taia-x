# generated by datamodel-codegen:
#   filename:  buy.json

from __future__ import annotations

from pydantic import BaseModel, Extra


class BuyParameter(BaseModel):
    class Config:
        extra = Extra.forbid

    price: str
    token_id: str

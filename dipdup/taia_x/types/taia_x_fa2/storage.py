# generated by datamodel-codegen:
#   filename:  storage.json

from __future__ import annotations

from typing import Any, Dict, List, Optional, Union

from pydantic import BaseModel, Extra, Field


class Datasets(BaseModel):
    class Config:
        extra = Extra.forbid

    id: str
    isOwned: bool
    owner: str
    price: Optional[str]


class Market(BaseModel):
    class Config:
        extra = Extra.forbid

    datasetIds: List[str]
    datasets: Dict[str, Datasets]
    nextDatasetId: str
    owners: Dict[str, List[str]]


class Key(BaseModel):
    class Config:
        extra = Extra.forbid

    address_0: str
    address_1: str
    nat: str


class Operator(BaseModel):
    class Config:
        extra = Extra.forbid

    key: Key
    value: Dict[str, Any]


class TokenMetadata(BaseModel):
    class Config:
        extra = Extra.forbid

    token_id: str
    token_info: Dict[str, str]


class OrItem(BaseModel):
    class Config:
        extra = Extra.forbid

    certifier: Dict[str, Any]


class OrItem1(BaseModel):
    class Config:
        extra = Extra.forbid

    consumer: Dict[str, Any]


class OrItem2(BaseModel):
    class Config:
        extra = Extra.forbid

    provider: Dict[str, Any]


class Key1(BaseModel):
    class Config:
        extra = Extra.forbid

    address: str
    or_: Union[OrItem, OrItem1, OrItem2] = Field(..., alias='or')


class User(BaseModel):
    class Config:
        extra = Extra.forbid

    key: Key1
    value: Dict[str, Any]


class TaiaX_Fa2Storage(BaseModel):
    class Config:
        extra = Extra.forbid

    ledger: Dict[str, str]
    market: Market
    operators: List[Operator]
    token_metadata: Dict[str, TokenMetadata]
    users: List[User]

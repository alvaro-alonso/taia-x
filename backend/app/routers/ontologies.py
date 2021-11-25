from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from ..db import get_db
from ..core.ipfs import ipfs_client
from ..schemas import OntologyInput
from ..models import get_or_create_ontology


router = APIRouter(
    prefix="/ontology",
    tags=["ontologies"],
)


@router.post("/")
async def save_ontology(ontology: OntologyInput, db: Session = Depends(get_db)):
    ontology_hash = ipfs_client.save_json(ontology.dict())
    db_ontology, _ = get_or_create_ontology(db, ontology_hash)
    return {
        "ontology_hash": db_ontology.ontology_addr,
        "ontology": ontology
    }
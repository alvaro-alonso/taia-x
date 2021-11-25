// Allowed roles, you can add a new annotation right here, for example 'Dev' or 'Moderator'
type role is Customer | Certifier | Provider | NoRole 

type action is
  | MakeCustomer 
  | MakeCertifier 
  | MakeProvider 
  | RemoveRole 

type store is record
  users: big_map(address, role);
end  

type return is list(operation) * store

// Function that checks if an account is a Customer role
// Must be integrated into functions that can only be used by a Customer 
function isCustomer (const addressOwner : address; var store : store) : bool is
  block {
    var isCustomer: bool := case Big_map.find_opt(addressOwner, store.users) of
      | None -> False
      | Some(userRole) ->
          case userRole of
            | Certifier -> False
            | Provider -> False
            | Customer -> True
            | NoRole -> False
          end
    end;
  } with isCustomer;

// Function that checks if an account is a Provider role
// Must be integrated into functions that can only be used by a Provider 
function isProvider (const addressOwner : address; var store : store) : bool is
  block {
    var isProvider: bool := case Big_map.find_opt(addressOwner, store.users) of
      | None -> False
      | Some(userRole) ->
          case userRole of
            | Certifier -> False
            | Provider -> True
            | Customer -> False
            | NoRole -> False
          end
    end;
  } with isProvider;

// Function that checks if an account is a Certifier role
// Must be integrated into functions that can only be used by a Certifier 
function isCertifier (const addressOwner : address; var store : store) : bool is
  block {
    var isCertifier: bool := case Big_map.find_opt(addressOwner, store.users) of
      | None -> False
      | Some(userRole) ->
          case userRole of
            | Certifier -> True
            | Provider -> False
            | Customer -> False
            | NoRole -> False
          end
    end;
  } with isCertifier;

// Add/Update an account with a Certifier role
function makeCertifier (var store : store) : return is
  block {
    const newUsers : big_map(address, role) = Big_map.update(Tezos.sender, Some(Certifier), store.users);
  } with ((nil : list (operation)), store with record [users = newUsers;]);

// Add/Update an account with a Provider role
function makeProvider (var store : store) : return is
  block {
    const newUsers : big_map(address, role) = Big_map.update(Tezos.sender, Some(Provider), store.users);
  } with ((nil : list (operation)), store with record [users = newUsers;]);

// Add/Update an account with a Customer role
function makeCustomer (var store : store) : return is
  block {
    const newUsers : big_map(address, role) = Big_map.update(Tezos.sender, Some(Customer), store.users);
  } with ((nil : list (operation)), store with record [users = newUsers;]);

// Remove a role to some user
function removeRole (var store : store) : return is
  block {
    const newUsers : big_map(address, role) = Big_map.update(Tezos.sender, Some(NoRole), store.users);
  } with ((nil : list (operation)), store with record [users = newUsers;]);

function main (const action: action; var store: store): return is
  block {
    skip
  } with case action of
    | MakeCertifier -> makeCertifier(store)
    | MakeProvider -> makeProvider(store)
    | MakeCustomer -> makeCustomer(store)
    | RemoveRole -> removeRole(store)
  end;
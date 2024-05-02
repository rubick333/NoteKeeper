# CoreData+Note

### Ways to store Local data in ios

1) property list
2) user default
3) SQLite
4) Core Data
5) Key Chain


## CORE DATA

##NOTE: Always keep codegen to manual as it helps to read the Core Data model instead of auto generated code

________________________________________________

### NSManagedObject

NSManagedObject is a base class which all Core Dara model inherits.
Core Data model = Entity
Entity has attributes

2)NSManagedObjectContext
An object space to manipulate and track changes to managed objects.

3)NSPersistentContainer
A container that encapsulates the Core Data stack in your app.

_________________________________________________


##CRUD operations using Repository pattern

Everytime a change is made to the entity, saveContext method must be called.

allows external storage must be checked, to store large amount of files or data.


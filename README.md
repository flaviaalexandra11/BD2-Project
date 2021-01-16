# Proiect Baze de date 2 - Catalog electornic

# Baza de date

## Docker
### Instalare docker windows

Instalat wsl2: [https://docs.microsoft.com/en-us/windows/wsl/install-win10](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

Instalat docker pe windows home: [https://docs.docker.com/docker-for-windows/install-windows-home/](https://docs.docker.com/docker-for-windows/install-windows-home/)

### Hello world

Din wsl (run as admin): `docker run hello-world`

### Docker MySQL

De pe dockerhub: [https://hub.docker.com/_/mysql](https://hub.docker.com/_/mysql)

Din wsl (run as admin): docker pull mysql

Apoi: 
```
docker run --name bd2-gradebook -p "3306:3306" -e MYSQL_ROOT_PASSWORD=parola -d mysql:latest
```

## Creare baza de date
Se ruleaza in ordine scripturile: 
1. create_tables.sql
2. add_foreign_keys.sql
3. create_user.sql (cu datele dorite)

## Populare baza de date
Se ruleaza in ordine scripturile: 
1. insert_user_accounts.sql
2. insert_admins.sql
3. insert_teachers.sql
4. insert_classes.sql
5. insert_class_allocation.sql
6. insert_students.sql
7. insert_parents.sql
8. creare trigger: t_examination.sql
9. creare rutina MySQL Workbench: add_examination.sql
10. insert_examination.sql
11. creare rutina: get_classes_by_teachers.sql
12. creare trigger: t_teacher.sql 
13. adaugare restul rutinelor 

# Backend 

# Frontend


 

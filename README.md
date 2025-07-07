# DATOS COMPANIA
## README

Instrucciones para correr el proyecto:

* Ruby version 3.4.4
* Rails version 8.0.2

### Ejecucion
* Requerimientos
  *  Git
  *  Docker
### Instrucciones
  ```
  git clone https://github.com/2DMore/datoscompania
  cd datoscompania
  sudo apt install docker.io
  sudo docker build -t datos_compania .
  ```
* Pedir MASTER KEY
  ```
  sudo docker run -d -p 8081:8081 --name datos_compania -e RAILS_MASTER_KEY="<MASTER_KEY>" datos_compania
  sudo docker exec -it datos_compania ./bin/rails db:prepare
  ```
### Ejecutar pruebas
```
sudo docker exec -it datos_compania ./bin/rails test
```

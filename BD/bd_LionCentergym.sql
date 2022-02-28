-- ---------------------------------------------------- --
-- ............... SCRIP BD lionCenterGYM ................. --
-- ............ Author: GOLDEN SOLUTIONS SOFTWARE.  Version 1.0 .............. --
-- ---------------------------------------------------- --

CREATE DATABASE lionCenterGYM;
use lioncentergym;
DROP database lionCenterGYM;
-- Esta tabla crea la entidad PERSONA
create table persona
(
    idPersona           INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre              VARCHAR(65) NOT NULL DEFAULT '',
    apellidoPaterno     VARCHAR(65) NOT NULL DEFAULT '',
    apellidoMaterno     VARCHAR(65) NOT NULL DEFAULT '',
    genero              VARCHAR(2)  NOT NULL DEFAULT 'O',
    domicilio           VARCHAR(200) NOT NULL DEFAULT '',
    telefono            VARCHAR(20) NOT NULL DEFAULT '',
    correo              VARCHAR(200) NOT NULL DEFAULT '',
    foto 				LONGTEXT 
);

-- Esta tabla crea la entidad SUCURSAL
create table sucursal(
	idSucursal 			INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre 				 VARCHAR(30),
    direccion 			 VARCHAR(30),
    latitud 		     FLOAT,
	longitud 		     FLOAT,
    estatus 			 INT NOT NULL  -- EL ESTATUS ES 1= ACTIVO 0=INACTIVO
);

-- Esta tabla crea la entidad PRODUCTO
create table producto(
	idProducto			 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre 		         VARCHAR(30) ,
    cantidad			 INT ,
    precioVenta		     FLOAT,
    decripcion		     TEXT,
    foto 				longtext,
    estatus 			 INT NOT NULL  -- EL ESTATUS ES 1= ACTIVO 0=INACTIVO
);

-- Esta tabla crea la entidad HORARIOS
create table horario(
	idHorario			 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    horaInicio 		     VARCHAR(10) ,
    horaTermino 		 VARCHAR(10) 
);

-- Esta tabla crea la entidad USUARIO
create table usuario(
	idUsuario			 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombreUsuario 		 VARCHAR(48)  NOT NULL ,
    contrasenia			 VARCHAR(48) NOT NULL DEFAULT '',
    token				 TEXT,
    rol					 VARCHAR(24) NOT NULL
    
);

-- Esta tabla crea la entidad SUSCRIPCION
CREATE TABLE suscripcion(
         idSuscripcion  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
         tipoSuscripcion     INT ,  -- 1= Vstita 2= Semanal 3-= Mensual 4= Anual
         costo 				float,
         fechaSuscripcion    date
);

-- Esta tabla crea la entidad SALON
create table salon(
	idSalon			 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre		             VARCHAR(30)  NOT NULL ,
    descripcion				 TEXT,
    foto                    longtext,
    estatus					 INT NOT NULL,  -- EL ESTATUS ES 1= ACTIVO 0=INACTIVO
    idSucursal 				 INT,
     CONSTRAINT  fk_salon_sucursal  FOREIGN KEY (idSucursal) 
                REFERENCES sucursal(idSucursal) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Esta tabla crea la entidad EQUIPO
create table equipo(
	idEquipo			 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre		             VARCHAR(30)  NOT NULL ,
    cantidad				 INT,
    descripcion				 TEXT,
    foto					longtext,
    estatus					 INT NOT NULL,  -- EL ESTATUS ES 1= ACTIVO 0=INACTIVO
    idSalon 				 INT,
     CONSTRAINT  fk_equipo_salon  FOREIGN KEY (idSalon) 
                REFERENCES salon(idSalon) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Esta tabla crea la entidad EMPLEADO
create table empleado(
	idEmpleado			 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numEmpleado 		 VARCHAR(15),
    rfc 				 VARCHAR(14),
    puesto				 VARCHAR(30),
    estatus 			 INT NOT NULL,  -- EL ESTATUS ES 1= ACTIVO 0=INACTIVO
    idPersona			INT,
    idUsuario			int,
     CONSTRAINT  fk_empleado_persona  FOREIGN KEY (idPersona) 
                REFERENCES persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE,
     CONSTRAINT  fk_empleado_usuario  FOREIGN KEY (idUsuario) 
                REFERENCES usuario(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Esta tabla crea la entidad CLASE
create table clase(
	idClase			 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre		 		 VARCHAR(30),
    fecha				 DATE,
    estatus 			 INT NOT NULL,  -- EL ESTATUS ES 1= ACTIVO 0=INACTIVO
    idSalon				int,
    idEmpleado			int,
     CONSTRAINT  fk_clase_salon  FOREIGN KEY (idSalon) 
                REFERENCES salon(idSalon) ON DELETE CASCADE ON UPDATE CASCADE,
     CONSTRAINT  fk_clase_empleado  FOREIGN KEY (idEmpleado) 
                REFERENCES empleado(idEmpleado) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Esta tabla crea la entidad CLASE HORARIO
CREATE TABLE clase_horario(
			 idClase int,
			 idHorario int,
              CONSTRAINT  fk_claseHorario_clase  FOREIGN KEY (idClase) 
                REFERENCES clase(idClase) ON DELETE CASCADE ON UPDATE CASCADE,
     CONSTRAINT  fk_claseHorario_horario  FOREIGN KEY (idHorario) 
                REFERENCES horario(idHorario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Esta tabla crea la entidad SALON HORARIO
CREATE TABLE salon_horario(
			 idSalon int,
			 idHorario int,
	CONSTRAINT  fk_salonHorario_salon  FOREIGN KEY (idSalon) 
                REFERENCES salon(idSalon) ON DELETE CASCADE ON UPDATE CASCADE,
     CONSTRAINT  fk_salonHorario_horario  FOREIGN KEY (idHorario) 
                REFERENCES horario(idHorario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Esta tabla crea la entidad CLIENTE
create table cliente(
	idCliente			INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numeroUnico 		INT,
    peso 				INT ,
    estatura		    FLOAT,
    estatus 			INT NOT NULL,  -- EL ESTATUS ES 1= ACTIVO 0=INACTIVO
    idPersona			INT,
    idUsuario			int,
    idSuscripcion		INT,
     CONSTRAINT  fk_cliente_persona  FOREIGN KEY (idPersona) 
                REFERENCES persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE,
     CONSTRAINT  fk_cliente_usuario  FOREIGN KEY (idUsuario) 
                REFERENCES usuario(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT  fk_cliente_suscripcion  FOREIGN KEY (idSuscripcion) 
                REFERENCES suscripcion(idSuscripcion) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Cambiar la estatura a float y el peso a int y insertar campo qr a  cliente




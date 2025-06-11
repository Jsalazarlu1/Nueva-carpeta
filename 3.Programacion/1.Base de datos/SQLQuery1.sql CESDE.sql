CREATE DATABASE CESDE;
GO

USE CESDE;

CREATE TABLE Escuelas (
    id_escuela INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(MAX),
    estado BIT
);

CREATE TABLE Programas (
    id_programa INT PRIMARY KEY,
    id_escuela INT,
    nombre VARCHAR(150),
    descripcion VARCHAR(MAX),
    duracion_semestres INT,
    estado BIT,
    FOREIGN KEY (id_escuela) REFERENCES Escuelas(id_escuela)
);

CREATE TABLE Sedes (
    id_sede INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(150),
    ciudad VARCHAR(100),
    estado BIT
);

CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    tipo_documento VARCHAR(20),
    documento VARCHAR(30),
    primer_nombre VARCHAR(50),
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50),
    segundo_apellido VARCHAR(50),
    correo VARCHAR(100),
    telefono VARCHAR(30),
    direccion VARCHAR(150),
    ciudad VARCHAR(100),
    estado BIT
);

CREATE TABLE Roles (
    id_rol INT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE Usuario_Rol (
    id_usuario INT,
    id_rol INT,
    fecha_asignacion DATE,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

CREATE TABLE Semestres (
    id_semestre INT PRIMARY KEY,
    numero INT,
    descripcion VARCHAR(100),
    estado BIT
);

CREATE TABLE Submodulos (
    id_submodulo INT PRIMARY KEY,
    id_programa INT,
    id_semestre INT,
    nombre VARCHAR(100),
    descripcion VARCHAR(MAX),
    estado BIT,
    FOREIGN KEY (id_programa) REFERENCES Programas(id_programa),
    FOREIGN KEY (id_semestre) REFERENCES Semestres(id_semestre)
);

CREATE TABLE Docente_Submodulo (
    id_submodulo INT,
    id_usuario INT,
    PRIMARY KEY (id_submodulo, id_usuario),
    FOREIGN KEY (id_submodulo) REFERENCES Submodulos(id_submodulo),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Jornadas (
    id_jornada INT PRIMARY KEY,
    nombre VARCHAR(50),
    estado BIT
);

CREATE TABLE Grupos (
    id_grupo INT PRIMARY KEY,
    id_programa INT,
    id_sede INT,
    id_jornada INT,
    codigo_grupo VARCHAR(20),
    semestre INT,
    estado BIT,
    FOREIGN KEY (id_programa) REFERENCES Programas(id_programa),
    FOREIGN KEY (id_sede) REFERENCES Sedes(id_sede),
    FOREIGN KEY (id_jornada) REFERENCES Jornadas(id_jornada)
);

CREATE TABLE Matriculas (
    id_matricula INT PRIMARY KEY,
    id_usuario INT,
    id_grupo INT,
    fecha_matricula DATE,
    estado BIT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_grupo) REFERENCES Grupos(id_grupo)
);

CREATE TABLE Matricula_Submodulo (
    id_matricula_submodulo INT PRIMARY KEY,
    id_matricula INT,
    id_submodulo INT,
    periodo_academico VARCHAR(20),
    estado BIT,
    FOREIGN KEY (id_matricula) REFERENCES Matriculas(id_matricula),
    FOREIGN KEY (id_submodulo) REFERENCES Submodulos(id_submodulo)
);

CREATE TABLE Horarios (
    id_horario INT PRIMARY KEY,
    id_grupo INT,
    id_submodulo INT,
    dia_semana VARCHAR(20),
    hora_inicio TIME,
    hora_fin TIME,
    FOREIGN KEY (id_grupo) REFERENCES Grupos(id_grupo),
    FOREIGN KEY (id_submodulo) REFERENCES Submodulos(id_submodulo)
);

CREATE TABLE Momentos (
    id_momento INT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(MAX)
);

CREATE TABLE Notas (
    id_nota INT PRIMARY KEY,
    id_matricula_submodulo INT,
    id_momento INT,
    nota1 DECIMAL(4,2),
    nota2 DECIMAL(4,2),
    nota3 DECIMAL(4,2),
    promedio_final DECIMAL(4,2),
    FOREIGN KEY (id_matricula_submodulo) REFERENCES Matricula_Submodulo(id_matricula_submodulo),
    FOREIGN KEY (id_momento) REFERENCES Momentos(id_momento)
);

CREATE TABLE Asistencias (
    id_asistencia INT PRIMARY KEY,
    id_matricula_submodulo INT,
    fecha DATE,
    estado_asistencia BIT,
    FOREIGN KEY (id_matricula_submodulo) REFERENCES Matricula_Submodulo(id_matricula_submodulo)
);

CREATE TABLE Inasistencias_Acumuladas (
    id_inasistencia INT PRIMARY KEY,
    id_matricula_submodulo INT,
    cantidad_total INT,
    FOREIGN KEY (id_matricula_submodulo) REFERENCES Matricula_Submodulo(id_matricula_submodulo)
);

INSERT INTO Escuelas (id_escuela, nombre, descripcion, estado) VALUES
(1, 'Escuela de Ingenier�a', 'Formaci�n en �reas de software, hardware y redes.', 1),
(2, 'Escuela de Dise�o', 'Formaci�n en dise�o gr�fico, industrial y digital.', 1),
(3, 'Escuela de Administraci�n', 'Formaci�n en administraci�n y negocios.', 1),
(4, 'Escuela de Salud', 'Programas t�cnicos en salud y atenci�n al paciente.', 1),
(5, 'Escuela de Idiomas', 'Programas de formaci�n en lenguas extranjeras.', 1);

INSERT INTO Programas (id_programa, id_escuela, nombre, descripcion, duracion_semestres, estado) VALUES
(1, 1, 'Tecnolog�a en Desarrollo de Software', 'Programa enfocado en programaci�n y bases de datos.', 6, 1),
(2, 1, 'T�cnico en Redes y Telecomunicaciones', 'Configuraci�n de redes y mantenimiento de equipos.', 4, 1),
(3, 2, 'Dise�o Gr�fico Digital', 'Manejo de herramientas gr�ficas y dise�o publicitario.', 6, 1),
(4, 3, 'Gesti�n Administrativa', 'Formaci�n para asistencia y gesti�n empresarial.', 4, 1),
(5, 4, 'Auxiliar de Enfermer�a', 'Atenci�n b�sica a pacientes y primeros auxilios.', 4, 1),
(6, 5, 'Ingl�s Conversacional', 'Desarrollo de habilidades orales y escritas en ingl�s.', 3, 1);

INSERT INTO Sedes (id_sede, nombre, direccion, ciudad, estado) VALUES
(1, 'Sede Principal', 'Cra 45 #53-24', 'Medell�n', 1),
(2, 'Sede Norte', 'Cl 77 #64-89', 'Bello', 1),
(3, 'Sede Sur', 'Cl 48 #29-45', 'Envigado', 1);

INSERT INTO Usuarios (id_usuario, tipo_documento, documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, correo, telefono, direccion, ciudad, estado) VALUES
(1, 'CC', '100000001', 'Juan', 'Carlos', 'P�rez', 'G�mez', 'juan.perez@cesde.edu.co', '3001112233', 'Cra 40 #50-20', 'Medell�n', 1),
(2, 'CC', '100000002', 'Mar�a', 'Alejandra', 'Garc�a', 'L�pez', 'maria.garcia@cesde.edu.co', '3012223344', 'Cl 10 #15-55', 'Bello', 1),
(3, 'TI', '100000003', 'Luis', 'Fernando', 'Ram�rez', 'Cano', 'luis.ramirez@cesde.edu.co', '3023334455', 'Cl 20 #25-60', 'Envigado', 1),
(4, 'CC', '100000004', 'Ana', 'Milena', 'Torres', 'Zapata', 'ana.torres@cesde.edu.co', '3034445566', 'Cra 80 #35-40', 'Medell�n', 1),
(5, 'CC', '100000005', 'Carlos', 'Andr�s', 'Mej�a', 'Ortiz', 'carlos.mejia@cesde.edu.co', '3045556677', 'Cl 12 #45-20', 'Bello', 1),
(6, 'CC', '100000006', 'Laura', 'Vanessa', 'R�os', 'Salazar', 'laura.rios@cesde.edu.co', '3056667788', 'Cl 50 #60-33', 'Envigado', 1),
(7, 'TI', '100000007', 'Pedro', 'Jos�', 'Mart�nez', 'Henao', 'pedro.martinez@cesde.edu.co', '3067778899', 'Cra 70 #12-90', 'Medell�n', 1),
(8, 'CC', '100000008', 'Sof�a', 'Isabel', 'Herrera', 'Moreno', 'sofia.herrera@cesde.edu.co', '3078889900', 'Cl 25 #33-10', 'Bello', 1),
(9, 'CC', '100000009', 'Miguel', '�ngel', 'Zapata', 'Quintero', 'miguel.zapata@cesde.edu.co', '3089990011', 'Cra 60 #45-67', 'Medell�n', 1),
(10, 'TI', '100000010', 'Daniela', 'Mariana', 'Restrepo', 'Su�rez', 'daniela.restrepo@cesde.edu.co', '3090001122', 'Cl 40 #55-88', 'Envigado', 1);

INSERT INTO dbo.Usuarios(id_usuario, tipo_documento, documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, correo, telefono, direccion, ciudad, estado)
VALUES
(12, 'CC', '100000012', 'Camila', 'Andrea', 'González', 'Pérez', 'camila.gonzalez@cesde.edu.co', '3100011122', 'Cl 12 #34-56', 'Medellín', 1),
(13, 'CC', '100000013', 'Felipe', 'Esteban', 'Marín', 'Gómez', 'felipe.marin@cesde.edu.co', '3100011123', 'Cra 56 #23-78', 'Medellín', 1),
(14, 'TI', '100000014', 'Valentina', 'María', 'Restrepo', 'Salazar', 'valentina.restrepo@cesde.edu.co', '3100011124', 'Cl 45 #20-90', 'Bello', 1),
(15, 'CC', '100000015', 'Samuel', 'Andrés', 'Mejía', 'Zapata', 'samuel.mejia@cesde.edu.co', '3100011125', 'Cra 50 #34-76', 'Envigado', 1),
(16, 'CC', '100000016', 'Isabela', 'Lucía', 'Cardona', 'López', 'isabela.cardona@cesde.edu.co', '3100011126', 'Cl 20 #67-89', 'Medellín', 1),
(17, 'TI', '100000017', 'Juan', 'David', 'Sánchez', 'Moreno', 'juan.sanchez@cesde.edu.co', '3100011127', 'Cra 25 #45-12', 'Bello', 1),
(18, 'CC', '100000018', 'Mariana', 'Sofía', 'Castro', 'Ramírez', 'mariana.castro@cesde.edu.co', '3100011128', 'Cl 33 #76-54', 'Medellín', 1),
(19, 'CC', '100000019', 'Andrés', 'Felipe', 'Hernández', 'García', 'andres.hernandez@cesde.edu.co', '3100011129', 'Cra 78 #12-34', 'Envigado', 1),
(20, 'CC', '100000020', 'Laura', 'Daniela', 'Ortiz', 'Jiménez', 'laura.ortiz@cesde.edu.co', '3100011130', 'Cl 16 #43-21', 'Bello', 1),
(21, 'TI', '100000021', 'Tomás', 'Julián', 'Zuluaga', 'Martínez', 'tomas.zuluaga@cesde.edu.co', '3100011131', 'Cra 55 #23-44', 'Medellín', 1),
(22, 'CC', '100000022', 'Luciana', 'Valeria', 'Ruiz', 'Castillo', 'luciana.ruiz@cesde.edu.co', '3100011132', 'Cl 77 #89-01', 'Envigado', 1),
(23, 'CC', '100000023', 'Emiliano', 'José', 'Ríos', 'Ortiz', 'emiliano.rios@cesde.edu.co', '3100011133', 'Cra 34 #66-78', 'Medellín', 1),
(24, 'TI', '100000024', 'Daniela', 'Victoria', 'Montoya', 'Castaño', 'daniela.montoya@cesde.edu.co', '3100011134', 'Cl 90 #11-45', 'Bello', 1),
(25, 'CC', '100000025', 'Santiago', 'Alejandro', 'López', 'Ramos', 'santiago.lopez@cesde.edu.co', '3100011135', 'Cra 65 #23-56', 'Medellín', 1),
(26, 'CC', '100000026', 'Antonella', 'Gabriela', 'Vélez', 'Salas', 'antonella.velez@cesde.edu.co', '3100011136', 'Cl 19 #56-43', 'Envigado', 1),
(27, 'TI', '100000027', 'Martín', 'Iván', 'Ospina', 'Zapata', 'martin.ospina@cesde.edu.co', '3100011137', 'Cra 30 #50-11', 'Bello', 1),
(28, 'CC', '100000028', 'Emma', 'Isabel', 'Giraldo', 'Restrepo', 'emma.giraldo@cesde.edu.co', '3100011138', 'Cl 61 #12-87', 'Medellín', 1),
(29, 'CC', '100000029', 'Maximiliano', 'David', 'Londoño', 'Arias', 'max.londono@cesde.edu.co', '3100011139', 'Cra 48 #23-54', 'Medellín', 1),
(30, 'TI', '100000030', 'Sara', 'Juliana', 'Acevedo', 'Giraldo', 'sara.acevedo@cesde.edu.co', '3100011140', 'Cl 37 #60-25', 'Bello', 1),
(31, 'CC', '100000031', 'Agustín', 'Elías', 'Morales', 'Valencia', 'agustin.morales@cesde.edu.co', '3100011141', 'Cra 41 #10-90', 'Medellín', 1),
(32, 'CC', '100000032', 'Regina', 'Estefanía', 'Arango', 'Torres', 'regina.arango@cesde.edu.co', '3100011142', 'Cl 44 #23-55', 'Envigado', 1),
(33, 'TI', '100000033', 'Thiago', 'Enrique', 'Gómez', 'Cardona', 'thiago.gomez@cesde.edu.co', '3100011143', 'Cra 90 #11-34', 'Medellín', 1),
(34, 'CC', '100000034', 'Zoe', 'Natalia', 'Salazar', 'Guzmán', 'zoe.salazar@cesde.edu.co', '3100011144', 'Cl 66 #23-98', 'Bello', 1),
(35, 'CC', '100000035', 'Gabriel', 'Sebastián', 'Betancur', 'Ríos', 'gabriel.betancur@cesde.edu.co', '3100011145', 'Cra 22 #34-67', 'Medellín', 1),
(36, 'TI', '100000036', 'Julieta', 'Marina', 'Henao', 'Urrego', 'julieta.henao@cesde.edu.co', '3100011146', 'Cl 49 #78-12', 'Medellín', 1),
(37, 'CC', '100000037', 'Benjamín', 'Lucas', 'Gaviria', 'Mejía', 'benjamin.gaviria@cesde.edu.co', '3100011147', 'Cra 18 #67-34', 'Envigado', 1),
(38, 'CC', '100000038', 'Victoria', 'Paula', 'Molina', 'Hernández', 'victoria.molina@cesde.edu.co', '3100011148', 'Cl 52 #11-87', 'Bello', 1),
(39, 'TI', '100000039', 'Joaquín', 'Isaías', 'Bermúdez', 'Cano', 'joaquin.bermudez@cesde.edu.co', '3100011149', 'Cra 80 #21-65', 'Medellín', 1),
(40, 'CC', '100000040', 'Renata', 'Alejandra', 'Navarro', 'Correa', 'renata.navarro@cesde.edu.co', '3100011150', 'Cl 29 #66-77', 'Medellín', 1),
(41, 'CC', '100000041', 'Dylan', 'Mateo', 'Quintero', 'Jiménez', 'dylan.quintero@cesde.edu.co', '3100011151', 'Cra 33 #88-21', 'Bello', 1),
(42, 'TI', '100000042', 'Allison', 'Camila', 'Rueda', 'Moreno', 'allison.rueda@cesde.edu.co', '3100011152', 'Cl 71 #33-12', 'Envigado', 1),
(43, 'CC', '100000043', 'Iván', 'Samuel', 'Zúñiga', 'Patiño', 'ivan.zuniga@cesde.edu.co', '3100011153', 'Cra 27 #45-98', 'Medellín', 1),
(44, 'CC', '100000044', 'Paula', 'Esther', 'Carrillo', 'Luna', 'paula.carrillo@cesde.edu.co', '3100011154', 'Cl 34 #90-76', 'Bello', 1),
(45, 'TI', '100000045', 'Ángel', 'Nicolás', 'Galeano', 'Ríos', 'angel.galeano@cesde.edu.co', '3100011155', 'Cra 56 #44-33', 'Envigado', 1),
(46, 'CC', '100000046', 'Salomé', 'Teresa', 'Montes', 'Zapata', 'salome.montes@cesde.edu.co', '3100011156', 'Cl 78 #12-67', 'Medellín', 1),
(47, 'CC', '100000047', 'Bruno', 'Matías', 'Tamayo', 'Sierra', 'bruno.tamayo@cesde.edu.co', '3100011157', 'Cra 39 #56-21', 'Bello', 1),
(48, 'TI', '100000048', 'Luna', 'Elena', 'Valencia', 'García', 'luna.valencia@cesde.edu.co', '3100011158', 'Cl 19 #23-45', 'Envigado', 1),
(49, 'CC', '100000049', 'Simón', 'Manuel', 'Herrera', 'Montoya', 'simon.herrera@cesde.edu.co', '3100011159', 'Cra 60 #30-12', 'Medellín', 1),
(50, 'CC', '100000050', 'María', 'Antonia', 'Duque', 'López', 'maria.duque@cesde.edu.co', '3100011160', 'Cl 42 #67-54', 'Bello', 1),
(51, 'TI', '100000051', 'Cristóbal', 'Andrés', 'Mendoza', 'Ruiz', 'cristobal.mendoza@cesde.edu.co', '3100011161', 'Cra 88 #12-76', 'Envigado', 1);




INSERT INTO Roles (id_rol, nombre) VALUES
(1, 'Estudiante'),
(2, 'Docente'),
(3, 'Coordinador'),
(4, 'Administrador');

INSERT INTO Usuario_Rol (id_usuario, id_rol, fecha_asignacion) VALUES
(1, 1, '2024-01-15'),
(2, 1, '2024-01-15'),
(3, 1, '2024-01-15'),
(4, 1, '2024-01-15'),
(5, 1, '2024-01-15'),
(6, 1, '2024-01-15'),
(7, 1, '2024-01-15'),
(8, 2, '2023-12-01'), -- docente
(9, 2, '2023-12-01'), -- docente
(10, 2, '2023-12-01'); -- docente

INSERT INTO Semestres (id_semestre, numero, descripcion, estado) VALUES
(1, 1, 'Primer semestre', 1),
(2, 2, 'Segundo semestre', 1),
(3, 3, 'Tercer semestre', 1),
(4, 4, 'Cuarto semestre', 1),
(5, 5, 'Quinto semestre', 1),
(6, 6, 'Sexto semestre', 1);

INSERT INTO Submodulos (id_submodulo, id_programa, id_semestre, nombre, descripcion, estado) VALUES
(1, 1, 1, 'Fundamentos de Programaci�n', 'L�gica, algoritmos y estructuras b�sicas.', 1),
(2, 1, 2, 'Bases de Datos', 'Dise�o y uso de bases de datos relacionales.', 1),
(3, 1, 3, 'Programaci�n Web', 'Desarrollo de sitios con HTML, CSS y JS.', 1),
(4, 2, 1, 'Redes B�sicas', 'Topolog�as, protocolos y cableado.', 1),
(5, 3, 1, 'Dise�o Digital', 'Introducci�n a herramientas gr�ficas.', 1),
(6, 4, 1, 'Contabilidad B�sica', 'Principios contables y financieros.', 1),
(7, 5, 1, 'Primeros Auxilios', 'Atenci�n inicial en situaciones de emergencia.', 1),
(8, 6, 1, 'Ingl�s A1', 'Expresiones b�sicas y saludos.', 1);

INSERT INTO Docente_Submodulo (id_submodulo, id_usuario) VALUES
(1, 8),
(2, 8),
(3, 8),
(4, 9),
(5, 9),
(6, 9),
(7, 10),
(8, 10);

INSERT INTO Jornadas (id_jornada, nombre, estado) VALUES
(1, 'Ma�ana', 1),
(2, 'Tarde', 1),
(3, 'Noche', 1);

INSERT INTO Grupos (id_grupo, id_programa, id_sede, id_jornada, codigo_grupo, semestre, estado) VALUES
(1, 1, 1, 1, 'DSW101', 1, 1),
(2, 1, 1, 2, 'DSW102', 2, 1),
(3, 2, 2, 1, 'RT101', 1, 1),
(4, 3, 1, 3, 'DG101', 1, 1),
(5, 4, 3, 1, 'GA101', 1, 1);

INSERT INTO Matriculas (id_matricula, id_usuario, id_grupo, fecha_matricula, estado) VALUES
(1, 1, 1, '2024-02-01', 1),
(2, 2, 1, '2024-02-01', 1),
(3, 3, 2, '2024-02-02', 1),
(4, 4, 2, '2024-02-02', 1),
(5, 5, 3, '2024-02-03', 1),
(6, 6, 4, '2024-02-04', 1),
(7, 7, 5, '2024-02-05', 1);

INSERT INTO Matricula_Submodulo (id_matricula_submodulo, id_matricula, id_submodulo, periodo_academico, estado) VALUES
(1, 1, 1, '2024-1', 1),
(2, 2, 1, '2024-1', 1),
(3, 3, 2, '2024-1', 1),
(4, 4, 2, '2024-1', 1),
(5, 5, 4, '2024-1', 1),
(6, 6, 5, '2024-1', 1),
(7, 7, 6, '2024-1', 1);

INSERT INTO Horarios (id_horario, id_grupo, id_submodulo, dia_semana, hora_inicio, hora_fin) VALUES
(1, 1, 1, 'Lunes', '08:00', '10:00'),
(2, 2, 2, 'Martes', '10:00', '12:00'),
(3, 3, 4, 'Mi�rcoles', '14:00', '16:00'),
(4, 4, 5, 'Jueves', '18:00', '20:00'),
(5, 5, 6, 'Viernes', '08:00', '10:00');

INSERT INTO Momentos (id_momento, nombre, descripcion) VALUES
(1, 'Parcial 1', 'Evaluaci�n del primer corte.'),
(2, 'Parcial 2', 'Evaluaci�n del segundo corte.'),
(3, 'Trabajo Final', 'Entrega final del curso.');

INSERT INTO Notas (id_nota, id_matricula_submodulo, id_momento, nota1, nota2, nota3, promedio_final) VALUES
(1, 1, 1, 3.5, 4.0, 4.2, 3.9),
(2, 2, 1, 4.0, 4.5, 4.7, 4.4),
(3, 3, 1, 3.0, 3.2, 3.4, 3.2),
(4, 4, 1, 2.8, 3.0, 3.1, 3.0),
(5, 5, 1, 4.0, 3.9, 4.1, 4.0),
(6, 6, 1, 4.5, 4.6, 4.7, 4.6),
(7, 7, 1, 3.5, 3.6, 3.7, 3.6);

INSERT INTO Asistencias (id_asistencia, id_matricula_submodulo, fecha, estado_asistencia) VALUES
(1, 1, '2024-03-01', 1),
(2, 1, '2024-03-08', 1),
(3, 2, '2024-03-01', 0),
(4, 2, '2024-03-08', 1),
(5, 3, '2024-03-01', 1),
(6, 4, '2024-03-01', 0),
(7, 5, '2024-03-02', 1),
(8, 6, '2024-03-02', 1),
(9, 7, '2024-03-02', 0);

INSERT INTO Inasistencias_Acumuladas (id_inasistencia, id_matricula_submodulo, cantidad_total) VALUES
(1, 1, 0),
(2, 2, 1),
(3, 3, 0),
(4, 4, 1),
(5, 5, 0),
(6, 6, 0),
(7, 7, 1);

SELECT TOP 10 * FROM Escuelas;
SELECT TOP 10 * FROM Programas;
SELECT TOP 10 * FROM Sedes;
SELECT TOP 10 * FROM Usuarios;
SELECT TOP 10 * FROM Roles;
SELECT TOP 10 * FROM Usuario_Rol;
SELECT TOP 10 * FROM Semestres;
SELECT TOP 10 * FROM Submodulos;
SELECT TOP 10 * FROM Docente_Submodulo;
SELECT TOP 10 * FROM Jornadas;
SELECT TOP 10 * FROM Grupos;
SELECT TOP 10 * FROM Matriculas;
SELECT TOP 10 * FROM Matricula_Submodulo;
SELECT TOP 10 * FROM Horarios;
SELECT TOP 10 * FROM Momentos;
SELECT TOP 10 * FROM Notas;
SELECT TOP 10 * FROM Asistencias;
SELECT TOP 10 * FROM Inasistencias_Acumuladas;
--Mostrar estudiantes con su programa y escuela:
SELECT 
    u.primer_nombre + ' ' + u.primer_apellido AS nombre_estudiante,
    p.nombre AS nombre_programa,
    e.nombre AS nombre_escuela
FROM Usuarios u
JOIN Matriculas m ON u.id_usuario = m.id_usuario
JOIN Grupos g ON m.id_grupo = g.id_grupo
JOIN Programas p ON g.id_programa = p.id_programa
JOIN Escuelas e ON p.id_escuela = e.id_escuela
WHERE u.estado = 1 AND p.estado = 1;
--Obtener submódulos con su docente asignado:
SELECT 
    s.nombre AS submodulo,
    u.primer_nombre + ' ' + u.primer_apellido AS docente
FROM Submodulos s
JOIN Docente_Submodulo ds ON s.id_submodulo = ds.id_submodulo
JOIN Usuarios u ON ds.id_usuario = u.id_usuario
WHERE s.estado = 1;
--Ver notas de los estudiantes con nombre del submódulo y momento de evaluación:
SELECT 
    u.primer_nombre + ' ' + u.primer_apellido AS estudiante,
    sm.nombre AS submodulo,
    mo.nombre AS momento,
    n.promedio_final
FROM Notas n
JOIN Matricula_Submodulo ms ON n.id_matricula_submodulo = ms.id_matricula_submodulo
JOIN Matriculas m ON ms.id_matricula = m.id_matricula
JOIN Usuarios u ON m.id_usuario = u.id_usuario
JOIN Submodulos sm ON ms.id_submodulo = sm.id_submodulo
JOIN Momentos mo ON n.id_momento = mo.id_momento
ORDER BY estudiante;

--Cantidad de estudiantes por programa:
SELECT 
    p.nombre AS programa,
    COUNT(m.id_matricula) AS cantidad_estudiantes
FROM Matriculas m
JOIN Grupos g ON m.id_grupo = g.id_grupo
JOIN Programas p ON g.id_programa = p.id_programa
GROUP BY p.nombre;

--Submódulos con su grupo y horario:
SELECT 
    g.codigo_grupo,
    s.nombre AS submodulo,
    h.dia_semana,
    h.hora_inicio,
    h.hora_fin
FROM Horarios h
JOIN Grupos g ON h.id_grupo = g.id_grupo
JOIN Submodulos s ON h.id_submodulo = s.id_submodulo;
--Estudiantes con inasistencias acumuladas (más de 0):
SELECT 
    u.primer_nombre + ' ' + u.primer_apellido AS estudiante,
    ia.cantidad_total
FROM Inasistencias_Acumuladas ia
JOIN Matricula_Submodulo ms ON ia.id_matricula_submodulo = ms.id_matricula_submodulo
JOIN Matriculas m ON ms.id_matricula = m.id_matricula
JOIN Usuarios u ON m.id_usuario = u.id_usuario
WHERE ia.cantidad_total > 0;

--estudiantes por ciudad
SELECT * FROM Usuarios WHERE ciudad = 'Medellín';

--estudiantes por nombre
SELECT * FROM Usuarios
WHERE primer_nombre LIKE '% %';

--Usuarios activos e inactivos
SELECT estado, COUNT(*) AS cantidad
FROM Usuarios
GROUP BY estado;






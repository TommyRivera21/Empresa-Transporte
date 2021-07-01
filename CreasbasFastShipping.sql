/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLI_ID               INT4                 not null,
   CLI_CEDULA           VARCHAR(100)         not null,
   CLI_NOMBRES          VARCHAR(100)         not null,
   CLI_APELLIDOS        VARCHAR(100)         not null,
   CLI_CELULAR          VARCHAR(100)         not null,
   CLI_CORREO_ELECTRONICO VARCHAR(100)         not null,
   CLI_DIRECCION        VARCHAR(100)         not null,
   CLI_CIUDAD           VARCHAR(100)         not null,
   CLI_PROVINCIA        VARCHAR(100)         not null,
   CLI_NOMBRE_EMPRESA   VARCHAR(100)         not null,
   constraint PK_CLIENTE primary key (CLI_ID)
);

/*==============================================================*/
/* Table: COMPROBANTE_PAGO                                      */
/*==============================================================*/
create table COMPROBANTE_PAGO (
   CP_ID                INT4                 not null,
   TRANS_ID             INT4                 null,
   VEHICULO_ID          INT4                 null,
   CP_FECHA_PAGO        VARCHAR(100)         not null,
   CP_VALOR_PAGO_VEHICULOS MONEY                not null,
   CP_TRANSPORTISTAS    MONEY                not null,
   constraint PK_COMPROBANTE_PAGO primary key (CP_ID)
);

/*==============================================================*/
/* Table: COSTOS                                                */
/*==============================================================*/
create table COSTOS (
   CENV_ID              INT4                 not null,
   CENV_PESO            VARCHAR(100)         not null,
   CENV_TRAYECTO        VARCHAR(100)         not null,
   CENV_PRECIOS         MONEY                not null,
   constraint PK_COSTOS primary key (CENV_ID)
);

/*==============================================================*/
/* Table: DESTINATARIO                                          */
/*==============================================================*/
create table DESTINATARIO (
   DES_ID               INT4                 not null,
   DES_CEDULA           VARCHAR(100)         not null,
   DES_NOMBRES          VARCHAR(100)         not null,
   DES_APELLIDOS        VARCHAR(100)         not null,
   DES_CELULAR          VARCHAR(100)         not null,
   DES_CORREO_ELECTRONICO VARCHAR(100)         not null,
   DES_DIRECCION        VARCHAR(100)         not null,
   DES_CIUDAD           VARCHAR(100)         not null,
   DES_PROVINCIA        VARCHAR(100)         not null,
   constraint PK_DESTINATARIO primary key (DES_ID)
);

/*==============================================================*/
/* Table: ENVIO                                                 */
/*==============================================================*/
create table ENVIO (
   ENV_ID               INT4                 not null,
   CLI_ID               INT4                 null,
   CENV_ID              INT4                 null,
   VEHICULO_ID          INT4                 null,
   TRANS_ID             INT4                 null,
   DES_ID               INT4                 null,
   ENV_FECHA            DATE                 not null,
   ENV_PESO             VARCHAR(100)         not null,
   ENV_DESCRIPCION      VARCHAR(100)         not null,
   ENV_TRAYECTO         VARCHAR(100)         not null,
   ENV_PUNTUACION       VARCHAR(100)         not null,
   ENV_VALOR_PAGO       MONEY                not null,
   constraint PK_ENVIO primary key (ENV_ID)
);

/*==============================================================*/
/* Table: SUCURSAL                                              */
/*==============================================================*/
create table SUCURSAL (
   SUCURSAL_ID          INT4                 not null,
   CLI_ID               INT4                 null,
   ENV_ID               INT4                 null,
   TRANS_ID             INT4                 null,
   VEHICULO_ID          INT4                 null,
   SU_PROVINCIA         VARCHAR(100)         not null,
   SU_CIUDAD            VARCHAR(100)         not null,
   constraint PK_SUCURSAL primary key (SUCURSAL_ID)
);

/*==============================================================*/
/* Table: TRANSPORTISTA                                         */
/*==============================================================*/
create table TRANSPORTISTA (
   TRANS_ID             INT4                 not null,
   TRANS_TIPO_LICENCIA  VARCHAR(100)         not null,
   TRANS_CEDULA         VARCHAR(100)         not null,
   TRANS_NOMBRES        VARCHAR(100)         not null,
   TRANS_APELLIDOS      VARCHAR(100)         not null,
   TRANS_CORREO_ELECTRONICO VARCHAR(100)         not null,
   TRANS_CELULAR        VARCHAR(100)         not null,
   TRANS_ENTREGAS       INT4                 not null,
   constraint PK_TRANSPORTISTA primary key (TRANS_ID)
);

/*==============================================================*/
/* Table: VEHICULO                                              */
/*==============================================================*/
create table VEHICULO (
   VEHICULO_ID          INT4                 not null,
   VEH_PLACA            VARCHAR(100)         not null,
   VEH_MODELO           VARCHAR(100)         not null,
   VEH_TIPO             VARCHAR(100)         not null,
   VEH_AÑO              VARCHAR(100)         not null,
   VEH_CAPACIDAD_CARGA  VARCHAR(100)         not null,
   VEH_PESO_CARGA       VARCHAR(100)         not null,
   VEH_DISTANCIAS_RECORRIDAS VARCHAR(100)    not null,
   VEH_PROPIO           BOOL                 not null,
   constraint PK_VEHICULO primary key (VEHICULO_ID)
);

alter table COMPROBANTE_PAGO
   add constraint FK_COMPROBA_TRANS_CP_TRANSPOR foreign key (TRANS_ID)
      references TRANSPORTISTA (TRANS_ID)
      on delete restrict on update restrict;

alter table COMPROBANTE_PAGO
   add constraint FK_COMPROBA_VEH_CP_VEHICULO foreign key (VEHICULO_ID)
      references VEHICULO (VEHICULO_ID)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_CLI_ENV_CLIENTE foreign key (CLI_ID)
      references CLIENTE (CLI_ID)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_ENV_C_COSTOS foreign key (CENV_ID)
      references COSTOS (CENV_ID)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_ENV_DES_DESTINAT foreign key (DES_ID)
      references DESTINATARIO (DES_ID)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_TRANS_ENV_TRANSPOR foreign key (TRANS_ID)
      references TRANSPORTISTA (TRANS_ID)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_VEH_ENV_VEHICULO foreign key (VEHICULO_ID)
      references VEHICULO (VEHICULO_ID)
      on delete restrict on update restrict;

alter table SUCURSAL
   add constraint FK_SUCURSAL_CLI_SUC_CLIENTE foreign key (CLI_ID)
      references CLIENTE (CLI_ID)
      on delete restrict on update restrict;

alter table SUCURSAL
   add constraint FK_SUCURSAL_SUC_ENV_ENVIO foreign key (ENV_ID)
      references ENVIO (ENV_ID)
      on delete restrict on update restrict;

alter table SUCURSAL
   add constraint FK_SUCURSAL_TRANS_SUC_TRANSPOR foreign key (TRANS_ID)
      references TRANSPORTISTA (TRANS_ID)
      on delete restrict on update restrict;

alter table SUCURSAL
   add constraint FK_SUCURSAL_VEH_SUR_VEHICULO foreign key (VEHICULO_ID)
      references VEHICULO (VEHICULO_ID)
      on delete restrict on update restrict;


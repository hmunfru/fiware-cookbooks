create table Localuser (LOCALUSER_ID integer not null auto_increment unique, LOCALUSER_COMPANY varchar(255), LOCALUSER_EMAIL varchar(255) not null unique, LOCALUSER_PASSWORD varchar(255) not null, LOCALUSER_REGISTRATION_DATE datetime not null, LOCALUSER_USERNAME varchar(255) not null unique, primary key (LOCALUSER_ID)) ENGINE=InnoDB;
create table Rating (RATING_ID integer not null auto_increment unique, RATING_DATE datetime not null, RATING_FEEDBACK varchar(255), RATING_NAME varchar(255), RATING_OBJECT_ID integer not null, primary key (RATING_ID)) ENGINE=InnoDB;
create table RatingCategory (RATING_CATEGORY_ID integer not null auto_increment unique, RATING_CATEGORY_NAME varchar(255) not null, RATING_OBJ_CAT_ID integer not null, primary key (RATING_CATEGORY_ID)) ENGINE=InnoDB;
create table RatingCategoryEntry (RATING_CATEGORY_ENTRY_ID integer not null auto_increment unique, RATING_CATEGORY_ENTRY_VALUE integer not null, RATING_ID integer not null, RATING_CATEGORY_ID integer not null, primary key (RATING_CATEGORY_ENTRY_ID)) ENGINE=InnoDB;
create table RatingObject (RATING_OBJECT_ID integer not null auto_increment unique, RATING_OBJECT_OBJECT_ID varchar(255) not null, RATING_OBJ_CAT_ID integer not null, primary key (RATING_OBJECT_ID)) ENGINE=InnoDB;
create table RatingObjectCategory (RATING_OBJ_CAT_ID integer not null auto_increment unique, RATING_OBJECT_CATEGORY_NAME varchar(255) not null unique, primary key (RATING_OBJ_CAT_ID)) ENGINE=InnoDB;
create table Service (SERVICE_ID integer not null auto_increment unique, SERVICE_DESC varchar(255), SERVICE_NAME varchar(255) not null, SERVICE_REG_DATE datetime, SERVICE_URL varchar(255) not null unique, LOCALUSER_CREATOR_ID integer not null, LOCALUSER_LAST_EDITOR_ID integer not null, STORE_ID integer not null, primary key (SERVICE_ID), unique (SERVICE_NAME, STORE_ID)) ENGINE=InnoDB;
create table Store (STORE_ID integer not null auto_increment unique, STORE_DESC varchar(255), STORE_NAME varchar(255) not null unique, STORE_DATE datetime, STORE_URL varchar(255) not null unique, LOCALUSER_CREATOR_ID integer not null, LOCALUSER_LAST_EDITOR_ID integer not null, primary key (STORE_ID)) ENGINE=InnoDB;
alter table Rating add index FK917A9DBDC96A3395 (RATING_OBJECT_ID), add constraint FK917A9DBDC96A3395 foreign key (RATING_OBJECT_ID) references RatingObject (RATING_OBJECT_ID);
alter table RatingCategory add index FKECF0B1DBE096C108 (RATING_OBJ_CAT_ID), add constraint FKECF0B1DBE096C108 foreign key (RATING_OBJ_CAT_ID) references RatingObjectCategory (RATING_OBJ_CAT_ID);
alter table RatingCategoryEntry add index FK2C8B5757BD17C475 (RATING_CATEGORY_ID), add constraint FK2C8B5757BD17C475 foreign key (RATING_CATEGORY_ID) references RatingCategory (RATING_CATEGORY_ID);
alter table RatingCategoryEntry add index FK2C8B57575DC536FA (RATING_ID), add constraint FK2C8B57575DC536FA foreign key (RATING_ID) references Rating (RATING_ID);
alter table RatingObject add index FKDAB02B5CE096C108 (RATING_OBJ_CAT_ID), add constraint FKDAB02B5CE096C108 foreign key (RATING_OBJ_CAT_ID) references RatingObjectCategory (RATING_OBJ_CAT_ID);
alter table Service add index FKD97C5E95257C978D (LOCALUSER_CREATOR_ID), add constraint FKD97C5E95257C978D foreign key (LOCALUSER_CREATOR_ID) references Localuser (LOCALUSER_ID);
alter table Service add index FKD97C5E9599AF6FC3 (LOCALUSER_LAST_EDITOR_ID), add constraint FKD97C5E9599AF6FC3 foreign key (LOCALUSER_LAST_EDITOR_ID) references Localuser (LOCALUSER_ID);
alter table Service add index FKD97C5E955B467BA (STORE_ID), add constraint FKD97C5E955B467BA foreign key (STORE_ID) references Store (STORE_ID);
alter table Store add index FK4C808C1257C978D (LOCALUSER_CREATOR_ID), add constraint FK4C808C1257C978D foreign key (LOCALUSER_CREATOR_ID) references Localuser (LOCALUSER_ID);
alter table Store add index FK4C808C199AF6FC3 (LOCALUSER_LAST_EDITOR_ID), add constraint FK4C808C199AF6FC3 foreign key (LOCALUSER_LAST_EDITOR_ID) references Localuser (LOCALUSER_ID);
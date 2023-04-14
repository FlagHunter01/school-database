CREATE DATABASE projet; 

USE projet;

DROP TABLE IF EXISTS personne;
CREATE TABLE personne (
    num_client int NOT NULL PRIMARY KEY, 
    nom varchar(30) NOT NULL,
    prenom varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS ville;
CREATE TABLE ville (
    code_postal int NOT NULL PRIMARY KEY,
    nom varchar(30) NOT NULL,
    departement varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS centre;
CREATE TABLE centre (
    identifiant int NOT NULL PRIMARY KEY,
    type_centrale varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS fournisseur;
CREATE TABLE fournisseur (
    nom varchar(45) NOT NULL PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS consomme;
CREATE TABLE consomme (
    id_consommateur int NOT NULL PRIMARY KEY,
    quantite int NOT NULL,
    num_client int NOT NULL,
    id_centre int NOT NULL,
    FOREIGN KEY (num_client) REFERENCES personne(num_client)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (id_centre) REFERENCES centre(identifiant)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS facture;
CREATE TABLE facture (
    num_facture int NOT NULL PRIMARY KEY,
    num_client int NOT NULL,
    nom_fournisseur varchar(45) NOT NULL,
    prix_kWh DECIMAL(1,2) NOT NULL,

    FOREIGN KEY (num_client) REFERENCES personne(num_client)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY  (nom_fournisseur) REFERENCES fournisseur(nom)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS situe;
CREATE TABLE situe (
    identifiant_centre int NOT NULL,
    code_postal int NOT NULL,
    addresse varchar(50) NOT NULL PRIMARY KEY,
    FOREIGN KEY (code_postal) REFERENCES ville(code_postal)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (identifiant_centre) REFERENCES centre(identifiant)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS appartient;
CREATE TABLE appartient (
    contrat int NOT NULL PRIMARY KEY,
    nom_fournisseur varchar(45) NOT NULL,
    identifiant_centre int NOT NULL,
    FOREIGN KEY (identifiant_centre) REFERENCES centre(identifiant)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (nom_fournisseur) REFERENCES fournisseur(nom)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS habite;
CREATE TABLE habite (
    num_client int NOT NULL,
    code_postal int NOT NULL,
    addresse varchar(50) NOT NULL PRIMARY KEY,
    FOREIGN KEY (num_client) REFERENCES personne(num_client)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (code_postal) REFERENCES ville(code_postal)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

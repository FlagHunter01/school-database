
# nombre de Centrales par fourniseur
SELECT appartient.nom_fournisseur as Nom_fournisseur, COUNT(DISTINCT identifiant_centre) as Nombre_de_centrales 
FROM appartient 
GROUP BY appartient.nom_fournisseur; 

# Fournisseurs par département
SELECT DISTINCT fournisseur.nom as Nom_fournisseur, ville.departement as Departement
FROM fournisseur INNER JOIN facture, ville INNER JOIN habite
WHERE facture.num_client = habite.num_client
order by fournisseur.nom ASC, ville.departement ASC


# Départements dans lesquels est distribuée chaque énergie pour le fournisseur 1
SELECT DISTINCT ville.departement, centre.type_centrale
FROM ville, appartient, situe, centre
WHERE STRCMP(appartient.nom_fournisseur, 'fournisseur 1') = 0 
AND centre.identifiant = appartient.identifiant_centre
AND situe.identifiant_centre = appartient.identifiant_centre
AND ville.code_postal = situe.code_postal


# Centres et énergie du fournisseur 1 dans le département // TODO FIXE STRCMP
SELECT DISTINCT centre.identifiant as Identifiant_centre, centre.type_centrale as Type_energie
FROM centre, situe, ville
WHERE situe.code_postal = ville.code_postal
AND ville.departement = 10
AND EXISTS (SELECT centre.identifiant
            FROM centre, appartient
            AND STRCMP(appartient.nom_fournisseur, 'fournisseur 1') = 0
            AND  centre.identifiant = appartient.identifiant_centre)



# Revenu total du dépaertement
SELECT 
FROM facture, ville Inner situe, centre INNer situe
WHERE


# Quantité de chaque énergie distribuée dans chaque département
SELECT
FROM 
WHERE

# Revenu pour chaque énergie dans chaque département
SELECT
FROM 
WHERE
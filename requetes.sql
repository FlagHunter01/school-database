
# nombre de Centrales par fourniseur
SELECT appartient.nom_fournisseur as Nom_fournisseur, COUNT(DISTINCT identifiant_centre) as Nombre_de_centrales 
FROM appartient 
GROUP BY appartient.nom_fournisseur; 

# Fournisseurs par département
SELECT DISTINCT fournisseur.nom as Nom_fournisseur, ville.departement as Departement
FROM fournisseur INNER JOIN facture ON fournisseur.nom = facture.nom_fournisseur, ville INNER JOIN habite ON habite.code_postal = ville.code_postal
WHERE facture.num_client = habite.num_client
order by fournisseur.nom ASC, ville.departement ASC


# Départements dans lesquels est distribuée chaque énergie pour le fournisseur 1
SELECT DISTINCT ville.departement, centre.type_centrale
FROM ville, appartient, situe, centre
WHERE STRCMP(appartient.nom_fournisseur, 'fournisseur 1') = 0 
AND centre.identifiant = appartient.identifiant_centre
AND situe.identifiant_centre = appartient.identifiant_centre
AND ville.code_postal = situe.code_postal

# Centres et énergie du fournisseur 1 dans le département 10
SELECT DISTINCT centre.identifiant as Identifiant_centre, centre.type_centrale as Type_energie
FROM centre, situe, ville, appartient
WHERE situe.code_postal = ville.code_postal
AND ville.departement = 10
AND situe.identifiant_centre = centre.identifiant
AND STRCMP(appartient.nom_fournisseur, 'fournisseur 1') = 0;

# Revenu total du dépaertement
SELECT ville.departement as Departement, SUM(facture.prix_kWh * consomme.quantite) AS Revenu_total
FROM facture, ville, habite, centre, consomme
WHERE facture.num_client = consomme.num_client
AND facture.num_client = habite.num_client 
AND habite.code_postal = ville.code_postal
GROUP BY ville.departement


# Quantité de chaque énergie distribuée par chaque Centrale
SELECT centre.type_centrale as type_energie, centre.identifiant, SUM(DISTINCT consomme.quantite) as Quantite 
FROM consomme, centre 
WHERE consomme.id_centre = centre.identifiant GROUP BY consomme.id_centre 
ORDER BY centre.identifiant ASC 

# Quantité de chaque énergie distribuée dans chaque département
SELECT ville.departement as departement, centre.type_centrale as type_energie, SUM(DISTINCT consomme.quantite) as Quantite_consommee
FROM consomme INNER JOIN centre ON consomme.id_centre = centre.identifiant, situe INNER JOIN ville ON situe.code_postal = ville.code_postal
WHERE situe.identifiant_centre = consomme.id_centre
GROUP BY ville.departement, centre.type_centrale
ORDER BY ville.departement ASC, centre.type_centrale ASC;


# Revenu pour chaque énergie dans chaque département
SELECT ville.departement as departement, centre.type_centrale as type_energie, SUM(DISTINCT consomme.quantite * facture.prix_kWh) as Revenu_total 
FROM consomme INNER JOIN centre ON consomme.id_centre = centre.identifiant, facture, situe INNER JOIN ville ON situe.code_postal = ville.code_postal
WHERE situe.identifiant_centre = consomme.id_centre
AND facture.num_client = consomme.num_client
GROUP BY ville.departement, centre.type_centrale
ORDER BY ville.departement ASC, centre.type_centrale ASC;

# Revenu pour chaque énergie dans chaque département du fournisseur 1
SELECT ville.departement as departement, centre.type_centrale as type_energie, SUM(DISTINCT consomme.quantite * facture.prix_kWh) as Revenu
FROM consomme, centre, facture, situe INNER JOIN ville ON situe.code_postal = ville.code_postal
WHERE consomme.id_centre = centre.identifiant
AND STRCMP(facture.nom_fournisseur, 'fournisseur 1') = 0
AND situe.identifiant_centre = consomme.id_centre
AND facture.num_client = consomme.num_client
GROUP BY ville.departement, centre.type_centrale
ORDER BY ville.departement ASC, centre.type_centrale ASC;

# Prix de la facture de chaque Client en fonction de sa consommation sur le mois
SELECT DISTINCT facture.num_client, (facture.prix_kWh * consomme.quantite) AS Prix_total_facture
FROM facture INNER JOIN consomme ON facture.num_client = consomme.num_client;

# Nombre total de personnes en fonction du département et du fournisseur
SELECT fournisseur.nom, ville.departement as Departement, SUM(DISTINCT personne.num_client) as Nombre_clients
FROM personne, habite INNER JOIN ville ON habite.code_postal = ville.code_postal, fournisseur
WHERE habite.num_client = personne.num_client
GROUP BY fournisseur.nom, ville.departement;

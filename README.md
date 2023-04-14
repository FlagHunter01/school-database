# BDD

 - Les attributs non-clé doivent dépendre de l'intégralité de la clé primaire ou ne pas en dépendre du tout.
 - Les attributs non-clé ne doivent pas avoir de dépendance entre eux

## Requetes

- Le nombre de Centrales par fourniseur
SELECT appartient.nom_fournisseur as Nom_fournisseur, COUNT(DISTINCT identifiant_centre) as Nombre_de_centrales 
FROM appartient 
GROUP BY appartient.nom_fournisseur; 

 - Présence du fournisseur dans les départements
SELECT DISTINCT fournisseur.nom as Nom_fournisseur, ville.departement as Departement
FROM fournisseur INNER JOIN facture, ville INNER JOIN habite
WHERE facture.num_client = habite.num_client
order by fournisseur.nom ASC, ville.departement ASC;

 - Départements dans lesquels est distribuée chaque énergie
 - Centres et énergie du fournisseur dans le département
 - Revenu total du dépaertement
 - Quantité de chaque énergie distribuée dans chaque département
 - Revenu pour chaque énergie dans chaque département

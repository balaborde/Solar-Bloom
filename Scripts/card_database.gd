# Replace with true stats.
const CARDS = { # ImageId, Type (B = Bâtiment, E = Effet)
	"Éolienne" : ["eolienne", "B"],
	"Floraison Exponentielle" : ["floraison_exp", "E"],
	"Hacktivisme Écologique" : ["hacktivisme_eco", "E"],
	"Pluie" : ["pluie", "E"],
	"Vent Violent": ["vent_violent", "E"],
}

const CARDS_TMP = {
	"Éolienne": [
		"Éolienne", 
		"eolienne", 
		"B", 
		"Produit : 2 ⚡/tour\n+1 ⚡ par éolienne adjacente (zone 3x3).\n\nSynergie : Éolienne + Éolienne adjacente => +1 ⚡"
	],
	"Vents Violents": [
		"Vents Violents", 
		"vent_violent", 
		"E", 
		"Effet : Désactive les rendements de toutes les éoliennes pendant 1 tour."
	],
	"Hacktivisme Écologique": [
		"Hacktivisme Écologique", 
		"hacktivisme_eco", 
		"E", 
		"Effet : Désactive toutes les cartes adjacentes (zone 3x3) pendant 2 tours."
	],
	"Floraison Exponentielle": [
		"Floraison Exponentielle", 
		"floraison_exp", 
		"E", 
		"Effet : Double le rendement des 🌿 à la fin du tour."
	],
	"Pluie": [
		"Pluie", 
		"pluie", 
		"E", 
		"Effet : +2 🌿 pour chaque carte 🌿 adjacente (zone 3x3).\nRéduit à 0 le rendement des panneaux solaires dans la même zone."
	],
	"Séisme": [
		"Séisme", 
		"seisme", 
		"E", 
		"Effet : Désactive tous les bâtiments sur une ligne ou une colonne pendant 1 tour."
	],
	"Maison": [
		"Maison", 
		"maison", 
		"B", 
		"Produit : +2 🏠/tour"
	],
	"Générateur de Nuage": [
		"Générateur de Nuage", 
		"generateur_nuage", 
		"E", 
		"Effet : 2 chances sur 5 de générer une carte Pluie au début du tour."
	],
	"Hôpital": [
		"Hôpital", 
		"hopital", 
		"E", 
		"Effet : Annule les effets des cartes dans un rayon de 2 cases autour."
	],
	"Invasion de Parasites": [
		"Invasion de Parasites", 
		"invasion_parasites", 
		"E", 
		"Effet : Diminue la production de 🌿 de toutes les cases adjacentes (zone 3x3) pendant 2 tours. 1 chance de détruire les cases 🌿."
	],
	"Ferme Aquaponique": [
		"Ferme Aquaponique", 
		"ferme_aquaponique", 
		"B", 
		"Produit : +3 🌿/tour\nConsomme : -1 🏠/tour\n\nSynergie : Barrage => +2 🌿"
	],
	"Réserve Naturelle": [
		"Réserve Naturelle", 
		"reserve_naturelle", 
		"B", 
		"Produit : +3 🌿/tour\n\nSynergie : Panneau Solaire => -1 🌿, Maison => +1 🌿"
	],
	"Panneau Solaire": [
		"Panneau Solaire", 
		"panneau_solaire", 
		"B", 
		"Produit : +3 ⚡/tour\nConsomme : -2 🏠/tour\nNe consomme pas de 🏠 si adjacent à une carte 🏠.\n\nSynergie : Maison => Pas de consommation 🏠"
	],
	"Base Solaire": [
		"Base Solaire", 
		"base_solaire", 
		"B", 
		"Produit : +6 ⚡/tour\nConsomme : -3 🏠/tour\nNe consomme pas de 🏠 si adjacent à une carte 🏠."
	],
	"Petit Labo": [
		"Petit Labo", 
		"petit_labo", 
		"B", 
		"Consomme : -2 ⚡/tour\nProduit : +1 🌿 pour chaque carte 🌿 posée sur le plateau."
	],
	"Éco Labo": [
		"Éco Labo", 
		"eco_labo", 
		"B", 
		"Consomme : -3 ⚡/tour, -2 🏠/tour\nProduit : +3 🌿 pour chaque carte 🌿 posée sur le plateau."
	],
	"Colonie Nomade": [
		"Colonie Nomade", 
		"colonie_nomade", 
		"B", 
		"Produit : +1 🌿, +1 🏠, +1 ⚡/tour.\nNe produit rien si des cartes sont adjacentes."
	],
	"Barrage": [
		"Barrage", 
		"barrage", 
		"B", 
		"Produit : +4 ⚡/tour\nEffet : -20 🌿 lors de la pose de la carte."
	],
	"École": [
		"École", 
		"ecole", 
		"B", 
		"Produit : +2 🏠/tour"
	],
	"Lycée": [
		"Lycée", 
		"lycee", 
		"B", 
		"Produit : +3 🏠/tour\nSe pose par-dessus une École."
	],
	"Université": [
		"Université", 
		"universite", 
		"B", 
		"Produit : +4 🏠/tour\n+1 carte piochée par tour.\nSe pose par-dessus un Lycée."
	]
}	

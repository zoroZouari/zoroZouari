

import 'package:firstparc/Chauffeur/dem_intervention.dart';
import 'package:firstparc/Chauffeur/dem_saisi.dart';
import 'package:firstparc/Chauffeur/menuChauffeur.dart';
import 'package:firstparc/Checklist/cK.dart';
import 'package:firstparc/Checklist/cK1.dart';

import 'package:firstparc/chef%20de%20parc/Mission/historique_mission.dart';
import 'package:firstparc/chef%20de%20parc/Mission/menu_mission.dart';
import 'package:firstparc/chef%20de%20parc/Mission/mission_affecte.dart';
import 'package:firstparc/chef%20de%20parc/Mission/mission_form.dart';
import 'package:firstparc/chef%20de%20parc/Mission/mission_modifie.dart';
import 'package:firstparc/chef%20de%20parc/Mission/modif_mission.dart';
import 'package:firstparc/chef%20de%20parc/menuchefdeparc.dart';
import 'package:firstparc/chef%20de%20parc/ordre_rep/historique_ordre.dart';
import 'package:firstparc/chef%20de%20parc/ordre_rep/ordre_valide.dart';
import 'package:firstparc/chef%20de%20parc/ordre_rep/valider_ordre.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/login/login_page.dart';
import 'package:flutter/material.dart';

class generateRoute {
  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      
      case AppRoutes.login_page:
       return MaterialPageRoute(builder: (context) => const LoginPage());
       //////////////// Chef De Parc /////////////////////////////////////
      case AppRoutes.menuchefdeparc:
       return MaterialPageRoute(builder: (context) => const MenuChefDeParc());
       /*
      case AppRoutes.menu_ck:
       return MaterialPageRoute(builder: (context) => const MenuCk());
      case AppRoutes.configck:
       return MaterialPageRoute(builder: (context) => const ConfigCk());
      case AppRoutes.fiche_ck:
      final args = routeSettings.arguments as Map<String, dynamic>;
       return MaterialPageRoute(builder: (context)=>   FicheCk(
        date: DateTime.now().toString(),
        selectedVersion: args['version'], // Remplacez cette chaîne vide par la version appropriée

       ));
       case AppRoutes.ck_soumis:
       
       return MaterialPageRoute(builder: (context) => const CkSoumis());
       case AppRoutes.historique_ck:
       
       return MaterialPageRoute(builder: (context) => const HistoriqueCk());
       case AppRoutes.modif_ck:
       final args = routeSettings.arguments as Map<String, dynamic>;
       return MaterialPageRoute(builder: (context) =>  ModifCk(
        id_ck: 123,
        version: args['version'],
        ordre: 456,
        date: DateTime.now(),
        type: 'Type initial',
        createur: 'Créateur initial',
        utilisateurLigne: 'Utilisateur Ligne initial',
       ));
       case AppRoutes.ck_modifie:
       return MaterialPageRoute(builder: (context) => const CkModifie());
       */
       case AppRoutes.mission_form:
       return MaterialPageRoute(builder: (context) => const MissionForm());
       case AppRoutes.menu_mission:
       return MaterialPageRoute(builder: (context) => const MenuMission());
       case AppRoutes.mission_affecte:
       return MaterialPageRoute(builder: (context) => const MissionAffecte());
       case AppRoutes.historique_mission:
       return MaterialPageRoute(builder: (context) => const HistoriqueMission());
       case AppRoutes.mission_modifie:
       return MaterialPageRoute(builder: (context) => const MissionModifie());
       case AppRoutes.modif_mission:
       
       return MaterialPageRoute(builder: (context) =>  ModifMission(
        idMission: 1,
        typeMission: 'Type Mission',
        nomChauffeur: 'chauffeur1',
        date: DateTime.now(),
        nomConvoyeur: 'Convoyeur 1',
        lieuDeChargement: 'Lieu1',
        LieuDeDechargement: 'Lieu2',
        client: 'client1',
       ));
       case AppRoutes.historique_ordre:
       return MaterialPageRoute(builder: (context) => const HistoriqueOrdre());
       case AppRoutes.valider_ordre:
       return MaterialPageRoute(builder: (context) => const ValiderOrdre());
       case AppRoutes.ordre_valide:
       return MaterialPageRoute(builder: (context) => const OrdreValide());
       ////////////      CHAUFFEUR    //////////////////////
       case AppRoutes.menuChauffeur:
       return MaterialPageRoute(builder: (context) => const MenuChauffeur());
       case AppRoutes.dem_Intervention:
       return MaterialPageRoute(builder: (context) => const DemIntervention());
       case AppRoutes.dem_saisi:
       return MaterialPageRoute(builder: (context) => const DemSaisi());
       /*
       case AppRoutes.mission_chauffeur:
       return MaterialPageRoute(builder: (context) =>  MissionChauffeur());
       */
       

      ////////////////////////////////  CK ////////////////////////////////////
      case AppRoutes.cK:
      return MaterialPageRoute(builder: (context) =>  Ck(
        date: DateTime.now().toString(),
      ));
      case AppRoutes.cK1:
       return MaterialPageRoute(builder: (context)=>  const Ck1());
     
  }
  }
  }

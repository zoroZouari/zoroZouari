import 'package:firstparc/Admin/Cr%C3%A9ation%20User/user_cree.dart';
import 'package:firstparc/Admin/Liste%20Perso/liste_chauffs.dart';
import 'package:firstparc/Admin/Liste%20Perso/liste_chefs.dart';
import 'package:firstparc/Admin/Liste%20Perso/liste_mecs.dart';
import 'package:firstparc/Admin/Liste%20Perso/adminprofil_modifie.dart';
import 'package:firstparc/Admin/Liste%20Perso/profil_pageAdmin.dart';
import 'package:firstparc/Admin/Cr%C3%A9ation%20User/creation_user.dart';
import 'package:firstparc/Admin/menuAdmin.dart';
import 'package:firstparc/Chauffeur/chauff_mission.dart';
import 'package:firstparc/Chauffeur/chauff_profilModifie.dart';
import 'package:firstparc/Chauffeur/chauff_profilPage.dart';
import 'package:firstparc/Chauffeur/dem_intervention.dart';
import 'package:firstparc/Chauffeur/dem_saisi.dart';
import 'package:firstparc/Chauffeur/menuChauffeur.dart';
import 'package:firstparc/Chauffeur/validerMissionChauff.dart';
import 'package:firstparc/Checklist/cK.dart';
import 'package:firstparc/Checklist/cK1.dart';
import 'package:firstparc/M%C3%A9canicien/mec_mission.dart';
import 'package:firstparc/M%C3%A9canicien/mecprofil_page.dart';
import 'package:firstparc/M%C3%A9canicien/procederMission.dart';
import 'package:firstparc/M%C3%A9canicien/validermissionMec.dart';

import 'package:firstparc/chef%20de%20parc/Mission/historique_mission.dart';
import 'package:firstparc/chef%20de%20parc/Mission/menu_mission.dart';
import 'package:firstparc/chef%20de%20parc/Mission/mission_affecte.dart';
import 'package:firstparc/chef%20de%20parc/Mission/mission_form.dart';
import 'package:firstparc/chef%20de%20parc/Mission/mission_modifie.dart';
import 'package:firstparc/chef%20de%20parc/Mission/modif_mission.dart';
import 'package:firstparc/chef%20de%20parc/chefprofil_modifie.dart';
import 'package:firstparc/chef%20de%20parc/menuchefdeparc.dart';
import 'package:firstparc/chef%20de%20parc/ordre_rep/historique_ordre.dart';
import 'package:firstparc/chef%20de%20parc/ordre_rep/ordre_valide.dart';
import 'package:firstparc/chef%20de%20parc/ordre_rep/valider_ordre.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/login/login_page.dart';
import 'package:firstparc/chef%20de%20parc/chefprofil_page.dart';
import 'package:firstparc/profil_page.dart';
import 'package:flutter/material.dart';

class GenerateRoute {
   Route<dynamic>? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case AppRoutes.login_page:
       return MaterialPageRoute(builder: (context) =>  LoginPage());
       //////////////// Chef De Parc /////////////////////////////////////////////////  CHEF DE PARC
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

       case AppRoutes.chefprofil_page:
       return MaterialPageRoute(builder: (context) =>  ChefProfilePage());

        case AppRoutes.chefprofil_modifie:
       return MaterialPageRoute(builder: (context) => const ChefProfilModifie());
       ////////////      CHAUFFEUR    //////////////////////
       case AppRoutes.menuChauffeur:
       return MaterialPageRoute(builder: (context) => const MenuChauffeur());

       case AppRoutes.dem_Intervention:
       return MaterialPageRoute(builder: (context) => const DemIntervention());

       case AppRoutes.dem_saisi:
       return MaterialPageRoute(builder: (context) => const DemSaisi());

       case AppRoutes.chauff_profilPage:
       return MaterialPageRoute(builder: (context) =>  ChauffProfilePage());

       case AppRoutes.chauff_profilModifie:
       return MaterialPageRoute(builder: (context) =>   const ChaufProfilModifie());

       
       case AppRoutes.chauff_mission:
       return MaterialPageRoute(builder: (context) =>  ChauffMission());

       case AppRoutes.validerMissionChauff:
       return MaterialPageRoute(builder: (context) =>  ValiderMissionChauff());
       
       

      ////////////////////////////////  CK ////////////////////////////////////
      case AppRoutes.cK:
      return MaterialPageRoute(builder: (context) =>  Ck(
        date: DateTime.now().toString(),
        codeT: null, codeType: null
      ));
      
      case AppRoutes.cK1:
 final args = routeSettings.arguments as Map<String, dynamic>;
       return MaterialPageRoute(builder: (context)=>   Ck1(
        date: args['widget.date'],
        version: args['selectedVersion'], 
        remorque: args['selectedRemorque'],
        vehicule: args['selectedVehicule'],
        titre: args['selectedTitreDesignation'],
        codet: args['selectedTitre'],
        codetype: args['selectedType'],
        ));




       /////////////////////////////  Profil Page /////////////////////////////
       case AppRoutes.profil_page:
       return MaterialPageRoute(builder: (context)=>   ProfilePage());
       /////////////////////////////  Admin //////////////////////////////////   Admin
       case AppRoutes.menuAdmin:
       return MaterialPageRoute(builder: (context)=>  const  MenuAdmin());

       case AppRoutes.liste_chauffs:
       return MaterialPageRoute(builder: (context)=>  const  ListeChauffs());

       case AppRoutes.liste_chefs:
       return MaterialPageRoute(builder: (context)=>  const   ListeChefs());

       case AppRoutes.liste_mecs:
       return MaterialPageRoute(builder: (context)=>  const  ListeMecs());

       case AppRoutes.creation_user:
       return MaterialPageRoute(builder: (context)=>   const CreationUser());

       case AppRoutes.profil_pageAdmin:
       return MaterialPageRoute(builder: (context)=>    ProfilePageAdmin());

       case AppRoutes.adminprofil_modifie:
       return MaterialPageRoute(builder: (context)=>   const AdminProfilModifie());

       case AppRoutes.user_cree:
       return MaterialPageRoute(builder: (context)=>   const UserCree());

       //////////////////////  Mécanicien  ////////////////////////////////////////////////// Mécanicien 
        case AppRoutes.mec_mission:
       return MaterialPageRoute(builder: (context)=>   const MecMission ());

        case AppRoutes.validermissionMec:
       return MaterialPageRoute(builder: (context)=>    ValiderMissionMec ());

        case AppRoutes.procederMission:
       return MaterialPageRoute(builder: (context)=>    ProcederMission ());

        case AppRoutes.mecprofil_page:
       return MaterialPageRoute(builder: (context)=>    MecProfilePage ());
     
  }
    return null;
  }
  }

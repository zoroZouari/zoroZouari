import 'package:flutter/material.dart';

class CkDeailsPage extends StatefulWidget {
  const CkDeailsPage({super.key});

  @override
  State<CkDeailsPage> createState() => _CkDeailsPageState();
}

class _CkDeailsPageState extends State<CkDeailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Check List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Code Ck: ${ckEnteteCk.codeCk}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Titre: ${ckEnteteCk.codeT}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Véhicule: ${ckEnteteCk.vehicule}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Remorque: ${ckEnteteCk.remorque}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${ckEnteteCk.heureCk}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Lignes de Check List:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: ckLignes.length,
                itemBuilder: (context, index) {
                  final ckLigne = ckLignes[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text('Observation: ${ckLigne.observation}', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Code Ss: ${ckLigne.codeSs}'),
                          Text('Code Contenu: ${ckLigne.codeContenu}'),
                          Text('Etat: ${ckLigne.etatContenu}'),
                          
                          Text('Exécutant: ${ckLigne.executant}'),
                          // Afficher les autres propriétés de ckLigne si nécessaire
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: file_names
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epitech/main.dart';
import 'package:epitech/model/localData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SubPage extends StatefulWidget {
  final dynamic jsonData;
  const SubPage({Key? key, this.jsonData}) : super(key: key);
  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> escape() async {
    setState(() {
      trans = true;
      Navigator.of(context).pop();
    });
    return trans;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String name = args['name'];
    final int index = args['index'];
    Duration sub = const Duration(hours: 1);
    List<Map<String, dynamic>> libreItems = [];
    List<Map<String, dynamic>> nonLibreItems = [];

    for (int i = 0; i < widget.jsonData.length; i++) {
      if (widget.jsonData[i]['activities'].toString() == "[]" ||
          widget.jsonData[i]['activities'] == null) {
        libreItems.add(widget.jsonData[i]);
      } else {
        nonLibreItems.add(widget.jsonData[i]);
      }
    }
    libreItems.sort((a, b) => a['name'].length.compareTo(b['name'].length));
    nonLibreItems.sort((a, b) => a['name'].length.compareTo(b['name'].length));
    List<Map<String, dynamic>> sortedData = libreItems + nonLibreItems;
    var activities = sortedData[index]['activities'];
    DateFormat dateFormat = DateFormat("HH':'mm");
    final url = name.toLowerCase();
    return Consumer2<MyThemeModeModel, MyThemeSettingsModel>(
        builder: (context, mode, settings, child) {
      final lightmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == false
              ? Colors.black
              : Colors.white;

      final darkmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == true
              ? Colors.black
              : Colors.white;
      return WillPopScope(
          onWillPop: () {
            return escape();
          },
          child: Scaffold(
              backgroundColor: lightmode,
              appBar: AppBar(
                title: Text(
                  name,
                  style: TextStyle(color: darkmode),
                ),
                leading: BackButton(
                  onPressed: () {
                    setState(() {
                      trans = true;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 1,
                        ))),
              ),
              extendBodyBehindAppBar: true,
              body: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 0) {
                      setState(() {
                        trans = true;
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          trans = true;
                          Navigator.of(context).pop();
                        });
                      },
                      child: NestedScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          headerSliverBuilder: (context, value) {
                            return [
                              SliverAppBar(
                                  leading: const SizedBox.shrink(),
                                  pinned: true,
                                  backgroundColor: lightmode,
                                  iconTheme:
                                      const IconThemeData(color: Colors.blue),
                                  stretch: true,
                                  onStretchTrigger: () {
                                    // Function callback for stretch
                                    return Future<void>.value();
                                  },
                                  expandedHeight: 300.0,
                                  flexibleSpace: FlexibleSpaceBar(
                                      stretchModes: const <StretchMode>[
                                        StretchMode.zoomBackground,
                                        StretchMode.blurBackground,
                                        StretchMode.fadeTitle,
                                      ],
                                      centerTitle: true,
                                      background: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Hero(
                                                tag: name.toLowerCase(),
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/room%2F${name.toLowerCase()}.png?alt=media&token=f19ff22d-8956-4137-8a0c-dc747c9c3bf3",
                                                    fit: BoxFit.cover)),
                                            FadeInUp(
                                                duration:
                                                    const Duration(seconds: 1),
                                                child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topRight,
                                                            colors: [
                                                      lightmode.withOpacity(1),
                                                      lightmode.withOpacity(1),
                                                      lightmode
                                                          .withOpacity(0.5),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                    ])))),
                                          ]))),
                            ];
                          },
                          body: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                TabBar(
                                  isScrollable: false,
                                  labelColor: darkmode,
                                  unselectedLabelColor: Colors.grey.shade600,
                                  indicatorColor: lightmode,
                                  indicatorWeight: 1,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  controller: _tabController,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  tabs: [
                                    const Tab(
                                      icon: Icon(
                                        Icons.calendar_month,
                                        size: 25,
                                      ),
                                    ),
                                    const Tab(
                                      icon: Icon(
                                        Icons.book,
                                        size: 25.0,
                                      ),
                                    ),
                                    const Tab(
                                      icon: Icon(
                                        Icons.map_rounded,
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 20,
                                ),
                                Expanded(
                                    child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 20,
                                        ),
                                        activities.length == 0
                                            ? SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1,
                                                child: Center(
                                                    child: Text(
                                                  "Aucune activit??e\n dans cette salle\n n'a ??t?? identifi??",
                                                  style: TextStyle(
                                                      fontSize: 35,
                                                      color: darkmode,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )))
                                            : const SizedBox.shrink(),
                                        for (int i = 0;
                                            i < activities.length;
                                            i++)
                                          Expanded(
                                              child: Column(
                                            children: [
                                              ListTile(
                                                subtitle: Text(
                                                  // ignore: prefer_if_null_operators
                                                  "${sortedData[index]['activities'][i]['module_title'] == null ? "" : sortedData[index]['activities'][i]['module_title']} , ${sortedData[index]['activities'][i]['module_code'] == null ? "" : sortedData[index]['activities'][i]['module_code']} , ${sortedData[index]['activities'][i]['type'] == null ? "" : sortedData[index]['activities'][i]['type']}",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: darkmode,
                                                      fontWeight:
                                                          FontWeight.w100),
                                                ),
                                                title: Text(
                                                  "${sortedData[index]['activities'][i]['activity_title']} : ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(sortedData[index]['activities'][i]['start_at']).subtract(sub))} - ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(sortedData[index]['activities'][i]['end_at']).subtract(sub))}",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: darkmode,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              )
                                            ],
                                          ))
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.width /
                                                5,
                                            right: MediaQuery.of(context).size.width /
                                                5),
                                        child: name == "Bourg Palette"
                                            ? Text('Paysage Bourg Palette est un lieu de la s??rie de jeux vid??o Pok??mon. C\'est une petite ville situ??e dans la r??gion de Kanto, et c\'est le lieu de d??part du personnage du joueur dans la premi??re g??n??ration de jeux Pok??mon. Dans les jeux Pok??mon, Paysage Bourg Palette est repr??sent?? comme une ville pittoresque et paisible entour??e de champs herbeux et de for??ts.',
                                                style: TextStyle(
                                                    color: darkmode,
                                                    fontSize: 20))
                                            : name == "Gallifrey"
                                                ? Text('Gallifrey City est une ville fictive situ??e sur la plan??te Gallifrey dans l\'univers de Doctor Who. Elle est la capitale de la plan??te et est le lieu de r??sidence des Time Lords, une race extraterrestre dot??e de la capacit?? de voyage dans le temps et de l\'espace. La ville est d??crite comme ??tant tr??s avanc??e technologiquement et comme poss??dant de nombreux b??timents imposants et des rues bord??es de jardins luxuriants. Elle est ??galement connue pour ses ??coles de formation pour les Time Lords et pour son Panoptique, le si??ge du gouvernement de Gallifrey.',
                                                    style: TextStyle(
                                                        color: darkmode,
                                                        fontSize: 20))
                                                : name == "Mordor"
                                                    ? Text('Mordor est d??crit comme ??tant une r??gion sombre et sinistre, remplie de montagnes noires et de forges o?? sont forg??es les armes et les armures des orcs. C\'est ??galement le lieu o?? se trouve le Mont Doom, un volcan actif au c??ur de Mordor, et le si??ge du pouvoir de Sauron, le principal antagoniste de l\'histoire de "L\'Anneau Unique" de Tolkien',
                                                        style: TextStyle(
                                                            color: darkmode,
                                                            fontSize: 20))
                                                    : name == "Poudlard"
                                                        ? Text(
                                                            'Poudlard est une ??cole de magie situ??e en Grande-Bretagne et qui accueille des ??l??ves de la maternelle ?? la terminale. Elle a ??t?? fond??e par Godric Gryffondor, Salazar Serpentard, Rowena Serdaigle et Helga Poufsouffle, quatre grands sorciers du Moyen ??ge qui ont chacun donn?? leur nom ?? une maison de l\'??cole.',
                                                            style: TextStyle(
                                                                color: darkmode,
                                                                fontSize: 20))
                                                        : name == "Comt??"
                                                            ? Text(
                                                                'Le paysage du Comt??, tel qu\'il est d??crit dans "Le Seigneur des Anneaux" de J.R.R. Tolkien, est un lieu idyllique et paisible situ?? dans le milieu de la Terre du Milieu. C\'est l?? que se trouve la demeure de Bilbon Sacquet, le protagoniste de l\'histoire. Le Comt?? est un endroit verdoyant, avec de nombreux champs et vergers, ainsi que de petits villages et hameaux dispers??s ici et l??.',
                                                                style: TextStyle(color: darkmode, fontSize: 20))
                                                            : name == "Tatooine"
                                                                ? Text('Tatooine est un monde d??sertique situ?? dans la Bordure Ext??rieure de la galaxie. Il est connu pour ??tre le lieu de naissance de Luke Skywalker, l\'un des h??ros de la Guerre des ??toiles. Le paysage de Tatooine est principalement compos?? de vastes ??tendues de sable, de dunes et de montagnes rocheuses. Le soleil y brille en permanence et la temp??rature peut atteindre des records de chaleur, ce qui rend la vie sur cette plan??te tr??s difficile pour les habitants.', style: TextStyle(color: darkmode, fontSize: 20))
                                                                : name == "Westeros"
                                                                    ? Text('Westeros est un pays imaginaire cr???? par l\'auteur George R.R. Martin pour sa s??rie de livres "Le Tr??ne de Fer". Il est situ?? sur un continent fictif et se compose de neuf royaumes, chacun ayant sa propre culture et ses propres coutumes. Le paysage de Westeros est diversifi??, allant des verts p??turages du Val ?? la d??solation glac??e du Mur. Il y a des montagnes, des for??ts, des prairies, des marais et des c??tes rocheuses.', style: TextStyle(color: darkmode, fontSize: 20))
                                                                    : name == "Vogons"
                                                                        ? const Text('Le paysage de Vogons est caract??ris?? par des plaines d??sertiques et arides, parsem??es de quelques collines rocheuses. La v??g??tation est principalement compos??e de cactus et de buissons durs et r??sistants, adapt??s aux conditions climatiques difficiles de cette r??gion. La faune de Vogons est ??galement tr??s particuli??re, avec des esp??ces rares et end??miques comme le Vogon-ours, un animal robuste et agressif qui vit dans les montagnes et qui est r??put?? pour sa force et sa r??sistance.', style: TextStyle(color: Colors.white, fontSize: 20))
                                                                        : name == "Hub Innovation"
                                                                            ? const Text('...', style: TextStyle(color: Colors.white, fontSize: 20))
                                                                            : name == "Torvalds"
                                                                                ? Text('Linus Torvalds est un informaticien finlandais connu pour avoir cr???? le noyau Linux, un syst??me d\'exploitation libre et open source utilis?? dans de nombreux ordinateurs et appareils de tous types. Torvalds est n?? en 1969 ?? Helsinki, en Finlande. Il a grandi dans une famille o?? l\'informatique et les technologies de l\'information ??taient tr??s pr??sentes. Son p??re travaillait pour l\'universit?? de Helsinki et avait install?? un ordinateur personnel ?? la maison d??s le d??but des ann??es 1980. ', style: TextStyle(color: darkmode, fontSize: 20))
                                                                                : Text('Gotham City est une ville fictive du monde de l\'univers DC Comics. Elle est principalement connue comme ??tant la ville natale de Batman et comme le lieu o?? se d??roulent la plupart de ses aventures. Gotham City est d??crite comme ??tant une grande ville industrielle et cosmopolite, situ??e sur la c??te est des ??tats-Unis. Selon les diff??rentes versions de l\'histoire, elle peut ??tre situ??e dans n\'importe quel ??tat de la c??te est, mais elle est souvent associ??e ?? New York. La ville est connue pour ??tre sombre et mena??ante, avec une criminalit?? ??lev??e et des quartiers d??favoris??s.', style: TextStyle(color: darkmode, fontSize: 20))),
                                    settings.isSettingsTheme == true
                                        ? MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.dark
                                            ? Container(
                                                color: Colors.transparent,
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/dark_plan%2F${url == "compt??" ? "comt??" : url}.png?alt=media&token=e6a8bc6e-48fa-4359-9483-3d7aff3c1560",
                                                    fit: BoxFit.contain))
                                            : Container(
                                                color: Colors.transparent,
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/light_plan%2F$url.png?alt=media&token=c8508f29-6d28-481f-bccf-30d01fc1f3fa",
                                                    fit: BoxFit.contain))
                                        : mode.isModeTheme == false
                                            ? Container(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/dark_plan%2F${url == "compt??" ? "comt??" : url}.png?alt=media&token=e6a8bc6e-48fa-4359-9483-3d7aff3c1560",
                                                    fit: BoxFit.contain))
                                            : Container(
                                                color: Colors.transparent,
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/light_plan%2F$url.png?alt=media&token=c8508f29-6d28-481f-bccf-30d01fc1f3fa",
                                                    fit: BoxFit.contain))
                                  ],
                                ))
                              ]))))));
    });
  }
}

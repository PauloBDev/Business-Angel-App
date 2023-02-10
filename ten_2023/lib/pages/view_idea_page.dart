// visualização da proposta
//com:
//
// imagem / Video
// titulo
// descrição
// comentário se possivel

// Rocha / telmo

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewIdeiaPage extends StatefulWidget {
  const ViewIdeiaPage({Key? key}) : super(key: key);

  @override
  _ViewIdeiaPageState createState() => _ViewIdeiaPageState();
}

class _ViewIdeiaPageState extends State<ViewIdeiaPage> {
  List<String> comments = ["Teste1.", "gfdsa", "hgrfdsa"];
  TextEditingController? textController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Add idea',
          style: GoogleFonts.bebasNeue(fontSize: 36),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(30)),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 78, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'lib/images/3237155-200.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                child: Text(
                    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.\n\nDonec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                    )),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                child: Text('Type : ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                    )),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                          child: Image.asset(
                            'lib/images/2366460-200.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 200,
                              decoration: BoxDecoration(),
                              child: TextFormField(
                                controller: textController,
                                autofocus: true,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  labelText: 'Add  a comment..',
                                  // Set border for enabled state (default)
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Work Sans',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 40)),
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            child: const Text('Send'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        'lib/images/2366460-200.png',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(comments[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

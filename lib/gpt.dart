import 'package:flutter/material.dart';
import 'package:sdgs_frontend/susForm.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int currentStep = 0;
  String dropdownValue = 'Option 1';
  static SusForm sus = SusForm();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SusAF"),
          centerTitle: true,
        ),
        body: Form(
          key: myFormKey,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 100),
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepCancel: () => currentStep == 0
                      ? null
                      : setState(() {
                          currentStep -= 1;
                        }),
                  onStepContinue: () {
                    bool isLastStep = (currentStep == getSteps().length - 1);
                    if (isLastStep) {
                      //Do something with this information
                    } else {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  },
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  steps: getSteps(),
                )),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    final Map<String, String> formValues = {
      'company_name': 'LUT',
      'company_goal': 'goal',
      'company_objective': 'objective',
      'product_name': 'productName',
      'product_description': 'productDescription',
      'audience': 'audience',
      'product_features': 'productFeatures',
      'question_env': 'questionEnv',
      'question_soc': 'questionSoc',
      'question_ind': 'questionInd',
      'question_eco': 'questionEco',
      'question_tec': 'questionTec',
      'answer_env': 'answerEnv',
      'answer_soc': 'answerSoc',
      'answer_ind': 'answerInd',
      'answer_eco': 'answerEco',
      'answer_tec': 'answerTec',
    };

    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Company"),
        content: Column(
          children: [
            CustomInput(
              formValues: formValues,
              onChanged: (value) => sus.companyName = value,
              hint: "Company Name",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              onChanged: (value) => sus.companyMission = value,
              hint: "Company Mission",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              onChanged: (value) => sus.companyGoals = value,
              hint: "Company Sustainability Goals",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Product"),
        content: Column(
          children: [
            CustomInput(
              onChanged: (value) => sus.productName = value,
              hint: "Product Name",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              onChanged: (value) => sus.productDescription = value,
              hint: "Product Description",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Audience"),
        content: Column(
          children: [
            DropdownButtonFormField<String>(
                value: 'Product Owner',
                items: const [
                  DropdownMenuItem(
                      value: 'Developer', child: Text('Developer')),
                  DropdownMenuItem(value: 'User', child: Text('User')),
                  DropdownMenuItem(
                      value: 'Product Owner', child: Text('Product Owner')),
                ],
                onChanged: (value) {
                  print(value);
                  sus.audience = value ?? 'Product Owner';
                }),
          ],
        ),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text("Product Features"),
        content: Column(
          children: [
            CustomInput(
              onChanged: (value) => sus.productFeatures = value,
              hint: "Product Features, split by commas",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const Text("Questions A"),
        content: Column(
          children: [
            const Text("Answer a questions for the SOCIAL impact"),

            //////// QUESTION 1 /////////
            DropdownButtonFormField<String>(
                value:
                    "How can the product or service affect a person's sense of belonging to these groups?",
                items: const [
                  DropdownMenuItem(
                      value:
                          "How can the product or service affect a person's sense of belonging to these groups?",
                      child: Text(
                          "How can the product or service affect a person's sense of belonging to these groups?")),
                  DropdownMenuItem(
                      value:
                          'How can the product or service change the trust between the users and the business that owns the system?',
                      child: Text(
                          'How can the product or service change the trust between the users and the business that owns the system?')),
                  DropdownMenuItem(
                    value:
                        'How can the product or service impact on how people perceive others?',
                    child: Text(
                        'How can the product or service impact on how people perceive others?'),
                  ),
                  DropdownMenuItem(
                    value:
                        'How can it affect users with different backgrounds, age groups, education levels, or other differences?',
                    child: Text(
                        'How can it affect users with different backgrounds, age groups, education levels, or other differences?'),
                  ),
                  DropdownMenuItem(
                    value:
                        'How can the system make people be treated differently from each other? (think data analytics or decision support)',
                    child: Text(
                        'How can the system make people be treated differently from each other? (think data analytics or decision support)'),
                  ),
                  DropdownMenuItem(
                    value:
                        'How can the product or service change how people create networks, participate in group work, or support arguments with others?',
                    child: Text(
                        'How can the product or service change how people create networks, participate in group work, or support arguments with others?'),
                  ),
                ],
                onChanged: (value) {
                  print(value);
                  sus.questionSoc = value ??
                      "How can the product or service affect a person's sense of belonging to these groups?";
                }),
            const SizedBox(height: 15),
            CustomInput(
              onChanged: (value) => sus.answerSoc = value,
              hint: "Social Answer",
              inputBorder: OutlineInputBorder(),
            ),
            const Divider(height: 5),
            const SizedBox(height: 20),
            const Text("Answer a questions for the INDIVIDUAL impact"),

            //////// QUESTION 2 /////////
            DropdownButtonFormField<String>(
                value:
                    "How can the product or service improve or worsen a person's physical, mental, and/or emotional health?",
                items: const [
                  DropdownMenuItem(
                      value:
                          "How can the product or service improve or worsen a person's physical, mental, and/or emotional health?",
                      child: Text(
                          "How can the product or service improve or worsen a person's physical, mental, and/or emotional health?")),
                  DropdownMenuItem(
                      value:
                          "How can the product or service affect people's competencies?",
                      child: Text(
                          "How can the product or service affect people's competencies?")),
                  DropdownMenuItem(
                      value:
                          "How can the product or service expose (or help to hide) a person's identity, whereabouts, or relations?",
                      child: Text(
                          "How can the product or service expose (or help to hide) a person's identity, whereabouts, or relations?")),
                  DropdownMenuItem(
                      value:
                          "How can the product or service expose (or protect) a person from physical harm?",
                      child: Text(
                          "How can the product or service expose (or protect) a person from physical harm?")),
                  DropdownMenuItem(
                      value:
                          "How can it make a person feel more (or less) exposed to harm?",
                      child: Text(
                          "How can it make a person feel more (or less) exposed to harm?")),
                  DropdownMenuItem(
                      value: "What if used in an unintended way?",
                      child: Text("What if used in an unintended way?")),
                  DropdownMenuItem(
                      value:
                          "How can the product or service empower (or prevent) a person from taking an action/decision when necessary?",
                      child: Text(
                          "How can the product or service empower (or prevent) a person from taking an action/decision when necessary?")),
                  DropdownMenuItem(
                      value:
                          "Can those affected by the product or service understand its implications, express concerns or be represented by someone?",
                      child: Text(
                          "Can those affected by the product or service understand its implications, express concerns or be represented by someone?")),
                ],
                onChanged: (value) {
                  print(value);
                  sus.questionInd = value ??
                      "How can the product or service improve or worsen a person's physical, mental, and/or emotional health?";
                }),
            const SizedBox(height: 15),
            CustomInput(
              onChanged: (value) => sus.answerInd = value,
              hint: "Individual Answer",
              inputBorder: OutlineInputBorder(),
            ),
            const Divider(height: 5),
            const SizedBox(height: 20),
            const Text("Answer a questions for the ENVIRONMENTAL impact"),

            //////// QUESTION 3 /////////
            DropdownButtonFormField<String>(
                value:
                    "How are materials consumed to produce the product or service?",
                items: const [
                  DropdownMenuItem(
                      value:
                          "How are materials consumed to produce the product or service?",
                      child: Text(
                          "How are materials consumed to produce the product or service?")),
                  DropdownMenuItem(
                      value:
                          "What about operating the product or service? E.g., requires hardware.",
                      child: Text(
                          "What about operating the product or service? E.g., requires hardware.")),
                  DropdownMenuItem(
                      value:
                          "How can it change the way people consume material? E.g., encourage to buy more?",
                      child: Text(
                          "How can it change the way people consume material? E.g., encourage to buy more?")),
                  DropdownMenuItem(
                      value:
                          "How can producing parts or supplies generate waste or emissions?",
                      child: Text(
                          "How can producing parts or supplies generate waste or emissions?")),
                  DropdownMenuItem(
                      value:
                          "How can the use itself produce waste or emissions?",
                      child: Text(
                          "How can the use itself produce waste or emissions?")),
                  DropdownMenuItem(
                      value:
                          "How can it influence how much waste or emissions are generated?",
                      child: Text(
                          "How can it influence how much waste or emissions are generated?")),
                  DropdownMenuItem(
                      value: "How can it promote (or impair) recycling?",
                      child: Text("How can it promote (or impair) recycling?")),
                  DropdownMenuItem(
                      value:
                          "How can it impact the plants or animals around it? Or elsewhere?",
                      child: Text(
                          "How can it impact the plants or animals around it? Or elsewhere?")),
                  DropdownMenuItem(
                      value:
                          "How can it change the composition of the soil around it? E.g., occupying/cropland? o What about elsewhere?",
                      child: Text(
                          "How can it change the composition of the soil around it? E.g., occupying/cropland? o What about elsewhere?")),
                  DropdownMenuItem(
                      value:
                          "How can the product or service affect the need for the production of energy?",
                      child: Text(
                          "How can the product or service affect the need for the production of energy?")),
                  DropdownMenuItem(
                      value:
                          "What about the use of energy? E.g. encourages less energy?",
                      child: Text(
                          "What about the use of energy? E.g. encourages less energy?")),
                  DropdownMenuItem(
                      value:
                          "What about the use of energy? E.g. encourages less energy?",
                      child: Text(
                          "What about the use of energy? E.g. encourages less energy?")),
                  DropdownMenuItem(
                      value:
                          "How can affect the need for moving people or goods, or for people or goods to move?",
                      child: Text(
                          "How can affect the need for moving people or goods, or for people or goods to move?")),
                ],
                onChanged: (value) {
                  print(value);
                  sus.questionEnv = value ??
                      'How are materials consumed to produce the product or service?';
                }),
            const SizedBox(height: 15),
            CustomInput(
              onChanged: (value) => sus.answerEnv = value,
              hint: "Environmental Answer",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: const Text("Questions B"),
        content: Column(
          children: [
            const Text("Answer a questions for the ECONOMIC impact"),

            //////// QUESTION 4 /////////
            DropdownButtonFormField<String>(
                value:
                    'How can the product or service create or destroy monetary value? For whom?',
                items: const [
                  DropdownMenuItem(
                      value:
                          'How can the product or service create or destroy monetary value? For whom?',
                      child: Text(
                          'How can the product or service create or destroy monetary value? For whom?')),
                  DropdownMenuItem(
                      value:
                          'Are there any other related types of business value? For whom?',
                      child: Text(
                          'Are there any other related types of business value? For whom?')),
                  DropdownMenuItem(
                      value:
                          'How can the product or service affect the relationship between the business and its customers?',
                      child: Text(
                          'How can the product or service affect the relationship between the business and its customers?')),
                  DropdownMenuItem(
                      value:
                          'How can it enable co-creation or co-destruction of value?',
                      child: Text(
                          'How can it enable co-creation or co-destruction of value?')),
                  DropdownMenuItem(
                      value:
                          'How can it impact the financial situation of their customers & others?',
                      child: Text(
                          'How can it impact the financial situation of their customers & others?')),
                  DropdownMenuItem(
                      value:
                          'How can the product or service affect the supply chain of the business that owns it?',
                      child: Text(
                          'How can the product or service affect the supply chain of the business that owns it?')),
                  DropdownMenuItem(
                      value:
                          'How can these changes in the supply chain impact the financial situation?',
                      child: Text(
                          'How can these changes in the supply chain impact the financial situation?')),
                  DropdownMenuItem(
                      value:
                          'How can it impact the financial situation of their customers & others?',
                      child: Text(
                          'How can it impact the financial situation of their customers & others?')),
                  DropdownMenuItem(
                      value:
                          'How can the product affect how and who makes decisions, and the communication channels?',
                      child: Text(
                          'How can the product affect how and who makes decisions, and the communication channels?')),
                  DropdownMenuItem(
                      value:
                          'How can these changes impact the financial situation of the business and partners?',
                      child: Text(
                          'How can these changes impact the financial situation of the business and partners?')),
                  DropdownMenuItem(
                      value:
                          'Do (parts of) the product or service affect the investment in research & development?',
                      child: Text(
                          'Do (parts of) the product or service affect the investment in research & development?')),
                  DropdownMenuItem(
                      value:
                          'How can changes in innovation and R&D impact the financial situation?',
                      child: Text(
                          'How can changes in innovation and R&D impact the financial situation?')),
                  DropdownMenuItem(
                      value:
                          'Can it also impact the financial situation of their customers & others?',
                      child: Text(
                          'Can it also impact the financial situation of their customers & others?')),
                ],
                onChanged: (value) {
                  print(value);
                  sus.questionEco = value ??
                      'How can the product or service create or destroy monetary value? For whom?';
                }),
            const SizedBox(height: 15),
            CustomInput(
              onChanged: (value) => sus.answerEco = value,
              hint: "Economic Answer",
              inputBorder: OutlineInputBorder(),
            ),
            const Divider(height: 5),
            const SizedBox(height: 20),
            const Text("Answer a questions for the TECHNICAL impact"),

            //////// QUESTION 5 /////////
            DropdownButtonFormField<String>(
                value:
                    'How are the operating system and runtime environment expected to change what does that required from maintainers of this system?',
                items: const [
                  DropdownMenuItem(
                      value:
                          'How are the operating system and runtime environment expected to change what does that required from maintainers of this system?',
                      child: Text(
                          'How are the operating system and runtime environment expected to change what does that required from maintainers of this system?')),
                  DropdownMenuItem(
                      value:
                          'How can the correctness of the system be affected by other systems or affect the correctness of others?',
                      child: Text(
                          'How can the correctness of the system be affected by other systems or affect the correctness of others?')),
                  DropdownMenuItem(
                      value:
                          'What kind of knowledge or physical properties are required to use the system and how can this affect different types of users?',
                      child: Text(
                          'What kind of knowledge or physical properties are required to use the system and how can this affect different types of users?')),
                  DropdownMenuItem(
                      value:
                          'How could someone want to use the system in another context? And what can make that easier/more difficult?',
                      child: Text(
                          'How could someone want to use the system in another context? And what can make that easier/more difficult?')),
                  DropdownMenuItem(
                      value:
                          'What can make that easier/more difficult for the system to adapt itself to fit new usage scenarios?',
                      child: Text(
                          'What can make that easier/more difficult for the system to adapt itself to fit new usage scenarios?')),
                  DropdownMenuItem(
                      value:
                          "Which assets controlled by this system would be desirable to an attacker?",
                      child: Text(
                          "Which assets controlled by this system would be desirable to an attacker?")),
                  DropdownMenuItem(
                      value: 'What are the risks associated with these assets?',
                      child: Text(
                          'What are the risks associated with these assets?')),
                  DropdownMenuItem(
                      value:
                          'What are other likely vulnerabilities of the system?',
                      child: Text(
                          'What are other likely vulnerabilities of the system?')),
                  DropdownMenuItem(
                      value: 'How can the system support changes in workload?',
                      child: Text(
                          'How can the system support changes in workload?')),
                  DropdownMenuItem(
                      value: 'What can make that easier/more difficult?',
                      child: Text('What can make that easier/more difficult?')),
                ],
                onChanged: (value) {
                  print(value);
                  sus.questionTec = value ??
                      'How are the operating system and runtime environment expected to change what does that required from maintainers of this system?';
                }),
            const SizedBox(height: 15),
            CustomInput(
              onChanged: (value) => sus.answerTec = value,
              hint: "Technical Answer",
              inputBorder: OutlineInputBorder(),
            ),

            const SizedBox(height: 50),
            ElevatedButton(
                child: Text("Send"),
                onPressed: () {
                  print(sus.answerEco);
                  print(sus.answerTec);
                  print(sus.answerEnv);
                  print(sus.answerSoc);
                  print(sus.answerInd);
                }),
          ],
        ),
      ),
    ];
  }
}

class CustomBtn extends StatelessWidget {
  final Function? callback;
  final Widget? title;
  const CustomBtn({Key? key, this.title, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () => callback!(),
          child: title!,
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final InputBorder? inputBorder;
  final String? formProperty;
  final Map<String, String>? formValues;

  const CustomInput(
      {Key? key,
      this.onChanged,
      this.hint,
      this.inputBorder,
      this.formProperty,
      this.formValues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        onChanged: (v) => onChanged!(v),
        decoration: InputDecoration(hintText: hint!, border: inputBorder),
      ),
    );
  }
}

class CustomDropdownInput extends StatefulWidget {
  final String labelText;
  final String dropdownValue;
  final List<String> dropdownItems;
  final void Function(String) onChanged;

  CustomDropdownInput({
    required this.labelText,
    required this.dropdownValue,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  _CustomDropdownInputState createState() => _CustomDropdownInputState();
}

class _CustomDropdownInputState extends State<CustomDropdownInput> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue!;
              widget.onChanged(newValue);
            });
          },
          items: widget.dropdownItems
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

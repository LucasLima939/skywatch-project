# What's SkyWatch

SkyWatch is a cross-platform application developed using Flutter framework and it runs on the Android & iOS platforms.

Using SkyWatch you can check out the current weather for your localization, see the forecast for the next 4 days and share short videos showing the current weather.

## UI Reference
For compare the final UI with the designed UI/UX see
[Figma's SkyWatch project](https://www.figma.com/file/h1ZoyPKTIGRGXfVwYH6WJP/SkyWatch-(FoxBox)?type=design&node-id=0%3A361&mode=design&t=fsFKnHapC4GV3en9-1), which presents detailed components and color palettes.




## About the project

This project follows the Clean Architecture Pattern to separate each responsibility correctly.

The most intern layer is the entities' layer where we define the model's interfaces, then we have the use cases' layer where we define the actions the app can perform, the presenter's layer where we receive and transform data, and the most external is the UI layer where we update the events on screen.

<div  align="center">
    <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--LLKy1dWg--/c_imagga_scale,f_auto,fl_progressive,h_900,q_auto,w_1600/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xz9s4y9yyl6ilqzsluww.png" width="400"/>
    <p>Clean Architecture</p>
</div>

The project is composed by one single module, **Home Module**, but the modular composition allows us to add new modules in the future. Each module is independent by itself and global dependencies are injected by the **CoreModule**.

We're using [Modular Package](https://pub.dev/packages/flutter_modular) as router and dependency injector.

The folder structure organize the project as: data, domain and presentation. In order to follow the [Clean Architecture for Flutter](https://medium.com/@samra.sajjad0001/flutter-clean-architecture-5de5e9b8d093).



<div  align="center">  
    <img src="https://i.imgur.com/mjRNAst.jpg" width="200"/>
    <p>Folder Structure</p>
</div>

  

Some implemented **Design Patterns** in this project:
- Adapter;
- Interface;
- Singleton;
- Factory;
- Builder;

The project uses [Bloc](https://pub.dev/packages/flutter_bloc) as State Manager and it allows a robust management with easy mantaininment. Bloc receives events and emits states, updating the pages with BlocBuilders & BlocListeners.

## Coding Principles
The SOLID principles and others are extremely important to any project to follow, it makes the code more readable, the project scalable and easier to maintain.


<div  align="center">  
    <img src="https://media.geeksforgeeks.org/wp-content/uploads/20220910005416/SingleResponsibility2.png" width="300"/>
    <p>SOLID Principles</p>
</div>


## Tests
You can find some tests structures on the **/test** folder. The folder follows the src folder structure to make easier the identification.
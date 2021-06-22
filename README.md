# currency-converter
Currency converter app using clean swift

Architecture

currency-converter app employs clean architecture.
Also the code uses unit testing.
Background tasks to refresh the current current exchange rates which work every 30 minutes


Each scenes contains:

View Controller:
            Defines a scene and contains a view or views.
            Keeps instances of the interactor and router.
            Passes the actions from views to the interactor (output) and takes the presenter actions as input.
Interactor:
        Contains a Scene’s business logic.
        Keeps a reference to the presenter.
        Runs actions on workers based on input (from the View Controller), triggers and passes the output to the presenter.
        The interactor should never import the UIKit.
Presenter:
    Keeps a weak reference to the view controller that is an output of the presenter.
    After the interactor produces some results, it passes the response to the presenter. Next, the presenter sends appropiate signals to the viewcontroller.
Worker:
        An abstraction that handles different under-the-hood operations like fetch from Core Data, network calls etc.
        Should follow the Single Responsibility principle (an interactor may contain many workers with different responsibilities).
Models:
        Decoupled data abstractions.
Router:
        Extracts this navigation logic out of the view controller.
        Keeps a weak reference to the source (View Controller).
Configurator:
        Takes the responsibility of configuring the VIP cycle by encapsulating the creation of all instances and assigning them where needed.

# SeatGeekSearch

Find your favorite events fast by searching for their tickets using the SeatGeek API.  Save your favorites for easy reference.  

## Reading this doc will help you understand my code
By showing you:
1. How I Start
2. How I Tested while moving fast
3. What important decisions I made
4. How I managed tradeoffs

## How I Got Started

I started by opening my notebook and filling it with any immediate thoughts about the projects.  

I use a notebook because it helps me iterate faster. No deleting code lines or files, just me and my pencil.

These thoughts included: 
- Tools I would leverage
- Design Patterns. data structures, and algorithms I would leverage
- Models I would need
- all the states the app would be in
- anything else important to building

Once I'd gotten the initial thoughts out, I developed a rough draft "functional spec" -- one in which I listed out formally every state that app could possibly exist in.

Examples of that:
- Show no results
- Show search results
- Show failed results
- Show detail of a result

Once the specification was written, I could reverse engineer the states to create the needed classes, structs and functions, creating a very informal "Technical Spec".

These started with the `EventCoordinator` as the central hub for state management.  The notes resulted in needing things like:
- `EventSearchViewController`
- `EventTableViewController` with some type of Event data source
- `EventDetailViewController`
- `Event` model
- `EventAPIService`
- Some type of `FavoritesDataStore` that leveraged a Set for 0(1) access

And more.

This gave me the confidence to start programming.

## Testing As I Go: Leveraging Playground-Driven-Development to move fast

 Playground Driven Development (PDD) is a way to rapidly test small components of an app really fast.  
 Read here: https://medium.com/flawless-app-stories/playground-driven-development-in-swift-cf167489fe7b (I chose not to add Playgrounds directly to project as I've found that adds bugs often)
 
 Basically, you pull the component you're working on into a Playground so you can run and test it instantly.  
 
 The ability to iterate is faster than both testing through a live app or unit testing.  You don't have to wait for the app to build to either launch to a device or wait for the unit tests to all run, you simply press run and you get immediate feedback.
 
 Once the component works, its also easy to generate Unit Tests from the code, as you can copy and paste a lot of the logic to get started.

### How I leveraged PDD
Knowing the biggest risk of the app was getting the API to work seemlessly, I developed all of the necessary code to get successful `EventAPIService` calls into a Playground.

Once I got it working, I pasted and modularized that code in the app.  If I felt it could be better written, I'd return to the playground to do so.

I leverage this for other key components like:
- The Core Data algorithm 
- Getting the Date to print correctly
- Tweaking the `EventDetailViewController's` navigation bar to show the favorites button and navigation title correctly.  


## 3 Important Design Decisions I made and Why I Made Them
### 1. Choosing Core Data over Archiving & UserDefaults
`UserDefaults` is basically out of the question, because Favorites are not a setting and can become so big that they'll be unmanageable.  

In most cases when its comes down to Archiving & Core Data, I will almost always choose Core Data -- its faster, can hold more information and generally more efficient -- requiring more upfront code is not a good enough reason in most situations to use Archiving.  

Another choice I made was to query all the Favorites up front instead of on a per-search basis.  I thought that the cost of holding the Favorites string in memory rather than the cost of querying every search was a better trade off -- with the assumption most users won't have a five-figure favorites list.

Holding the Favorites' IDs in a `Set` makes sense because  `add` and `remove` approach O(1) complexity and `contains` is a O(1) operation.  The order of the list is unimportant.  

### 2. Using the Coordinator Pattern to manage state

Modern iOS Architecture requires avoiding the Massive View Controller problem, and one of the best emerging solutions for that is the FlowController, or the Coordinator Pattern.  

The Coordinator Pattern acts as the go-between between the Model/Data and the View/Visual side of the app.  It removes the need for `UIViewController`s to manage state, improving both reusability and testability. 

A supplement to the `EventCoordinator` was the `EventDataCoordinator` which handed the data off in a `ViewModel` to better represent how the data will be displayed to the user.

### 3. Using Promises to manage the API
Until Swift 5 adds the `async await` pattern, `PromiseKit` offers a great solution for capturing the state of an asynchronous task and avoiding embedded bracket hell.  

`Promises` made it very clear what was happening at what stage and, unless you're committing your entire project to `RxSwift`, adds a great plug and play solution that can be used only when needed.

## How I managed tradeoffs and the backlog
Just like any project, perfectionism needs to be contained to prioritize SHIPPING.  

There were a lot of changes I could have made to improve the project's stability, clarity, reusability or UI.

Most changes have been noted within the app using `TODO:` comment tag.  Finding all of the comments starting with that tag could be used to contribute to a  roadmap and backlog for the app's next few sprints.    




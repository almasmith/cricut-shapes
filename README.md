I made a pass through my code adding explanatory text where I thought it might be useful. Then I thought it might be useful to just collect those thoughts here:

## Layers/Isolation/SRP
I generally like to split my application into presentation and data layers with the data layer generally being responsible for persistence and ingestion (getting data from backend). If the complexity of the application grows significantly and not all logic is encapsulated on a backend, then I'll also add an application layer that handles business/application logic that isn't directly related to data transport/storage.
 
I prefer to isolate my UI from using network-based objects. This creates a little more boilerplate, but with current tools, it's not really a problem. So rather than the UI interfacing directly with the API, it uses application DTOs or model objects.  Doing this allows us to change whether or not information comes directly from an API call or from local storage without having the UI worry about it.

I really like to make my decodable objects just match API results exactly and worry about the way my application will use data somewhere else. In my mind, I just feel a lot more free here if I can write networking code without having to worry about how my UI or persistence needs to look at the data.

## Error Handling
I've handled errors a bunch of different ways and never settled on something that I really like. I'm just letting these errors bubble up to the UI, but I've done implementations where an application layer transforms api errors to application errors and the presentation layer transforms application errors into `LocalizableError`s.  But that's a lot of work and I haven't seen a huge payoff from it. I'm very open to other's preferences here.

## Networking/Actor Isolation
If I were managing managing shared resources here, this might change from a struct with static methods, to an actor in order to protect access to the shared resources.  For example if we were managing pagination across large result sets, or perhaps tracking download progress across multiple items.

## MVVM/Architecture
I've recnetly started moving away from MVVM. Mostly to leverage what Apple is providing us to simplify our workflow. However, in honesty this has primarily been on my own smaller scale projects and I don't have direct experience with how well this might scale.  At my last job, we were still using MVVM (albeit a modified version) extensively.

## Unit Testing
Not a ton to test right now. I'm not a huge fan of testing Apple's code. For example, you won't usually see me writing persistence tests to make sure what I'm writing to the DB is what I'm getting out of it. But of course if you had a validation layer that sat right above the DB, that would be something worthwhile to unit test. But I don't usually have a goal of 100% test coverage.

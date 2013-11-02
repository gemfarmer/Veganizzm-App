# Veganizzm App
## What would it do?

### The app would allow you to..
1. Search for vegan substitutes to non-vegan ingredients
2. Search by vegan ingredients or recipe type
3. House and display vegan recipes added to database
4. NOT NECESSARY create miniature version of Reciprocity to generate recipes based on provided ingredients
        * Reciprocity prompts users to submit an ingredient and returns a list of ingredients that it is commonly paired with.
        * Example: Enter Kale -> Return Cashews, Raisins, etc.


## Backend

#### Technologies
1. CoffeeScript, Node.js/Express
2. Node.js/Express
3. MongoDB
4. Socket.io
5. APIs 
	* Food2Fork: http://food2fork.com/about/api
	*Yummly: https://developer.yummly.com/
	*Veganizzm: http://veganizzm.com/
	*BigOven: http://api.bigoven.com/

#### Workflow 
1. Use API to get data from popular sites like allrecipes.com, foodnetwork.com, etc. for recipes as well as scrape Izzy's veganizzm.com site
2. Store data in MongoDB
3. Use Page Rank style algorithm to determine a.) importance of ingredient relative to other ingredients b.) absolute popularity of ingredient
4. Use algorithm to generate a projected composite score for any specified ingredient combination
5. Create Search engine for ingredients
6. Create list of 10 "suggested ingredients" that best fit in with the ingredients that are currently being used.

## Frontend

#### Technologies

1. CoffeeScript
2. Charts.js (possibly)
3. HTML5, CSS3
4. AngularJS

#### Workflow

1. Add visually appealing and useful search engine interface
2. Create display area for 10 "suggested items"
3. Create chart that creates a visual of the network created by a given recipe combination
4. Display overall score
5. Create user log ins and profiles that can be used to rate ingredient pairings
6. Ability to search for vegan or non-vegan ingredients
7. Provide ingredient-level or meal-level substitutes for ingredients

## Notes


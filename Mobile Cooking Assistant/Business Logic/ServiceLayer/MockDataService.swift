//
//  MockDataService.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/11/21.
//

import Foundation
import UIKit

protocol MockDataService: AnyObject {
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void)
    func fetchCategories(completion: @escaping ([Category]) -> Void)
}

final class BaseMockDataService: MockDataService {
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        let recipe1 = Recipe(id: 1, title: "Omelette", type: .lunch, note: "", numberOfPortions: 1, photo: .init(imageLiteralResourceName: "Omelette"), steps: [.init(id: 1, title: "1. Mixing the eggs", body: "Gently beat the eggs together in a mixing bowl and season, to taste, with salt and pepper.",                                                                            ingredients: [.init(id: 1, name: "3 free-range eggs"),
                                                                                                                                                                                                                                                                                                                                                                                                       .init(id: 2, name: "10g/½oz unsalted butter"),
                                                                                                                                                                                                                                                                                                                                                                                                       .init(id: 3, name: "30g/1oz cheddar, preferably Montgomery cheddar"),
                                                                                                                                                                                                                                                                                                                                                                                                       .init(id: 4, name: "1 thick slice ham, finely chopped")]),
                                                                                                                                                                .init(id: 2, title: "2. Cooking the omelette", body: "Heat the butter in a frying pan until foaming. Pour in the eggs and cook for a few seconds, until the bottom of the omelette is lightly set. Push the set parts of the omelette into the uncooked centre of the omelette. Cook again, until the omelette has set further, then push those set parts into the centre of the omelette again. Repeat the process until the eggs have just set but the omelette is still soft in the centre.",
                                                                                                                                                                      ingredients: [.init(id: 5, name: "30g/1oz cheddar, preferably Montgomery cheddar"),
                                                                                                                                                                                    .init(id: 6, name: "1 thick slice ham, finely chopped"),
                                                                                                                                                                                    .init(id: 7, name: "salt and freshly ground black pepper")]),
                                                                                                                                                                .init(id: 3, title: "3. Adding the cheese and ham", body: "Put the cheese and three-quarters of the ham in the centre of the omelette and cook until the cheese has melted.",
                                                                                                                                                                      ingredients: [.init(id: 5, name: "30g/1oz cheddar, preferably Montgomery cheddar"),
                                                                                                                                                                                    .init(id: 6, name: "1 thick slice ham, finely chopped"),
                                                                                                                                                                                    .init(id: 7, name: "salt and freshly ground black pepper")]),
                                                                                                                                                                .init(id: 4, title: "4. Finishing cooking the omelete", body: "Increase the heat to high and cook the omelette for a further 30 seconds, or until it browns on the bottom.",
                                                                                                                                                                      ingredients: [.init(id: 5, name: "salt and freshly ground black pepper")]),
                                                                                                                                                                .init(id: 5, title: "5. Serving the omelete", body: "Fold the omelette in half, then remove the pan from the heat and tilt it slightly to move the omelette to the edge of the pan. Slide the omelette onto a serving plate, then shape it into a neat roll. Sprinkle over the remaining ham.",
                                                                                                                                                                      ingredients: [])])
        
        let recipe2 = Recipe(id: 2, title: "Ricotta", type: .lunch, note: "", numberOfPortions: 1, photo: .init(imageLiteralResourceName: "Ricotta"), steps: [.init(id: 1, title: "1. Heat the milk", body: "Heat the milk and salt in a medium saucepan over a low heat for about 10 mins, stirring often, until it reaches 93°C on a sugar thermometer.",
                                                                                                                                                                    ingredients: [.init(id: 1, name: "1ltr whole milk (not filtered or longlife)"),
                                                                                                                                                                                  .init(id: 2, name: "¼ tsp salt"),
                                                                                                                                                                                  .init(id: 3, name: "2 tbsp lemon juice")]),
                                                                                                                                                              .init(id: 2, title: "2. Drain any excess whey", body: "Remove from the heat and stir in the lemon juice; the mixture should begin to look grainy. Cover the pan and set aside for 10 mins – curds of ricotta and a milky ‘whey’ should form. Line a sieve or colander with muslin and set over a bowl. Use a slotted spoon to carefully spoon the curds into the sieve; set aside for 45 mins to drain off any excess whey.",
                                                                                                                                                                    ingredients: [.init(id: 5, name: "2 tbsp lemon juice")]),
                                                                                                                                                              .init(id: 3, title: "3. Serve the ricotta", body: "The ricotta can now be eaten, plain or flavoured, or covered and chilled for up to 48 hrs.",
                                                                                                                                                                    ingredients: [])])
        
        let recipe3 = Recipe(id: 3,
                             title: "Cheesecake",
                             type: .lunch, note: "",
                             numberOfPortions: 2,
                             photo: .init(imageLiteralResourceName: "Cheesecake"),
                             steps: [.init(id: 1, title: "1. Preparation", body: "Heat oven to 180C. Line the base and sides of a 23cm springform tin with baking parchment.",
                                           ingredients: [.init(id: 1, name: "200g/7oz almond biscuits"),
                                                         .init(id: 2, name: "100g toasted flaked almond"),
                                                         .init(id: 3, name: "½ tsp almond extract"),
                                                         .init(id: 4, name: " 100g butter , melted")]),
                                     .init(id: 2, title: "2. Making the base", body: "Bash the biscuits and 75g of the flaked almonds to crumbs. Mix with the almond extract and melted butter, then press into the base of the prepared tin and bake for 10 mins. Set aside to cool while you make the filling.",
                                           ingredients: [.init(id: 5, name: "3 x 300g packs full-fat soft cheese"),
                                                         .init(id: 6, name: " 250g caster sugar"),
                                                         .init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 3, title: "3. Making the filling", body: "In your largest bowl, whisk the cheese with an electric whisk until creamy. Add the sugar and whisk to combine. Whisk in the flour, then the vanilla, the eggs, one at a time, and finally the soured cream.",
                                           ingredients: [.init(id: 5, name: "3 x 300g packs full-fat soft cheese"),
                                                         .init(id: 6, name: " 250g caster sugar"),
                                                         .init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 4, title: "4. Laying down the filling", body: "Dollop spoonfuls of mixture into the tin, dotting in tbsps of jam as you go. Smooth the top as gently as you can.",
                                           ingredients: [.init(id: 6, name: " 250g caster sugar"),
                                                         .init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 5, title: "5. Baking the cake", body: "Carefully place tin on the middle shelf of the oven and bake for 10 mins. Scatter with remaining almonds. Decrease oven to 110C/90C fan/gas ¼ and bake for a further 35 mins.",
                                           ingredients: [.init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 6, title: "6. Cooling the cake", body: "Turn off the oven, keep the door closed and leave cheesecake to cool for 1 hr. Open oven door and leave it ajar for another hour (you can use your oven gloves to wedge it open). Cool for a third hour at room temp, then cover and chill overnight.",
                                           ingredients: [.init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 7, title: "7. Serving the cake", body: "Remove from the tin and carefully peel off the parchment. Dust with icing sugar and serve with cream.",
                                           ingredients: [])])
        
        let recipe4 = Recipe(id: 4,
                             title: "Progressive Swiss roll",
                             type: .lunch,
                             note: "", numberOfPortions: 1,
                             photo: .init(imageLiteralResourceName: "SwissRoll"),
                             steps: [.init(id: 1, title: "1. Mix eggs with sugar", body: "Preheat the oven to gas 6, 200°C, fan 180°C and line a 25 x 35cm baking tray with nonstick baking paper. Put the sugar and eggs in a large bowl and beat with an electric whisk on medium-high for 10 mins until thick and airy. Divide the mixture evenly into 3 bowls.",
                                           ingredients: [.init(id: 1, name: "6 tbsp caster sugar"),
                                                         .init(id: 2, name: "3 large eggs"),
                                                         .init(id: 3, name: "1 tsp pink food colour gel"),
                                                         .init(id: 4, name: "1 tsp blue food colour gel"),
                                                         .init(id: 5, name: "9 tbsp self-raising flour")]),
                                     .init(id: 2, title: "2. Colouring", body: "Add the pink food colour gel to one portion and the blue food colour gel to another; gently fold into the mixture with a spatula until no specks of gel can be seen. Leave the third bowl uncoloured.",
                                           ingredients: [.init(id: 6, name: "1 tsp gelatine powder (optional)")]),
                                     .init(id: 3, title: "3. Add flour", body: "Sieve 3 tbsp flour over each of the 3 mixtures. Gently fold in the flour, cleaning your spatula between each bowl.",
                                           ingredients: [.init(id: 7, name: "4 tbsp seedless fruit jam, such as raspberry")]),
                                     .init(id: 4, title: "4. Put the mixture into piping bags", body: "Transfer the mixes into 3 piping bags fitted with a large round nozzle, or cut to make a 1cm wide opening. Pipe a line of plain mix diagonally from one corner of the tray to the other. Sandwich this with a line of pink mixture either side, then sandwich the pink mixture with a line of blue. Repeat using the pink, then plain, back to pink, and blue until the tray is covered. If you have any left over, you can top up the lines you’ve already piped.",
                                           ingredients: [.init(id: 8, name: "200ml whipping cream")]),
                                     .init(id: 5, title: "5. Bake", body: "Bake on the middle shelf of the oven for 8-10 mins until the sponge is light golden. Lay a clean, damp tea towel on a surface and carefully slide the sponge onto it, pulling down any paper if it’s sticking up. Roll up the sponge widthways in the tea towel and leave to cool completely.",
                                           ingredients: [.init(id: 9, name: "60g raspberries")]),
                                     .init(id: 6, title: "6. Unroll", body: "Unroll the cake and peel away the paper, keeping it under the cake.",
                                           ingredients: []),
                                     .init(id: 7, title: "7. Add the filling", body: "Spread the jam over the sponge followed by the whipped cream, leaving a 1cm border. Scatter the raspberries and blueberries over the cream, then use the paper to help you carefully roll up the cake, keeping an eye on the far edge so no fruit escapes. Roll the cake so the seam is at the bottom.",
                                           ingredients: [.init(id: 10, name: "60g blueberries"),
                                                         .init(id: 11, name: "icing sugar, for dusting")]),
                                     .init(id: 8, title: "8. Put the cake into the fridge", body: "Transfer to the fridge for 6 hrs to set then dust with icing sugar before serving.", ingredients: [])])
        
        let recipe5 = Recipe(id: 5,
                             title: "Mini egg muffins",
                             type: .lunch, note: "",
                             numberOfPortions: 1,
                             photo: .init(imageLiteralResourceName: "Muffins"),
                             steps: [.init(id: 1, title: "1. Mix eggs and cheese", body: "In a large jug or mixing bowl, gently whisk together 6 eggs and 360g cottage cheese until combined.",
                                           ingredients: [.init(id: 1, name: "6 eggs"),
                                                         .init(id: 2, name: "360g cottage cheese")]),
                                     .init(id: 2, title: "2. Add peppers", body: "Drain the peppers from a 285g jar roasted peppers antipasti and pat dry with kitchen paper. Slice into thin strips and stir into the egg mix.",
                                           ingredients: [.init(id: 3, name: "285g jar roasted peppers antipasti, drained and patted dry with kitchen paper")]),
                                     .init(id: 3, title: "3. Bake", body: "Divide the mixture between the holes of a greased 12-hole muffin tray. Bake in a preheated oven at gas 7, 220°C, fan 200°C for 16-18 mins until puffed up, golden and set.",
                                           ingredients: [.init(id: 4, name: "oil, for greasing")]),
                                     .init(id: 4, title: "4. Serve", body: "Cool slightly before removing from the tin. Serve warm or allow to cool completely.",
                                           ingredients: [])])
        
        completion([recipe1, recipe2, recipe3, recipe4, recipe5])
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        let category1 = Category(id: 1, title: "Breakfast", image: .init(imageLiteralResourceName: "Breakfast"), recipes: [])
        let category2 = Category(id: 2, title: "Dessert", image: .init(imageLiteralResourceName: "Dessert"), recipes: [])
        let category3 = Category(id: 3, title: "Main course", image: .init(imageLiteralResourceName: "MainCourse"), recipes: [])
        let category4 = Category(id: 4, title: "Salads", image: .init(imageLiteralResourceName: "Salads"), recipes: [])
        
        completion([category1, category2, category3, category4])
    }
}

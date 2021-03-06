//
//  Facts.swift
//  Bout Time
//
//  Created by Alex Koumparos on 29/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

// A simple (but unsafe) list of facts ready to be converted to safe HistoricalEvent objects
let simplifiedData = [
    ("Fabbrica Italiana de Penne a Serbatoio-Aurora founded in Torino", 1919, "https://www.iguanasell.com/pages/aurora-pens-history"),
    ("Aurora begins producing celluloid pens", 1925, "https://www.iguanasell.com/pages/aurora-pens-history"),
    ("Aurora's facilities were destroyed in the bombing of Turin", 1943, "https://www.iguanasell.com/pages/aurora-pens-history"),
    ("Aurora introduces its most well-known model, the Aurora 88", 1947, "https://www.iguanasell.com/pages/aurora-pens-history"),
    ("Alonzo Townsend Cross born", 1846, "https://crossroadsman.github.io/pen-facts/#A-T-Cross"),
    ("Cross went public on the American Stock Exchange", 1972, "https://crossroadsman.github.io/pen-facts/#A-T-Cross"),
    ("August Eberstein founded the Simplizissimus-Füllhalter company in Berlin", 1906, "hhttps://www.gentlemansgazette.com/montblanc-meisterstuck-fountain-pen/"),
    ("Montblanc first put a white tip on the cap of its pens", 1910, "https://www.collectorsweekly.com/pens/montblanc"),
    ("Montblanc introduces the Meisterstück branding", 1924, "https://www.collectorsweekly.com/pens/montblanc"),
    ("Montblanc introduces the 'star' logo to symbolize the snow-covered tip of Mont Blanc", 1914, "https://www.gentlemansgazette.com/montblanc-meisterstuck-fountain-pen/"),
    ("Nakaya Fountain Pen Company formed by Toshiya Nakata together with several retired Platinum craftsmen", 2000, "https://crossroadsman.github.io/pen-facts/#Nakaya"),
    ("Nakaya launches Maki-e decorated converters", 2005, "https://crossroadsman.github.io/pen-facts/#Nakaya"),
    ("Nakaya launches the Decapod, a ten-faced ebonite pen", 2006, "https://crossroadsman.github.io/pen-facts/#Nakaya"),
    ("George Safford Parker is born", 1863, "https://crossroadsman.github.io/pen-facts/#Parker"),
    ("Parker obtains the first patent on the slip-fit type of outer cap", 1898, "https://crossroadsman.github.io/pen-facts/#Parker"),
    ("Parker obtains a patent on mechanically-filled pen", 1904, "https://crossroadsman.github.io/pen-facts/#Parker"),
    ("Parker introduces the brightly-coloured Duofold", 1921, "https://crossroadsman.github.io/pen-facts/#Parker"),
    ("Parker introduces the enduring and innovative Parker 51", 1941, "https://crossroadsman.github.io/pen-facts/#Parker"),
    ("Parker launches its first cartridge filled pen, the Parker 45", 1960, "https://crossroadsman.github.io/pen-facts/#Parker"),
    ("Pelikan releases the M400, the first pen to be given the Souverän moniker", 1982, "https://thepelikansperch.com/2015/11/05/pelikan-m1000-review/"),
    ("Pelikan releases the M1000, its largest pen", 1997, "https://thepelikansperch.com/2015/11/05/pelikan-m1000-review/"),
    ("Namiki MFG-Pilot changes its name to Pilot", 1938, "https://crossroadsman.github.io/pen-facts/#Pilot"),
    ("Pilot creates the Kaiten-shiki prototype, its first retractable capless fountain pen", 1962, "https://crossroadsman.github.io/pen-facts/#Pilot"),
    ("Pilot launches its first capless click-system fountain pen", 1964, "https://crossroadsman.github.io/pen-facts/#Pilot"),
    ("Pilot introduces the futuristic-looking Myu 701, the first commercial solid stainless-steel pen with an integrated nib", 1971, "https://crossroadsman.github.io/pen-facts/#Pilot"),
    ("Ryosuke Namiki born", 1880, "https://crossroadsman.github.io/pen-facts/#Pilot"),
    ("Platinum launches the #3776 (representing the height of Mt. Fuji in metres)", 1978, "https://crossroadsman.github.io/pen-facts/#Platinum"),
    ("Saijirō Sakata receives a prize from the National Industrial Exhibition for his nibs", 1909, "https://crossroadsman.github.io/pen-facts/#Sailor"),
    ("Sakata Seisakusho company founded in Inari-cyo, Kure, by Kyogorō Sakata. The company sells pens under the brand name sailor", 1911, "https://crossroadsman.github.io/pen-facts/#Sailor"),
    ("Sailor introduces the King Profit, also known as King of Pen, an oversized fountain pen to compete directly with the Montblanc 149 and Pelikan M1000", 2003, "https://crossroadsman.github.io/pen-facts/#Sailor"),
    ("Walter Sheaffer born in Bloomfield, Iowa", 1867, "https://crossroadsman.github.io/pen-facts/#Sheaffer"),
    ("Sheaffer's pen business begins when Walter Sheaffer converts his jewelry shop into a pen factory", 1912, "https://crossroadsman.github.io/pen-facts/#Sheaffer"),
    ("W. A. Sheaffer Pen Company incorporated", 1913, "https://crossroadsman.github.io/pen-facts/#Sheaffer"),
    ("Sheaffer introduces the Lifetime pen, with a lifetime guarantee for the first owner", 1920, "https://crossroadsman.github.io/pen-facts/#Sheaffer"),
    ("Sheaffer introduces the complex and innovative Snorkel filling system", 1952, "https://crossroadsman.github.io/pen-facts/#Sheaffer"),
    ("Sheaffer launches the successful 'Targa by Sheaffer' line", 1976, "https://crossroadsman.github.io/pen-facts/#Sheaffer"),
    ("Visconti is formed in Florence", 1988, "https://www.stilografica.it/products/visconti-pens"),
    ("Visconti introduces the Homo Sapiens, made with a body of lava, sourced from Mt. Etna", 2010, "https://www.forbes.com/sites/nancyolson/2016/04/13/visconti-creates-pen-from-lava/#7f100c6d1c96"),
    ("Lewis Edson Waterman born in Decatur, NY", 1837, "https://crossroadsman.github.io/pen-facts/#Waterman"),
    ("L. E. Waterman granted a patent for the 'fissure feed' which made fountain pens practical", 1884, "https://crossroadsman.github.io/pen-facts/#Waterman"),
    ("The Waterman C/F, the world's first commercially successful cartridge fountain pen is launched", 1953, "https://munsonpens.wordpress.com/category/waterman-cf/"),
]

let events = EventHelper().convertSimpleEvents(events: simplifiedData)

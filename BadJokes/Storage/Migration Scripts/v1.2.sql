-- Database changes for app version: 1.2

-- Rename a joke type
UPDATE jokes SET type='geek' WHERE type='IT';

-- Add more jokes to the collection
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, tegyen a tűzre!\n- Székestől, uram?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, ez a vonat Hatvan felé megy?\n- Nem, Uram, csak egyfelé.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, tud maga vezetni?\n- Igen, uram.\n- Akkor vezesse be a pincébe a villanyt!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean! Miért dobta bele az órámat a gőzölgő fazékba?\n- Mert fő a pontosság, uram!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, elég a pénzünk hó végéig?\n- Csak ha meggyújtom, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mit adnak ma a színházban?\n- A III. Richardot, uram.\n- Akkor el sem megyünk, mert nem láttuk az első két részt!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, berúgta a motort?\n- Igen uram, ott fekszik az árokban.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, csináljon huzatot!\n- Minek uram?\n- Mert át kellene húzni a párnákat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, miért van hátul a mókus farka?\n- Mert elöl a mókus van, uram!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért csak az idősek látszanak a rendőr fotóján?\n- Mert csak 60 felett fényképez.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért nem vesz a rendőr zsebszámológépet?\n - ???\n- Mert fejből is tudja, hogy hány zsebe van.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- A rendőrök a bevetés előtt időt egyeztetnek.\n- Na, emberek, a pontos idő 11:48. Akiknek digitális órájuk van:\nvonal, vonal, kisszék, hóember.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Mire vár a rendőr a szekrény mögött?\n- ???\n- Hogy előléptessék.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Rendőr a másiknak:\n- HA kitalálod hány fánkot vettem, tiéd lehet mind a kettő!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Két rendőr barchobázik:\n- Lehet vele repülni? - kérdezi az első.\n- Hülye vagy, egy hamutartóval?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Mit ír ki a Windows Vista, amikor lefagy?\n- ???\n- Astala Vista!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Hogy hívják a magányosan álló egérmutatót?\n- ???\n- Robinson Cursor!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Hogy hívják az számítógépet használó szerzetest?\n- ???\n- Felhasználó barát.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Mi a különbség a kutyaszar és a Win95 között?\n- ???\n- A kutyaszarból ki lehet lépni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- És milyen domain nevet szeretne?\n- ???\n- Mittu domain!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Hogy hívják az informatikus nyomozót?\n- ???\n- Numlock Holmes.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért mászik fel a szőke nő a villanyoszlopra?\n- ???\n- Azért, hogy megbassza az áram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért rakja a szőke nő a poros szőnyeget a hűtőszekrénybe?\n- ???\n- Hogy kirázza a hideg.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mit kér a szőke nő a svédasztalnál?\n- ???\n- Tolmácsot.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért rak a szőke nő sapkát és sálat a számítógépre?\n- ???\n- Hogy el ne kapjon valamilyen vírust…');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Hogyan öli meg a szőke nő a vakondot?\n- ???\n- Élve eltemeti.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért nyitja ki a szőke nő a szülészeten az ablakot?\n- ???\n- Mert várja a gólyát.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mit vár a szőke nő a kád mellett?\n- ???\n- Hogy a melegvízes csap jelzése végre zöldre váltson.');

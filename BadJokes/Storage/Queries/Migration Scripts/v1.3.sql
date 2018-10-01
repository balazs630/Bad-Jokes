-- Database changes for app version: 1.3

-- Rename a joke type
UPDATE jokes SET type='moricka' WHERE type='móricka';

-- Fix typos in joke texts
UPDATE jokes SET jokeText='- A sivatagban él és látszólag semmi dolga nincs, mi az?\n- ???\n- Ücsörgőkígyó.' WHERE jokeText='- A sivatagban él és látszólag semm dolga nincs, mi az?\n- ???\n- Ücsörgőkígyó.';
UPDATE jokes SET jokeText='- Rendőr a másiknak:\n- Ha kitalálod hány fánkot vettem, tiéd lehet mind a kettő!' WHERE jokeText='- Rendőr a másiknak:\n- HA kitalálod hány fánkot vettem, tiéd lehet mind a kettő!';
UPDATE jokes SET jokeText='- Mit csinál az űrhajós ha megszomjazik?\n- ???\n- Űrkutat ás.' WHERE jokeText='- Mit csinál az űrjahós, ha megszomjazik?\n- ???\n- Űrkutat ás.';
UPDATE jokes SET jokeText='- Mi a közös a nőben és a gyufában?\n- ???\n- Ha benedvesedik, akkor baszhatod!' WHERE jokeText='- Mi a közös a nőben és a gyufában?\n- ???\n-  Ha benedvesedik, akkor baszhatod!';
UPDATE jokes SET jokeText='- Hogy hívják a számítógépet használó szerzetest?\n- ???\n- Felhasználó barát.' WHERE jokeText='- Hogy hívják az számítógépet használó szerzetest?\n- ???\n- Felhasználó barát.';
UPDATE jokes SET jokeText='- Jean, mi ez a dübörgés a szekrényben?\n- ???\n- Csak a ruhák mennek ki a divatból uram!' WHERE jokeText='- Jean, mi ez a dubörgés a szekrényben?\n- ???\n- Csak a ruhák mennek ki a divatból uram!';
UPDATE jokes SET jokeText='- Móricka, mondj egy téli zöldséget!\n- Síparadicsom!' WHERE jokeText='- Móriczka, mondj egy téli zöldséget!\n- Síparadicsom!';
UPDATE jokes SET jokeText='- Móricka, mit eszik az orángután?\n- ???\n- Még sosem ettem orangot, és tessék inkább tegezni Tanárnő!' WHERE jokeText='- Móriczka, mit eszik az orángután?\n- ???\n- Még sosem ettem orangot, és tessék inkább tegezni Tanárnő!';
UPDATE jokes SET jokeText='- Móricka, ilyen piszkosan nem mehetsz az olimpiára!\n- De anyu, ez csak díszkosz.' WHERE jokeText='- Móriczka, ilyen piszkosan nem mehetsz az olimpiára!\n- De anyu, ez csak díszkosz.';
UPDATE jokes SET jokeText='- Miért nem tanult meg Móricka vízisízni?\n- ???\n- Mert nem talált lejtős tavat.' WHERE jokeText='- Miért nem tanult meg Móriczka vízisízni?\n- ???\n- Mert nem talált lejtős tavat.';

-- Add more jokes to the collection
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért fényesíti ki a rendőr a sakkfigurát?\n- ???\n- Nehogy matt legyen.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogy hívják a lengyel kocsmárost?\n- ???\n- Mikornyicki.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- A bogarak fociznak a réten.\nA hőscincér odamegy az egyik padon ülő bogárhoz és megkérdezi:\n- Te miért nem játszol?\n- Nem látod? Én vagyok a cserebogár.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, miért füstöl a kórház kéménye?\n- ???\n- Fő az egészség, uram!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Pincér, ebben a húslevesben nincs hús!\n- Na és? A halászlében sincs halász!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, hallott arról, hogy már az állatok is lövöldöznek?\n- Nem uram, de miért kérdezi?\n- Azt írja az újság, hogy agyonlőtte a menyét.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mit csinál a szőke nő, ha egy süllyedő hajóban a nyakáig ér a víz?\n- ???\n- Fejre áll, hogy csak a bokájáig érjen.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- A szőke nő bemegy a McDonald''s-ba:\n- Kérek egy sajtburgert és egy kis krumplit.\n- Itt fogyasztja? - kérdi az eladó.\n- Nem, ott a hátsó asztalnál.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Miért nem beszélnek egymással a gumimacik?\n- ???\n- Haribó…');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Hogy hal meg a teniszező?\n- ???\n- Megáll benne az ütő.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Miért megy a kátrány focimeccsre?\n- ???\n- Szurkolni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Két vívóedző összefut edzés után:\n- Mondd kolléga, te hogyan választod ki hogy kit vizsgáztatsz?\n- Hát, szúrópróbaszerűen!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- A búvár a tengerbe való beugrás előtti percekben telefonon beszélget a feleségével, amikor hirtelen megszólal:\n- Na, most már leteszem drágám, mert mindjárt lemerülök!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Két óvodás beszélget a játszótéri mászókák alatt. A maszatosabb képű a bokrok felé mutat:\n- Nézd! Ott egy kiszisza!\n- Nahát! Te még nem tudod kimondani, hogy matka?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mért volt szegény Petőfi Sándor?\n- ???\n- Mert keveset keresett és sokat költött.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Tudod hány gyereke van a félbolondnak?\n- ???\n- Ötven, mert egy bolond százat csinál!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Megmondaná kérem, hogy merre van a legközelebbi Baumax?\n- Nálunk csak Obi van, Kenobi.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Hogy hívják a még nagyon fiatal péksüteményt?\n- ???\n- Embriós.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Két fizikai töltés beszélget:\n- Hát te meg hogy nézel ki?\n- Na, te sem vagy Coulomb!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Három tojás megy a sivatagban. Az első azt mondja:\n- Előttem a Szahara, hátam mögött pedig három tojás.\nHogy lehet ez ha csak hárman vannak?\n- ???\n- A második tükörtojás.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Lim és Lom mennek az erdőben.\nLom minden lépésnél ás egy í-t a földbe. Mennek tovább az erdőben, Lom pedig továbbra is ás. Egyszercsak Lim találkozik az erdésszel és megkérdezi tőle, mit csinál Lom.\nAz erdész gondolkodik egy kicsit, majd kiböki:\n- Társadalombiztosítás');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','A férj hazamegy a vadászatból és a felesége kérdi, hogy van-e valami? Mire a férj:\n- Képzeld, elejtettem egy nyulat.\n- Na és? Hol van? - kérdi a feleség.\n- Mondom hogy elejtettem!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','A híres fotóst vendégségbe hívják. A vacsora után a háziasszony beszélgetésbe elegyedik vele:\n- Gratulálok a képeihez, nagyon szépek! Biztosan jó fényképezőgépe van.\nErre a fotós:\n- Gratulálok a vacsorához, nagyon finom volt! Biztosan nagyon jó fazekai vannak!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Két egér sétálgat a hűtőszekrényben.\nMegszólal az egyik:\n- Vigyázz, mert mindjárt rád esik a margarin!\n- Rám a margarin?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','A szerszámok játszanak a szerszámkereskedésben. Megszólal az egyik:\n- Te vagy a fogó!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi az, hosszú és vérzik?\n- ???\n- Sebes vonat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Kérek egy szintetizátort.\n- Sajnos uram, a szintetizátorunk elfogyott, de ajánlhatok helyette egy tizát.\n- Tizát? Az mi?\n- Kérem, az már szinte tizátor.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért rakja a szőke nő a poros szőnyeget a hűtőszekrénybe?\n- ???\n- Hogy kirázza a hideg.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mi a hasonlóság a vasúti sínek és a szőke nők között?\n- ???\n- Az egész országban le vannak fektetve.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért nem cseréli ki a szőke nő az akvárium vizét?\n- ???\n- Mert azt várja, hogy a halak megigyák az előző adagot.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért van a szőke nőnek négyszögletes melle?\n- ???\n- Mert elfelejtette kivenni a szilikont a dobozból.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mit csinál a szőke nő, ha látja az ajtón a HÚZNI feliratot?\n- ???\n- Elkezdi mondani: hogy hu-hú, hu-hú...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Hogyan ismerjük fel a szőke iskoláslányt?\n- ???\n- Amikor a tanár letörli a táblát, a lány kiradírozza a füzetét.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért megy a szőke nő egy konzervvel a háza tetejére?\n- ???\n- Mert az van a konzervre írva, hogy a szavatossági idő a tetőn van!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Honnan tudod, hogy egy szőke e-mailt szeretne küldeni?\n- ???\n- A CD meghajtó tele van borítékokkal.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért dobál a szőke nő a vécébe kenyérdarabkákat?\n- ???\n- Eteti a toalett kacsát.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Hol fészkel az intermadár?\n- ???\n- Interfészekben.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','Pistikét irodalomórán a tanárnéni megszólítja:\n- Pistike! A Mikszáth-ot véletlenül X-szel írtad!\n- Dehogyis Tanárnő! Az DirectX.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Válóper során kérdezi a bíró a házaspár gyerekétől:\n- Szeretnél apáddal élni?\n- Nem szeretnék mert mindig megvert.\n- Akkor, hol szeretnél lakni?\n- Szeretnék a magyar fociválogatotthoz költözni, ők sosem vernek meg senkit.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mit csinál a haldokló focista?\n- ???\n- Az utolsókat rúgja.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi a legkedveltebb téli sport?\n- ???\n- A hosszú-távfűtés.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','A skót kisfiú megkérdezi az apjától:\n- Apa, mi lesz karácsonykor a fa alatt?\n- Parketta, kisfiam.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Vízirendőröknél sorozás van:\n- Jelölt! Most azonnal ússzon le kétszáz métert!\n- Na de főtörzs! Hát ez a medence nincs is olyan mély!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr megállítja a szőke nőt:\n- Jogosítványt, forgalmit, személyit kérek!\n- Mi az a személyi? - kérdezi a szőke nő.\n- Az egy olyan tárgy amiben látja a saját képét.\nKeresgél a szőke nő a retiküljében, talál egy tükröt, belenéz, aztán odaadja a rendőrnek.\n- Jaj, hát miért nem ezzel kezdte, kolléga?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr beszélget:\n- Te mivel eszed a tésztát?\n- Rádióval.\n- Hogyhogy?\n- Tudod az asszony mindig megkérdezi hogy: kérsz rá diót?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr vonatjegyet vásárol:\n- Egy retúr jegyet kérek.\n- Hová? - kérdezi a pénztáros.\n- Na mégis mit gondol? Ide vissza!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Rendőrök beszélgetnek:\n- Úgy szeretném ha anyámnak sok szárnyasállata lenne otthon!\n- Miért?\n- Hát szegény minden reggel azon sóhajtozik, hogy neki csak egyetlen barom-fia van.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Hogy hívják a fej és végtagok nélküli rendőrt?\n- ???\n- Törzsőrmester.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Az új híd felavatása után odaállítanak egy rendőrt hogy számolja meg, hány ember megy át a hídon.\nA rendőr számolja:\n- 4 fő, 5 fő, 6 fő 7 fő, kedd, szerda...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr járőrözik. Találnak egy tükröt.\n- Te, ez a fazon nagyon ismerős nekem valahonnan!\nMegnézi a másik is és levonja a következtetést:\n- Én is ismerem, mindig velem szemben ül a fodrásznál!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr megkérdezi a kollégáját:\n- Te Sanyi, hogy lehet ezeket a böhöm nagy repülőgépeket csak úgy eltéríteni?\n- Te hülye, hát nem itt lent a földön térítik el, hanem fönt, ahol már egész kicsi.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr megy az utcán, találnak egy gumibotot, az egyik megszólal:\n- Te ez nem a Béláé?\n- Kizárt, ő tegnap elvesztette.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr igazoltat:\n- Rakják a földre a személyit, jogosítványt és a gépjármű forgalmi engedélyét!\n- De biztos úr, a föld csupa sár!\n- Csönd legyen! A törzsőrmester megparancsolta nekem, hogy vegyem fel az adataikat!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr kint áll a szakadó esőben és a felesége által csomagolt szendvicset eszi.\nA kollégák döbbenten nézik:\n- Józsi, miért nem jösz be ide az őrszobára enni?\n- Azt mondta az asszony, akkor egyek, amikor jólesik.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Autóst büntet a rendőr:\n- Felírom gyorshajtásért!\n- Még mindig jobb, mint ha én írnám fel magát!\n- Miért, kicsoda maga?\n- A sírköves.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért vágja a rendőr felesége a küszöbön a fát?\n- ???\n- Mert a tuskó szolgálatba ment.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr beszélget:\n- Mit eszel?\n- Szendvicset.\n- Mivel?\n- Mivel éhes vagyok.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Miért gyűlölik a politikusok a Trabantot?\n- ???\n- Mert kormányváltós.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Tanárnő a gyerekhez:\n- Móricka, van házid?\n- Van. Töltsek?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Hány órát alszol egy nap Móricka? - kérdezi az iskolaorvos.\n- Két-három órát.\n- Jajj, de hát ez nagyon kevés!\n- Mind az öt órán nem merek aludni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Móricka hatalmas c betűket rajzol kishugára mikor bejön az anyukája.\n- Hát te mit csinálsz Móricka a kishugoddal?\n- Én semmit csak becézem!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','A tanárnő kérdezi a diákokat:\n- Csabi. Te mért szereted Szandit?\n- Mert olyan szép!\n- Pistike. Te mért szereted Szandit?\n- Mert annyira jól énekel!\n- És te Móricka miért szereted Szandit?\n- Mert nyáron nem izzad benne a lábam!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Móricka elmegy a zöldségeshez:\n- Kérnék pár szilvát.\n- Na jó, de hányat.\n- Igen? Akkor inkább nem kérek.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mi a sebész kedvenc étele?\n- ???\n- Sebesült.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Tudtad, hogy Indonéziában a sok földrengés hatására két új áruház is megnyitott?\n- ???\n- A Richter Skála meg az Epi Centrum.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Képzeld, tegnap 20 percig ültem egy villamosszékben.\n- Huhh, és hogy maradtál életben?\n- Leszálltam a végállomáson.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Na és, hogy vezet a lányod?\n- Sakkosan.\n- Sakkosan? Hogy érted?\n- Egyszer egy gyalogost, másszor egy futót üt el.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Józsi bácsi felmutatja a vonatjegyét a kalauznak, mire az így reagál:\n- De hiszen ez egy diákjegy!\n- Na, látja, most derül ki, hogy milyen nagy késésben van ez a vonat!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Hé kocsmáros, mennyibe kerül a sör?\n- A pohár 220, a korsó 330.\n- Aha, értem. És a sör?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Megkérdezi az egyik részeg a másikat:\n- Te miért iszol mindig csukott szemmel?\n- Mert az orvos azt mondta, hogy mostantól nem nézhetek a pohár fenekére!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Hogy hívják a sportos szeszesitalt?\n- ???\n- Olimpia.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Hol lakik Tarzan?\n- ???\n- Inda House.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi a csontváz kedvenc hangszere?\n- ???\n- A sípcsont.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Miért feszül Superman pólója?\n- ???\n- Mert S-es...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Milyen fegyverrel védekeznek a hangversenyen az előadóművészek?\n- ???\n- Operatőrrel.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Melyik a legrosszabb gyógyszer a világon?\n- A 9.\n- Miért?\n- Mert fordítva hat!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mit csinál a terminátor éneklés előtt?\n- ???\n- Megköszörüli a torkát.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi lesz a lovas ólomkatonából, ha átmegy rajta az úthenger?\n- ???\n- Lemez lovas.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Milyen mosogatógépe van Kőműves Kelemennek?\n- ???\n- Beépített.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mi a különbség a matektanár és a prostituált között?\n- ???\n- Az, hogy a prostituált halmozza az élvezeteket, a matektanár pedig élvezi a halmazokat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Melyik az egyetlen alkalom, amikor egy szőke nő nem néz bele a tükörbe?\n- ???\n- Amikor kifelé tolat a parkolóból.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogy hívják a félénk tolltartót?\n- ???\n- Attól-tartó...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mit mond a kéményseprő a tükör előtt?\n- ???\n- A koromhoz képest jól nézek ki.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogyan kell elhallgattatni a sámánt?\n- ???\n- Hallgass-sámán!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Miért a talpad a legkisebb sakktábla?\n- ???\n- Mert azon csak egy paraszt áll!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Két finn szauna beszélget:\n- Téged miért zártak be?\n- Gőzöm sincs...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mit hall az indián a síneken?\n- ???\n- Szörnyet.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogy válaszol James Bond ha megkérdezik tőle, hogy mennyi az idő?\n- ???\n- Három. Negyed három.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi az: egy betű és családtag?\n- ???\n- Nagyi.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogyan nevezik a búslakodó békaember víz alatti kastélyát?\n- ???\n- Bú-vár.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Melyik a legjobb gyógyszer?\n- A mínusz öt.\n- Miért?\n- Mert az egyből hat!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi rosszabb a sörhasnál?\n- ???\n- A pizzahát!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mit mond a félbevágott színésznő?\n- ???\n- Idén két darabban játszom.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogy hívják a cukrászok vizsgadolgozatát?\n- ???\n- Desszertáció.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, hogy áll a barométer?\n- Esett, uram.\n- És mennyit?\n- A falról a földig.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean! Gyújtsa föl a szomszéd grófnő házát!\n- De minek, uram?\n- Mert háztűznézőbe akarok menni hozzá.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, szaladjon előttem egy égő gyertyával.\n- Miért, uram?\n- Fényűző szeretnék lenni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, eressze le az órát az ablakon.\n- Minek, uram?\n- Fel akarom húzni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Vadászni megyek Jean! Hol van a sörét?\n- Elnézést, uram de a sörét megittam.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean! Miért van egy nyitott könyv az ablakban?\n- Mert betűz a nap, uram!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, evezzen ki a korallzátonyhoz!\n- De miért uram?\n- Mert haladni kell a korall!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, ma este a kastély keleti szárnyában tálalja a vacsorát!\n- Miért, uram?\n- Mert azt mondta a fogorvosom, hogy pár napig a másik oldalon egyek.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, csináljon huzatot!\n- Minek uram?\n- Mert át kellene húzni a párnákat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mégsem veszem meg azt a Picasso festményt.\n- Miért nem, uram?\n- Nincs rá keret.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, legyen szíves döntse meg egy kicsit az asztalt!\n- Miért, uram?\n- Dőlt betűvel szeretnék írni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','Nagyon esik az eső, így a lord kiszól az udvarra:\n- Jean Te ázol odakint?\n- Dehogy teázom, be akarok menni!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mit csinál azzal a kefével?\n- Az őrület határát súrolom, uram!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, volt az ügetőn?\n- Igen uram!\n- Feltette azt az ezrest a 8-as lóra?\n- Igen uram!\n- És mi történt?\n- A zsoké levette a lóról és megköszönte!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mit tárcsáz a telefonon?\n- Semmit uram, csak a figyelmét akarom felhívni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, ma vendégek jönnek. Vágjunk jó képet hozzájuk.\n- A falon lévő Picasso jó lesz, uram?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, kóstolja meg ezt a konyakot! Mit talál benne furcsának?\n- Azt, hogy megkínált vele uram!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Móricka, sorolj fel néhány állatot! - mondja a tanárnő az iskolában.\n- Kutyuska, tehénke, disznóka.\n- Jó, de nem kell mindig utána mondani a kicsinyítőképzőt!\n- Macs, kecs, csir, puly, szar.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Móricka kérdezi a tanárnőtől:\n- Tanárnő, hogyan esik a hó visszafelé?\n- Sehogy, miért kérdezel ilyen hülyeségeket?\n- Mert anya azt mondta, hogy vigyek magammal kabátot mert lehet, hogy visszafelé esni fog a hó!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','A fizika tanár felelteti Mórickát:\n- Na Móricka, légyszíves mutasd be nekem az ampermérőt!\nMire Móricka:\n- Tanár úr, bemutatom az ampermérőt, ampermérő-tanár úr... Kérem ismerjék meg egymást.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Mórickát a suliról faggatja a szomszéd néni:\n- És melyik a kedvenc tárgyad az iskolában?\n- A csengő.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mit mond az egyetemista november elején?\n- ???\n- De jó! Karácsonyig már csak kettőt alszunk!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','A férj megy haza és a feleségét egy idegen férfival találja!\nA férj mérgében ráüvölt:\n- Tudtam!\nMire a feleség:\n- Ő viszont még mindig tud!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Te, már megint nem hagy minket sörözni a feleséged, miért hívogat folyton telefonon?\n- Tudod, a nő olyan mint az olimpiai érem:\nRengeteget küzdesz érte, aztán egy életen át lóg a nyakadon...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Kívánós hangulatban lévő feleség a férjéhez:\n- Ernő, súgjál valami mocskos dolgot a fülembe!\n- Konyha.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi a válások leggyakoribb oka?\n- ???\n- A házasság.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Hazaérve mondja az asszony a férjének:\n- Most jövök a szépségszalonból.\n- Zárva volt?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Két férj beszélget:\n- Sanya, én ahogy hazaérek, befekszünk az asszonnyal pajzánkodni a fürdőkádba.\n- Ne is folytasd tovább. Tudod a házasság olyan, mint egy forró fürdő:\nMinél több időt töltesz el benne, annál hűvösebb.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','A cigány defektet kap az autójával. Nekiáll kicserélni a kereket.\nMegáll mellette egy cigány haverja és egy téglával bedobja a cigány autójának ablakát.\n- Hát Te meg mit csinálsz Gazsi?\n- Míg te lelopod a kereket én elviszem a rádiósmagnót!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mit csinál a hacker a börtönben?\n- ???\n- Letölti a büntetését.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','- Hogy hívják a fején pörgő varangyot?\n- ???\n- Breaka.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','- Miért nem kaphat jogosítványt a gepárd?\n- ???\n- Mert nem áll meg a zebránál!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Egy Suzuki és egy Audi megy a sivatagban. Meglátnak egy üveg bort. Megkérdezi a Suzuki:\n- Te ott egy üveg bor. Megigyuk?\n- Neee! Az a Volkswagen Bora!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Két férfi beszélget. Kérdezi az egyik:\n- Hány éves a kocsid?\n- A Daewoo? Ma tíz.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi a hasonlóság az anyós és a hegyi ösvény között?\n- ???\n- Hogy mindegyik egy csapás!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mondja, mit főz magának az anyósa?\n- ???\n- Mindig ugyanazt: bosszút forral!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Két cigány találkozik.\n- Szia more, hogy vagy?\n- Én megvagyok, és te?\n- Én még nem vagyok meg, de már tegnap óta köröznek.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mit csinál a haldokló skinhead, ha meglát egy cigány lakodalmas menetet?\n- ???\n- Az utolsókat rúgja.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi az abszolút lehetetlen?\n- ???\n- Tenger fenekére bugyit húzni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi az abszolút rasszizmus?\n- ???\n- Amikor a kopaszbarack megveri a cigánymeggyet.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Mit csinál a rendőr a veteményes szélén?\n- ???\n- Letartóztatja a lopótököt és a gyilkos galócát.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi az abszolút lehetetlen?\n- ???\n- Zoknit húzni a hegy lábára.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','- Ki az abszolút türelmes?\n- ???\n- Aki addig simogatja a vasmacskát, ameddig az el nem kezd dorombolni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Ki az abszolút tuskó?\n- ???\n- Akinek a fejében lefullad a láncfűrész!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi az abszolút lehetetlen?\n- ???\n- Az égboltban vásárolni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Csönget a postás:\n- Fűtésszámlát hoztam Rózsika néni!\nErre az öregasszony:\nA fűt csúsztasd a zsebembe Béluskám, a számlát meg dob el a fenébe!');

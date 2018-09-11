-- Database changes for app version: 1.3

-- Fix typos in joke texts
UPDATE jokes SET jokeText='- A sivatagban él és látszólag semmi dolga nincs, mi az?\n- ???\n- Ücsörgőkígyó.' WHERE jokeText='- A sivatagban él és látszólag semm dolga nincs, mi az?\n- ???\n- Ücsörgőkígyó.';
UPDATE jokes SET jokeText='- Rendőr a másiknak:\n- Ha kitalálod hány fánkot vettem, tiéd lehet mind a kettő!' WHERE jokeText='- Rendőr a másiknak:\n- HA kitalálod hány fánkot vettem, tiéd lehet mind a kettő!';
UPDATE jokes SET jokeText='- Mit csinál az űrhajós ha megszomjazik?\n- ???\n- Űrkutat ás.' WHERE jokeText='- Mit csinál az űrjahós, ha megszomjazik?\n- ???\n- Űrkutat ás.';
UPDATE jokes SET jokeText='- Mi a közös a nőben és a gyufában?\n- ???\n- Ha benedvesedik, akkor baszhatod!' WHERE jokeText='- Mi a közös a nőben és a gyufában?\n- ???\n-  Ha benedvesedik, akkor baszhatod!';
UPDATE jokes SET jokeText='- Hogy hívják a számítógépet használó szerzetest?\n- ???\n- Felhasználó barát.' WHERE jokeText='- Hogy hívják az számítógépet használó szerzetest?\n- ???\n- Felhasználó barát.';
UPDATE jokes SET jokeText='- Jean, mi ez a dübörgés a szekrényben?\n- ???\n- Csak a ruhák mennek ki a divatból uram!' WHERE jokeText='- Jean, mi ez a dubörgés a szekrényben?\n- ???\n- Csak a ruhák mennek ki a divatból uram!';

-- Add more jokes to the collection
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért fényesíti ki a rendőr a sakkfigurát?\n- ???\n- Nehogy matt legyen.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogy hívják a lengyel kocsmárost?\n- ???\n- Mikornyicki.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- A bogarak fociznak a réten.\nA hőscincér odamegy az egyik padon ülő bogárhoz és megkérdezi:\n- Te miért nem játszol?\n- Nem látod? Én vagyok a cserebogár.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, miért füstöl a kórház kéménye?\n- ???\n- Fő az egészség, uram!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Pincér, ebben a húslevesben nincs hús!\n- Na és? A halászlében sincs halász!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, hallott arról, hogy már az állatok is lövöldöznek?\n- Nem uram, de miért kérdezi?\n- Azt írja az újság, hogy agyonlőtte a menyét.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mit csinál a szőke nő, ha egy süllyedő hajóban a nyakáig ér a víz?\n- ???\n- Fejre áll, hogy csak a bokájáig érjen.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- A szőke nő bemegy a McDonald''s-ba:\n- Kérek egy sajtburgert és egy kis sült krumplit.\n- Itt fogyasztja? - kérdi az eladó.\n- Nem, ott a hátsó asztalnál.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Miért nem beszélnek egymással a gumimacik?\n- ???\n- Haribó…');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Hogy hal meg a teniszező?\n- ???\n- Megáll benne az ütő.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Miért megy a kátrány focimeccsre?\n- ???\n- Szurkolni.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Két vívóedző összefut edzés után:\n- Mondd kolléga, te hogyan választod ki, hogy kit vizsgáztatsz?\n- Hát, szúrópróbaszerűen!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- A búvár a tengerbe való beugrás előtti percekben telefonon beszélget a feleségével, amikor hirtelen megszólal:\n- Na, most már leteszem drágám, mert mindjárt lemerülök!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Két óvodás beszélget a játszótéri mászókák alatt. A maszatosabb képű a bokrok felé mutat:\n- Nézd! Ott egy kiszisza!\n- Nahát! Te még nem tudod kimondani, hogy matka?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mért volt szegény Petőfi Sándor?\n- ???\n- Mert keveset keresett és sokat költött.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Tudod hány gyereke van a félbolondnak?\n- ???\n- Ötven, mert egy bolond százat csinál!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Megmondaná kérem, hogy merre van a legközelebbi Baumax?\n- Nálunk csak Obi van, Kenobi.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Hogy hívják a még nagyon fiatal péksüteményt?\n- ???\n- Embriós.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Két fizikai töltés beszélget:\n- Hát te meg hogy nézel ki?\n- Na, te sem vagy Coulomb!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Három tojás megy a sivatagban. Az első azt mondja:\n- Előttem a Szahara, hátam mögött pedig három tojás.\nHogy lehet ez ha csak hárman vannak?\n- ???\n- A második tükörtojás.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Lim és Lom mennek az erdőben.\nLom minden lépésnél ás egy Í-t a földbe. Mennek tovább az erdőben, Lom pedig továbbra is ás. Egyszercsak Lim találkozik az erdésszel, és megkérdezi tőle, mit csinál Lom.\nAz erdész gondolkodik egy kicsit, majd kiböki:\n- Társadalombiztosítás');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','A férj hazamegy a vadászatból és a felesége kérdi, hogy van-e valami? Mire a férj:\n- Képzeld, elejtettem egy nyulat.\n- Na és? Hol van? - kérdi a feleség.\n- Mondom hogy elejtettem!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','A híres fotóst vendégségbe hívják. A vacsora után a háziasszony beszélgetésbe elegyedik vele:\n- Gratulálok a képeihez, nagyon szépek! Biztosan jó fényképezőgépe van.\nErre a fotós:\n- Gratulálok a vacsorához, nagyon finom volt! Biztosan nagyon jó fazekai vannak!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Két egér sétálgat a hűtőszekrényben.\nMegszólal az egyik:\n- Vigyázz, mert mindjárt rád esik a margarin!\n- Rám a margarin?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','A szerszámok játszanak a szerszám kereskedésben. Megszólal az egyik:\n- Te vagy a fogó!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi az, hosszú és vérzik?\n- ???\n- Sebes vonat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Kérek egy szintetizátort.\n- Sajnos uram, a szintetizátorunk elfogyott, de ajánlhatok helyette egy tizát.\n- Tizát? Az mi?\n- Kérem, az már szinte tizátor.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért rakja a szőke nő a poros szőnyeget a hűtőszekrénybe?\n- ???\n- Hogy kirázza a hideg.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mi a hasonlóság a vasúti sínek és a szőkenők között?\n- ???\n- Az egész országban le vannak fektetve.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért nem cseréli ki a szőke nő az akvárium vizét?\n- ???\n- Mert azt várja, hogy a halak megigyák az előző adagot.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért van a szőke nőnek négyszögletes melle?\n- ???\n- Mert elfelejtette kivenni a szilikont a dobozból.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Mit csinál a szőke nő, ha látja az ajtón a HÚZNI feliratot?\n- ???\n- Elkezdni mondani, hogy hu-hú, hu-hú...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Hogyan ismerjük fel a szőke iskoláslányt?\n- ???\n- Amikor a tanár letörli a táblát, a lány kiradírozza a füzetét.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért megy a szőkenő egy konzervvel a háza tetejére?\n- ???\n- Mert az van a konzervre írva, hogy a szavatossági idő a tetőn van!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Honnan tudod, hogy egy szőke e-mailt szeretne küldeni?\n- ???\n- A CD meghajtó tele van borítékokkal.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért dobál a szőke nő a vécébe kenyérdarabkákat?\n- ???\n- Eteti a toalett kacsát.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Hol fészkel az intermadár?\n- ???\n- Interfészekben.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','Pistikét irodalomórán a tanárnéni megszólítja:\n- Pistike! A Mikszáth-ot véletlenül X-szel írtad!\n- Dehogyis Tanárnő! Az DirectX.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Válóper során kérdezi a bíró a házaspár gyerekétől:\n- Szeretnél apáddal élni?\n- Nem szeretnék mert mindig megvert.\n- Akkor, hol szeretnél lakni?\n- Szeretnék a magyar fociválogatotthoz költözni, ők sosem vernek meg senkit.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mit csinál a haldokló focista?\n- ???\n- Az utolsókat rúgja.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mi a legkedveltebb téli sport?\n- ???\n- A hosszú-távfűtés.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Hogy teáznak a skótok az esőben?\n- ???\nEgymást löködik az eresz alá és mondják:\n- Most te ázol, most teázol...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','A skót kisfiú megkérdezi az apjától:\n- Apa, mi lesz karácsonykor a fa alatt?\n- Parketta, kisfiam.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Vízirendőröknél sorozás van:\n- Jelölt! Most azonnal ússzon le kétszáz métert!\n- Na de főtörzs! Hát ez a medence nincs is olyan mély!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr megállítja a szőke nőt:\n- Jogosítványt, forgalmit, személyit kérek!\n- Mi az a személyi? - kérdezi a szőke nő.\n- Az egy olyan tárgy amiben látja a saját képét.\nKeresgél a szőke nő a retiküljében, talál egy tükröt, belenéz, aztán odaadja a rendőrnek.\n- Jaj, hát miért nem ezzel kezdte, kolléga?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr beszélget:\n- Te mivel eszed a tésztát?\n- Rádióval.\n- Hogyhogy?\n- Tudod az asszony mindig megkérdezi hogy: kérsz rá diót?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr vonatjegyet vásárol:\n- Egy retúr jegyet kérek.\n- Hová? - kérdezi a pénztáros.\n- Na mégis mit gondol? Ide vissza!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Rendőrök beszélgetnek:\n- Úgy szeretném ha anyámnak sok szárnyasállata lenne otthon!\n- Miért?\n- Hát szegény minden reggel azon sóhajtozik, hogy neki csak egyetlen barom-fia van.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Hogy hívjak a fej és végtagok nélküli rendőrt?\n- ???\n- Törzsőrmester.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Az új híd felavatása után odaállítanak egy rendőrt hogy számolja meg, hány ember megy át a hídon.\nA rendőr számolja:\n- 4 fő, 5 fő, 6 fő 7 fő, kedd, szerda...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr járőrözik. Találnak egy tükröt.\n- Te, ez a fazon nagyon ismerős nekem valahonnan!\nMegnézi a másik is és levonja a következtetést:\n- Én is ismerem, mindig velem szemben ül a fodrásznál!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr megkérdezi a kollégáját:\n- Te Sanyi, hogy lehet ezeket a böhöm nagy repülőgépeket csak úgy eltéríteni?\n- Te hülye, hát nem itt lent a földön térítik el, hanem fönt, ahol már egész kicsi.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr megy az utcán, találnak egy gumibotot, az egyik megszólal:\n- Te ez nem a Béláé?\n- Kizárt, ő tegnap elvesztette.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr igazoltat:\n- Rakják a földre a személyit, jogosítványt és a gépjármű forgalmi engedélyét!\n- De biztos úr, a föld csupa sár!\n- Csönd legyen! A törzsőrmester megparancsolta nekem, hogy vegyem fel az adataikat!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','A rendőr kint áll a szakadó esőben és a felesége által csomagolt szendvicset eszi.\nA kollegák döbbenten nézik:\n- Józsi, miért nem jösz be ide az őrszobára enni?\n- Azt mondta az asszony, akkor egyek, amikor jólesik.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Autóst büntet a rendőr:\n- Felírom gyorshajtásért!\n- Még mindig jobb, mint ha én írnám fel magát!\n- Miért, kicsoda maga?\n- A sírköves.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért vágja a rendőr felesége a küszöbön a fát?\n- ???\n- Mert a tuskó szolgálatba ment.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Két rendőr beszélget:\n- Mit eszel?\n- Szendvicset.\n- Mivel?\n- Mivel éhes vagyok.');


Politika és afölött +++
https://www.viccesviccek.hu/Politika_viccek


INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'','');


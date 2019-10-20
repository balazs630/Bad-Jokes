-- Database changes for app version: 1.4

-- Delete duplicate jokes
DELETE FROM jokes WHERE jokeId = CASE
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 162 OR jokeId = 195 AND isUsed = 0) = 2 THEN 195
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 162 OR jokeId = 195 AND isUsed = 1) = 2 THEN 195
    WHEN jokeId = 162 OR jokeId = 195 AND isUsed = 0 THEN jokeId
END;

DELETE FROM jokes WHERE jokeId = CASE
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 147 OR jokeId = 270 AND isUsed = 0) = 2 THEN 270
    WHEN (SELECT COUNT(*) FROM jokes WHERE jokeId = 147 OR jokeId = 270 AND isUsed = 1) = 2 THEN 270
    WHEN jokeId = 147 OR jokeId = 270 AND isUsed = 0 THEN jokeId
END;

-- Add more jokes to the collection
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi lesz a műfogsorból ha alámegy a pirospaprika?\n- ???\n- Csípőprotézis.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Miért nem szabad a kávéfőzőnek titkokat elárulni?\n- ???\n- Mert kikotyogja.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi lesz a túróból akit bolti lopáson kapnak?\n- ???\n- Körözött.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mi van Monica Belucci hangpostáján?\n- ???\n- A szám jelenleg foglalt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mi a baj fiacskám?\n- Jaj, az anyám beleesett a pöcegödörbe!\n- Te jó ég! - kiált fel a férfi majd elszántan a pöcegödörbe ugrik segíteni:\n- Fiam, sehol se találom az anyádat!\nA gyerek belenyúl a zsebébe, kiemel egy csavart és bedobja a gödörbe:\n- Akkor a csavar se kell!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Versenyt repül a gém meg a gólya. Egy vadász észreveszi őket, előkapja a puskáját, lő. A gém élettelenül lezuhan. A gólya utánanéz:\n- Gém over...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Régen ismeri már ezt a pszichiátert?\n- Meglehetősen régen.\n- Maga is mániás depresszióval jár hozzá?\n- Nem. Én autóbusszal...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mi az: se keze se lába, és mégis minden este borozik a kocsmában?\n- ???\n- Törzsvendég.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Mivel lehet leküzdeni a farkaséhséget?\n- ???\n- Piroskával.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mondja hölgyem, a maga férje nem beszél amikor egyedül van?\n- Nem tudom. Még nem voltunk soha együtt amikor egyedül volt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mit mond a szénégető, miután elhasal a hamuban?\n- ???\n- Hogy lehettem ilyen faszén...! ');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Móricka bemegy a pékségbe és kér egy kiflit. Olyan kemény mint a kő.\n- Mai nincs?\n- De... Holnap lesz!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Mi szeretett volna lenni Móricka kiskorában?\n- Először asztal akart lenni, de széklet. Aztán meg komp akart lenni, de nem komplett.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Móricka, menj el szépen a henteshez és hozzál tőle hurkát.\n- Hurkáááát?\n- Igen, fiacskám, jól jegyezd meg: hurkát. De ne véreset.\n- Denevéreseeet?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Milyen időben vannak ezek az igék: én fázom, te fázol, ő fázik.\nMóricka válaszol:\n- Hideg időben tanárnő...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Miért sírsz Móricka?\n- Mert a papám ráütött az ujjára kalapáccsal.\n- De hát ezért nem neked kéne sírnod!\n- Tudom, először én is röhögtem.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','- Móricka, mondjál egy szót amiben két R betű van!\n- Tojás!\n- Na de Móricka, hol vannak az R betűk?\n- Egy a fehéRjében, másik a sáRgájában!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Bocsánat uram, nem találkoztunk mi tavaly nyáron Pesten?\n- Nem, nem jártam ott tavaly.\n-Én sem. Akkor biztosan két másik ember volt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Két szú beszélget:\n- Mondja kolléga, miért nem jön át ebbe a remek bükkbe?\n- Mert a feleségem cserbenhagyott.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Bemegy a patkány az elektronikai szaküzletbe.\n- Kérek egy tévét.\n- Színeset vagy fekete-fehéret?\n- Mindegy, csak sok csatorna legyen benne!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mit énekelnek a molyok a szekrényben?\n- ???\n- Edda-blúzt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Melyik az az állat, amelyiknek több mint a fele zsír?\n- ???\n- A zsiráf.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Melyik a legsavanyúbb madár?\n- ???\n- A citromhéja!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'animal','Miért szeretne a rókalány lövészversenyre menni?\n- ???\n- Mert ott mindig meghúzzák a ravaszt.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mi villan át a légy agyán, amikor nekivágódik a szélvédőnek?\n- ???\n- A hátsója...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Miért nincs a méhecskének 45-ös lába?\n- ???\n- Mert letaposná a virágokat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Hogy hívják a jóllakott szúnyogot?\n- ???\n- Telivér.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mit tettek az ősmagyarok a nyereg alá?\n- ???\n- Lovat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Mondja Jean, szőrös a csengő?\n- Nem uram.\n- Akkor az éjjel megint a házmesternét nyomtam meg.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Itt vannak a fagyosszentek, uram.\n- Jól van Jean, akkor engedje be őket!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, vegyen elő egy ruhaakasztót a szekrényből, kirándulni megyünk.\n- És minek ahhoz ruhaakasztó, uram?\n- Hogy fogassal menjünk a Szabadság-hegyre.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mi az ott a fa tetején?\n- ???\n- A fészkes fene, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mondja mi után kutat a kamrában?\n- ???\n- Kenyérkereső vagyok, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mi ez a trappolás az udvaron?\n- ???\n- Edzenek a futórózsák, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, mik ezek a kék foltok a testén?\n- ???\n- Cseberből vederbe estem, uram.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Mivel locsoljam meg a virágokat, uram?\n- ???\n- Mivel szárazak, Jean...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Mórickáék nyaralnak a vízparton: Anyu, én meghaltam?\n- Miért kérdezel ilyen hülyeséget kisfiam?\n- Ott jön a hullám...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Jean, tegye be az ajtót!\n- Hova uram?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Hogy hívják a sivatagi anyóst?\n- ???\n- Tevén banya.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','A munkakerülő dolgozók ugratják egymást:\n- Te is olyan vagy, mint a toronyóra reggel...\n- Miért?\n- Az is elütötte már a hetet...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Ki az abszolút udvarias?\n- ???\n- Aki átadja a helyét a fáradt olajnak.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mit kiált a gyümölcsösgazda a tolvajok után?\n- ???\n- Elverlek, mint jégeső a zsenge termést!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mi az optimista ember kedvenc szövege?\n- ???\n- Holnap lesz hátralévő életed első napja!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Mit mond Gazsi ha lát egy szép nőt az utcán?\n- ???\n- Dugnám, mint a lopott biciklit!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','Mi a plátói szerelem?\n- ???\n- Kívülről nyalogatni a lekváros üveget.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mit mond a lenyűgözött ember?\n- ???\n- Elkápráztattál, mint vak macskát az autóreflektor.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','Mit kiáltanak a szőke nő után a forgalomban?\n- ???\n- Te is inkább áramot vezessél, ne autót!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Mit mond az idős néni miután lefejelte a villanyoszlopot?\n- ???\n- Meg vagyok zavarodva, mint vasorrú bába a mágneses viharban.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Doktor úr, kérem vizsgálja meg a feleségem, mert nagyon gyerekes a viselkedése.\n- Miben nyilvánul ez meg?\n- Abban hogy valahányszor fürdök, bejön a fürdőszobába és sorra elsüllyeszti a papírhajóimat.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Hogy hívják a cigányt öltönyben és nyakkendőben?\n- ???\n- Vádlott, álljon fel...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Elfogja a rendőr a cigányt.\n- Te Gazsi, hol loptad ezt a lovat?\n- Nem loptam én, nyertem sakkban!\n- De hiszen te nem is tudsz sakkozni!\n- Már miért ne tudnék? Leütöttem a parasztot, és léptem a lóval.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Te, Gazsi! Hun születtél?\n- Hát, a kórházban.\n- Mér, beteg vótá...?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Két cigány gyalogol az úton. Egy kereszteződéshez érve meglátnak egy feszületet. Egyikük odafordul:\n- Dícsértessék!\nA társa megkérdezi:\n- Mi az tesó, ismered?\n-Há''mán hogyne! Hiszen ő adja mindennapi kenyerünket.\nMire a másik:\n- Mé, pék a csávó?');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Két zenész beszélget:\n- Képzeld, múlt héten betörtek hozzám. Elvitték a tévét, videót, a hegedűmet...\n- És mekkora a károd?\n- Hát olyan tizenhét centi...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Gazsi és az asszony letelepednek a folyóparton, s napozás közben Gazsi elalszik. Arra ébred, hogy az asszony rázza a vállát:\n- Te Gazsi, gyerünk a hűvösre!\nMire Gazsi félálomban:\n- De hát én nem csináltam most semmit!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Mit szólsz, hogy ez a szegény Gazsi megvakult?\n- Ne mond már, hiszen este még látott a kocsmában.\n- Igen, de ott letarháltam egy ezressel, és azt már sose látja.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Te, Laji, igazs hogy megkefélted a feleségemet?\n- Meg hát!\n-Ost milyen jogon?\n- Hát vájjogon...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Strandol a roma család a Balatonnál. Egyszer csak feltámad a szél, erre felkiált Gazsi az asszonynak:\n- Gyere, lovagolj mán a hullámon!\n- Bolond vagy te, Gazsi! Hiszen még élve se kívánlak...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Miért nem temetik a törzsfőnököt a folyópartra?\n- ???\n- Mert még él.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'jean','- Miért nem eszik meg Jean-t a kannibálok?\n- ???\n- Mert nagyon inas.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Miért öltöztetik fehér ruhába a menyasszonyt?\n- ???\n- Mert minden háztartási gép fehér...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Hazamegy Gazsi és így szól az asszonyhoz:\n- Hállod e te ásszony! Há'' lement a bútor ára!\n- Asztán hol?- Hát itt á torkomon!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'geek','- Mit mond a háziorvos, miután a sérült fájlt megvizsgálta a számítógépén?\n- ???\n- Átnéztem két megabájtot, mégsem láttam meg a bajt ott.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért nyalja a rendőr az óráját?\n- ???\n- Mert azt hallotta, hogy a Tic Tac frissíti a lehelletét.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért tartóztatja le a rendőr a kengurut?\n- ???\n- Mert zsebes.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért veri szét a rendőr a kutyája házát?\n- ???\n- Mert fél az ebolától.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','- Miért rakja a rendőr a kályhát a szoba közepére?\n- ???\n- Azért, hogy központi fűtése legyen.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'cop','Rendőr fia a papának:\n- Apu, annyira fázom!\n- Állj be a sarokba kisfiam. Ott 90 fok van.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','Két szőke nő áll a patak két partján:\n- Segítesz átjutni a túlpartra?\n- Dehiszen ott állsz!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'moricka','Mórickának egy mondatot kell mondania a delfin szóval az iskolában:\n- Na Móricka, halljam? - bíztatja a tanárnő.\n- Majd elfingom magam!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Hogyan fejezed ki a nő szélességét angolszász mértékrendszerben?\n- ???\n- 2 láb, 1 hüvely(k)!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','- Miért mennek a szőke nők szívesen Indiába?\n- ???\n- Mert ott fekszik a Himalája.');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Két idős úr beszélget:\n- Tudod komám, mindig megizzadok két szeretkezés között.\n- Hogyhogy a te korodban??\n- Tudod közte nyár van!');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Anyuka hazaér a munkából, beszól a kisszobába:\n- Ottóka, etté?''\nMire a kisfiú:\n- Nem, Ottóka két t');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'anti','- Milyen az okos szőlő?\n- ???\n- Agyafürt...');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','- Pincér, én halászlevet rendeltem, de ebből a löttyből amit kihozott nekem, az előbb kihalásztam egy cipőfűzőt!\n- Ez csak természetes, uram! A csuka még benne is van');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','- Miért alszanak a csövesek a Cora hipermarket tetején?\n- ???\n- Mert aki Corán kel, aranyat lel');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'rough','Az autóversenyzőt halálos baleset éri. Az özvegyet behívják a hullaházba, hogy azonosítsa a testet.\nA boncmester kihúzza az első fiókot:\n üres, másodikat: üres, harmadikat: üres\nEkkor megszólal az özvegy:\n- Igen, ő az, megismerem. Sose volt benne az első háromban');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'tiring','Mi van az őrült ló lábán?\n- ???\n- Pszicho-pata');
INSERT INTO jokes (isUsed, deliveryTime, type, jokeText) VALUES (0,null,'blonde','A szőke nő kap a férjétől egy automata mosógépet. Másnap arra megy haza a férj hogy a felesége meztelenül rakja be a ruhákat a gépbe.\nMire a férj:\n- Mit csinálsz szivem?\n- Jaj drágám, a használati utasítás azt írta, hogy az első mosást ruha nélkül kell csinálni!');

-- EOF

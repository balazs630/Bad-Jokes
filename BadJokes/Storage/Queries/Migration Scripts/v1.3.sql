-- Database changes for app version: 1.3

-- Fix typos in joke texts
UPDATE jokes SET jokeText='- A sivatagban él és látszólag semmi dolga nincs, mi az?\n- ???\n- Ücsörgőkígyó.' WHERE jokeId='21';
UPDATE jokes SET jokeText='- Rendőr a másiknak:\n- Ha kitalálod hány fánkot vettem, tiéd lehet mind a kettő!' WHERE jokeId='153';
UPDATE jokes SET jokeText='- Mit csinál az űrhajós ha megszomjazik?\n- ???\n- Űrkutat ás.' WHERE jokeId='104';
UPDATE jokes SET jokeText='- Mi a közös a nőben és a gyufában?\n- ???\n- Ha benedvesedik, akkor baszhatod!' WHERE jokeId='45';
UPDATE jokes SET jokeText='- Hogy hívják a számítógépet használó szerzetest?\n- ???\n- Felhasználó barát.' WHERE jokeId='157';

-- Add more jokes to the collection

tms02_test isti kao tms01 sa prekopiranim kodom za tms da mozemo istestirat sutra 

marin: Evo jedan link s www.neurobs.com
- http://www.neurobs.com/menu_support/menu_forums/view_thread?id=5188
Uglavnom koliko sam skužija imaju isti problem, da im TMS ne reagira. Jedina razlika
je ta da TMS reagira kada koriste PORT TEST WINDOW.

jure: dodan tms03 - pocetna implementacija pauze i nastavka. iz nekog razloga javlja mi se error "not enough output ports are selected for this scenario"
ali kad se postavi obican lpt1 port, radi pauza i nastavak
ako vam javlja active_buttons eror, kod All Files sekcije u Editoru kliknit na tms03.sce

jure: dodan tms04_port
preko programa http://www.eltima.com/products/vspdxp/  isprobao 2 serijska porta istovremeno, bitno ih je u 
kodu diferencirati pomocu atributa port: u sdl-u, mislim da radi kako treba
(vidi port_bitno.txt, port_kod.PNG, port_settings.PNG). btw koristio sam postavke koje smo slikali za oba porta

marin: dodani nizovi delayeva na dva naèina
1. naèin - samo dodano 5 nizova delayeva kako je ona napravila u onom ppt-u (kada se želi iskoristiti neki niz samo se odkomentira)
2. naèin - rogiæka može samo mijenjati broj izmjena tj. broj razlièitih delayeva tako što mijenja velièinu niza delays (vrijednosti delayeva se onda
generiraju na random naèin od onih 6 vrijednost: 20, 50, 100, 150, 200, 250)
vi provjerite ako sam sve dobro razumio
nisam jedino siguran da je ispravno ovo trial_tms.delay

jure: dodan tms06.exp i tms06.sce
-rjesen delay izmedju trial_tms i trial_stim
-popravljeno (meni bar) pauziranje i nastavljanje, iako sam ostavia staru liniju u kodu
-dodan code"" segment u SDL blokovima koji omogucavaju u analizi nakon experimenta da vidimo vremena odvijanja pojedinih trigera
-uocen bug: ako pauziram (B) i stisnem krivu tipku za nastavak, ne mogu nastaviti sa N

marin:
-ispravljeni delayevi
-rješenje je u obliku 2D niza gdje je 1. vrijednost delay, 2. vrijednost TMS(0/1) i 3. vrijednost STIMULATOR(0/1) 
-napravio sam u txt fileu blokovi.txt svih 5 blokova tako da se samo jedan po jedan kopiraju u scenarij (da ne "zagušuju" skriptu bezveze)

davor:

-dodani kodovi (njih 5) za svaki blok posebno

-> NOTE: treba izmijenit za svaki još dio koda da nam je ujednaèeno pitanje i snimanje s mikrofonom!
Babane, ako si ti sejva onaj najnoviji kod na USB koji smo u èetvrtak radili, šibni ga na Dropbox pa izmijenimo
po uzoru na njega svaki od ovih 5 kodova
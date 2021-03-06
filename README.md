# Vecka 18

## Måndag 27 apr

Fick en grundläggande överblick över hårdvaran som Sensorbee utvecklar och vad för uppgifter jag förväntas lösa. David vill ha en GUI som ger en överblick över systemet Sensorbee har utvecklar för att enhetstesta deras sensorer. Blev introducerad till [I2C](https://en.wikipedia.org/wiki/I%C2%B2C)-protokollet, som används som gränssnitt mellan PC och kretskortet, samt [Docklight](https://docklight.de/), ett scriptingprogram för seriell kommunikation med inbyggda system. Spenderade dagen med att experimentera mha ett breadboard och I2C-baserade master-/slavmoduler. Slavmodulerna adresseras med 3 bits (0 till 7) och håller en byte av data, vilket är tänkt ska skickas vidare till kretskortet för att styra dess beteende. Började utveckla C#-kod för att kommunicera med hårdvaran via USB mha Docklights DLL.

## Tisdag 28 apr

Sprang på problem med Docklight-DLL:en, så jag ersatte den (temporärt?) med `System.IO.Ports` för att skriva och läsa bytes direkt till mastermodulen. Skrev ett C#-bibliotek som abstraherar läs- och skrivprocessen och låter mig skriva t.ex.

```
Slave s = new Slave(0); // slavmodul med adress 0
s.Write(0xff);
```

för att adressera en slavmodul och skriva en byte till den. Skrev också ett minispråk med en interaktiv tolkare för att kunna testa biblioteket dynamiskt, t.ex.

```
> write 0 255
> toggle 0 4   # flippa 4:e biten
> read 0
239
```

David har varit väldigt välkomnande och han ger mig mycket rum att experimentera på egen hand och bidra med egna idéer.

## Onsdag 29 apr

Lade till `LogicalUnit`-klassen som abstraherar bort enskilda slavmoduler och låter mig adressera en serie av bits som en enhet. T.ex. kan jag hantera de sista 4 bits av en slavmodul och de 4 första av en annan som om de vore ett självständigt sammanhängande enhet.

Faktorerade om koden för att dela bibliotekskod från front-end (ovannämnda tolkaren samt eventuell GUI). Började experimentera med WPF för att skriva en GUI.

## Torsdag 30 apr

Fortsatte utveckla GUI:n. Lärde mig om [Hayes-kommandon](https://en.wikipedia.org/wiki/Hayes_command_set) som kommer användas för att programmera och hämta information från sensorerna via en separat port, och började lägga till den funktionaliteten till kodbasen. Hårdvaran för kretskortet ankommer nästa vecka så mina möjligheter att testa min kod har varit begränsade den här veckan, men jag är nöjd med hur det har gått hittills och David är nöjd med min insats.

Det har varit en lärorik vecka och jag har fått testa många saker jag är relativt oerfaren i: digitalteknik, skriva till/läsa från fysiska portar, designa och implementera en GUI, och framför allt designa ett komplext program utifrån ett kravspecifikation. En stor utmaning har varit att hantera logistiken av olika .NET-versioner, DLL-importer och kompatibilitet, ladda ner bibliotek med pakethanterare, osv, vilket jag inte har mycket erfarenhet av från de relativt små uppgifter vi får i skolan.

# Vecka 19

## Måndag 4 maj

Fortsatte förfina och debugga GUI:n jag började arbeta med förra veckan. Jag studerade också databladet för en I2C-baserad analog-digitalomvandlare ([ADS1015](https://www.adafruit.com/product/1083)) som mitt program ska styra.

## Onsdag 6 maj

Hemma igår pga sjukdom. Experimenterade med ovannämnda ADC:n mha kretskortet jag har byggt under praktiken och implementerade den i mitt C#-program, vilket tog större delen av dagen. Programmet kan nu räkna ut voltskillnader mellan två pins, vilket (enligt David) kommer vara användbart i testkortet. Jag ser fram emot att få testa mitt program på riktiga hårdvaran.

![Kretskort](img/kretskort-0506.jpg)

## Torsdag 7 maj

Jag spenderade dagen med att finslipa GUI:n i väntan på att hårdvaran skulle byggas färdigt. På eftermiddagen hjälpte jag till med att löda några kretskort, vilket var en underhållande distraktion. Imorgon är kortet förhoppningsvis färdigt och jag kan börja nästa fas av utveckling.

![Program](img/program_v19.png)

## Fredag 8 maj

Idag fick jag spendera hela dagen med att löda systemets huvudkort. Efter att jag upptäckte en bugg på eftermiddagen i den behövde jag försiktigt fräsa och patcha den. Trots att det inte blev någon programmering idag är jag rätt nöjd med att jag fick öva lödning. Jag har lärt mig rätt mycket om digitalteknik de här två veckorna. Det blir hjälpsamt om jag någonsin jobbar med inbyggda system igen i min framtida karriär.

# Vecka 20

## Mån 11

Jag spenderade lite tid på helgen med att skriva om delar av mitt program i [Go](https://golang.org/), ett C-liknande språk jag har nyligen upptäckt och blivit förtjust i. Jag gjorde det dels som en ursäkt för att öva Go, men jag känner också att koden som jag har skrivit har blivit för stor och rörigt. Stora delar av det härstammar från mina första 2-3 dagar då jag experimenterade med mitt breadboard och endast till hälften riktigt förstod mitt programs syfte. Att skriva om programmet i Go har hjälpt mig förenkla min egna mentala modell av koden och implementera den mer koncist.

Så idag började jag skriva om C#-versionen för att efterlikna Go-versionen. Översättningen var lite mer bökigt än vad jag hoppades på pga objektorienterade strukturen av C#; Go är mycket simplare och C-likt. Imorgon vill jag fortsätta refaktorera C#-versionen och utforska möjligheten att göra en GUI-frontend för Go-versionen. Eventuellt kan Go-versionen ersätta C#-versionen, om David går med på det.

Jag fortsatte också löda huvudkortet idag och kom tillräckligt långt för att koppla den till min dator och göra enkla tester mha [Termite](https://www.compuphase.com/software_termite.htm).

## Tis 12, ons 13

Spenderat senaste dagarna med att debugga hårdvaran och faktorera om koden för att passa den bättre. Vi (jag) har upptäckt ett par buggar som kommer kräva fler fysiska patcher, men i det stora så fungerar det bra. Jag har helt bytt till Go vilket David är ok med för tillfället. Go saknar GUI-bibliotek i nivå med WPF + XAML, men jag har funnit att dess concurrency-förmågor passar GUI-utveckling mycket väl.

![Kretskort](img/kretskort-0513.jpg)

## Tors 14, fre 15

Fortsatte debugga programmet och kretskortet.

# Vecka 21

## Måndag 18

Vi har upptäckt en del problem med kretskortet de senaste dagarna och håller på att långsamt debugga dem. Det svåra är att jag har svårt att veta hur mycket beror på min kod och hur mycket på interna problem i kortet. Jag lär mig mer och mer om elektronik vilket glädjer mig; de flesta programmeringsjobb håller inte på med det direkt men förmodligen kommer jag ha nytta av det i framtiden.

## Tisdag 19

Jag upptäckte äntligen källan till stora buggen som har plågat mig (en pin på kortet var inte ordentligt jordad...). Tack vare det kunde jag testa programmet mer ingående; jag gjorde några förändringar i GUI-koden för att göra den mer intuitiv.

## Onsdag 20, fredag 22

Vi lyckades äntligen sätta upp en ordentlig testrigg som andra anställda kan använda för att testa programmet. Jag har kommit tillräckligt långt att David kunde testköra programmet i några minuter och ge mig feedback på hur GUI:n kan göras mer intuitiv och några features han önskar.

# Vecka 22

## Måndag 25, tisdag 26

Fortsatte förfina GUI:n efter Davids feedback och löste några buggar för att göra programmer mer robust när t.ex. hårdvaran fallerar.

En anställd testkörde mitt program via remote på testriggen och vi inväntar hans tankar och buggrapporter.

## Onsdag 27

Jag har börjat nå en tillräckligt stabil punkt där jag kan relativt enkelt lägga till nya features och göra justeringar till nuvarande funktionalitet. Idag jobbade jag med många små fixar och förändringar som Michael (som testkörde mitt program) och David bad om. Jag är också otroligt glad att jag bytte till att programmera i Go. Trots att GUI-biblioteket är primitivt är det väldigt friktionslöst att programmera t.ex. asyncfunktioner som GUI-kod litar mycket på.

## Torsdag 28

Mer GUI-kod

## Fredag 29

Idag fick jag kolla på C-koden som flashas på sensorerna. Det är väldigt komplicerad kod som har utvecklats av en anställd som har jobbat med det i flera år. Den är byggd på FreeRTOS (ett helt operativsystem utvecklat för inbyggda system). Jag kände ändå att jag förstod den lilla delen av koden som jag utforskade. Mot slutet av dagen lyckades jag kompilera hela kodbasen och flasha en sensor.

# Vecka 23

## Måndag 1, tisdag 2

Lödde ihop en till teststation.

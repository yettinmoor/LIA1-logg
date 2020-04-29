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

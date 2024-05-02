# Roblox to Discord integration module.
This module uses OOP to facilitate the use of Webhooks to send messages to discord trough Roblox. 

## How to use it?

### Seting up

Require the module using it's path in the explorer, then create a new _webhook_ object as shown

```lua

local WebhookService = require("Module's path").WebhookService
local webhook1 = WebhookService.new("Webhook's name","Webhook's url")

```

### Posting simple messages

To post use the _:Post_ method in the webhook objet as shown


```lua
webhook1:Post("Hello World!") -- Posts "Hello World", no formating.

```

## Creating an embed

To create an embed, first require _Embeds_ from the main file, then create a class as shown

```lua
local Embeds = require("Module's path").Embeds

local NewEmbed = Embeds.new(
    "This is the title",
	"This is a description",
	Embeds.Colors.Navy -- Choose from any color in the module, or provide a hex value to any color.
    "This is the content"
)

```

### Adding fields

To add fields, use the _AddField_ method in the Embed class, arguemnts are: (String) Field's name, (String) Field's value, (boolean) InLine

```lua

NewEmbed:AddField("Field 1","Value 1",true) -- Add fields to the embed
NewEmbed:AddField("Field 2", "Value 2", true) -- The first 

webhook1:Post(NewEmbed)

```

### Error handler

The module includes an built-in error handler, but you can change that function to handle it the way you wish.

```lua
function MyErrorHandler(webhook_object, error_message)
    print(webhook_object.." Failed to post, \n [error]: "..error_message)
end

WebhookService.OnPostError = MyErrorHandler

```

```c
//*****************DIRETIVAS DO PRÉ-PROCESSADOR*************
//includes (arquivos de inclusão) e define (definições)
#include <WiFi.h>
#define LED_BUILTIN 2   // Led Interno do Esp32 (LED_BUILTIN) 


//*****************DECLARAÇÕES GLOBAIS**********************
//declaração de variáveis e funções (subrotinas)

const char *ssid = "moto g9 play";
const char *password = "tbsnzv09826";

//**********************SETUP*******************************
//define condições de trabalhos dos pinos (input/output), velocidade de comunicação e outras funções
void setup()
{
  Serial.begin(115200);
  delay(20);
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN,LOW);// inicializando como desligado o led Interno
  
  Serial.println();
  Serial.println();
  Serial.print("Conectando ao roteador ...:");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }

  // Conexão com sucesso
  conexaoFeita();
  
}
//*********************PROGRAMA PRINCIPAL******************
void loop()
{
  if (WiFi.status() != WL_CONNECTED){
    digitalWrite(LED_BUILTIN,LOW);   
    WiFi.begin(ssid, password);
    
    while (WiFi.status() != WL_CONNECTED){
        digitalWrite(LED_BUILTIN,LOW);   
        delay(500);
        digitalWrite(LED_BUILTIN,HIGH);   
    }
    
  } else {
    
    // Conexão com sucesso
    
    conexaoFeita();
  }
}

void conexaoFeita(){
  digitalWrite(LED_BUILTIN,HIGH);
  /*
  Serial.println(" ");
  Serial.println("Rede Wifi Conectada");
  Serial.print("IP de acesso: ");
  Serial.println(WiFi.localIP());
  */
 }

//**********************DEFINIÇÕES DAS FUNÇÕES************
//subrotinas da programação
```

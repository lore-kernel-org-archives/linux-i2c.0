From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 3/3] dt-bindings: i2c: eeprom: document "mac-offset"
 binding
Date: Wed, 19 Jul 2017 12:08:39 +0300
Message-ID: <96d6eeed-9272-1460-8c5d-64f06918b09a@microchip.com>
References: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
 <1499336217-16913-4-git-send-email-claudiu.beznea@microchip.com>
 <20170710034613.fc4vj6h22kagce24@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710034613.fc4vj6h22kagce24@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, nsekhar@ti.com, david@lechnology.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
List-Id: linux-i2c@vger.kernel.org



On 10.07.2017 06:46, Rob Herring wrote:
> On Thu, Jul 06, 2017 at 01:16:57PM +0300, Claudiu Beznea wrote:
>> Document "mac-offset" binding that will be used by at24 EEPROM driver.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> index a50dc01..3dd267c 100644
>> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> @@ -35,10 +35,13 @@ Optional properties:
>>  
>>    - read-only: this parameterless property disables writes to the eeprom
>>  
>> +  - mac-offset: offset in EEPROM where MAC address starts
>> +
> 
> This doesn't scale if you have multiple things you need the offset to, 
> and we already have a binding for this. Use the nvmem binding.
Are you talking about nvmem-cells, nvmem-cell-names bindings? Since
at24 is i2c driver, I can only think at it as a nvmem provider. Using these
bindings it will imply, as per my understanding about nvmem subsystem, that
this should also become a nvmem consumer. It looks a little strange to
me but I don't have deep knowledge about subsystem, correct me if I'm wrong.
Please let me know if you are talking about using these bindings and reading
them (just to get the offset passed in "reg" binding) by not passing the nvmem
APIs defined in nvmem core.

Thank you,
Claudiu
> 
> Rob
> 

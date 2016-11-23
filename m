From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v3 3/5] i2c: designware: Add slave definitions
Date: Wed, 23 Nov 2016 14:36:28 +0000
Message-ID: <0e79e7db-acda-d6df-8c00-47b31ae9b7bd@synopsys.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
 <f1bf9ca52e47cdd79b8f0d5e0c159a8727857269.1479410047.git.lolivei@synopsys.com>
 <1479472552.22212.23.camel@linux.intel.com>
 <20161118170155.chrdpguohgl6vo5f@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161118170155.chrdpguohgl6vo5f@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

OK, I will create a "mode" string property in the devicetree that can be
"master" or "slave".


Thank you all,

Luis

On 18-Nov-16 17:01, Rob Herring wrote:
> On Fri, Nov 18, 2016 at 02:35:52PM +0200, Andy Shevchenko wrote:
>> On Fri, 2016-11-18 at 11:19 +0000, Luis Oliveira wrote:
>>>  - Add slave defintitions to i2c-designware-core
>>>  - Changes in Kconfig to auto-enable I2C_SLAVE when compiling the
>>> modules
>>>  - Add compatible string to designware-core.txt explaining the
>>> devicetree bindings
>>>
>>
>>> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>>> @@ -2,7 +2,9 @@
>>>  
>>>  Required properties :
>>>  
>>> - - compatible : should be "snps,designware-i2c"
>>> + - compatible : should be:
>>> +   - "snps,designware-i2c" to setup the hardware block as I2C master.
>>> +   - "snps,designware-i2c-slave" to setup the hardware block as I2C
>>> slave.
>> Not sure about this one.
>>
>> Compatible string is more generic than list of modes. Basically you have
>> to add a property which selects mode.
> Yes, agreed. And come up with a common property.
>
>> DT people's ACK is a must for this change.
>>
>>
>> --- a/drivers/i2c/busses/Kconfig
>>> +++ b/drivers/i2c/busses/Kconfig
>>> @@ -470,6 +470,7 @@ config I2C_DESIGNWARE_CORE
>>>  config I2C_DESIGNWARE_PLATFORM
>>>  	tristate "Synopsys DesignWare Platform"
>>>  	select I2C_DESIGNWARE_CORE
>>> +	select I2C_SLAVE
>>>
>> Common rule, generic dependencies usually go first
>>
>> 	select I2C_SLAVE
>>  	select I2C_DESIGNWARE_CORE
>>
>> -- 
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Intel Finland Oy

-- 
Best regards,
Luis

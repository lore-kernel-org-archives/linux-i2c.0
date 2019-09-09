From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [RFC,v2 2/6] i2c: add I2C Address Translator (ATR) support
Date: Mon, 9 Sep 2019 18:48:56 +0100
Message-ID: <152384b8-c0a8-e6fe-9a1f-52caf00533de@lucaceresoli.net>
References: <20190723203723.11730-1-luca@lucaceresoli.net>
 <20190723203723.11730-3-luca@lucaceresoli.net>
 <20190901143101.humomdehy5ee73sk@vino>
 <aedad45b-16d6-d189-b045-329727440ca5@mleia.com> <20190909072232.GA990@kunai>
 <8af9a049-06b9-dbe8-827b-5134d20e9435@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8af9a049-06b9-dbe8-827b-5134d20e9435@mleia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Wolfram Sang <wsa@the-dreams.de>, jacopo mondi <jacopo@jmondi.org>, Peter Rosin <peda@axentia.se>
Cc: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>
List-Id: linux-i2c@vger.kernel.org

Hi Vladimir,

On 09/09/19 16:10, Vladimir Zapolskiy wrote:
> Hi Wolfram,
> 
> On 09/09/2019 10:22 AM, Wolfram Sang wrote:
>> Hi Vladimir,
>>
>>> I won't attend the LPC, however I would appreciate if you book some
>>
>> A pity. I would have liked to have you in the room. Let's see if we can
>> get enough input from you via mail here.
>>
> 
> if it might help, I'll attend the Embedded Recipes and ELCE conferences
> this year.
> 
>>> time to review my original / alternative implementation of the TI
>>> DS90Ux9xx I2C bridge device driver.
>>
>> We have only 45 minutes, this will not allow to review specific
>> implementations. I want to give an overview of existing implementations
>> with pros/cons...
>>
> 
> Sure! Any shared summary/opinions are greatly welcome.
> 
>>> The reasons why my driver is better/more flexible/more functional are
>>> discussed earlier, please let me know, if you expect anything else
>>> from me to add, also I would be happy to get a summary of your offline
>>> discussion.
>>
>> ... and I'd appreciate support here from you, like your summary of the
>> back then discussion (from where I can dive deeper if needed).
>>
>> Also, with Luca's new series we discussed some scenarios which can
>> happen WRT to I2C address conflicts. Maybe you could comment on them,
>> too?
> 
> I do remember I've commented on the Luca's suggestion of using dynamic
> I2C addresses from a pool (the introduced "i2c-alias-pool" property).
> 
> I have to scrutinize it in Luca's v2, but then it might happen that the
> userspace won't know to which IC on the remote side it communicates to.

I think you suspect this because the assigned alias is
non-deterministic, so you might end up in writing to the wrong alias.
Well, this is not possible because the user is not supposed to know the
alias at all. Let's say you have two identical eeproms on remote port 0,
with physical addresses 0x50 and 0x51. Then, with my RFCv2 code, you'll
access them with physical numbers, not the alias:

# i2cdetect -l
i2c-0	i2c   	amba:camera-i2c@0      I2C adapter
i2c-4	i2c   	i2c-0-atr-0            I2C adapter
i2c-5	i2c   	i2c-0-atr-1            I2C adapter
# hexdump /sys/bus/i2c/devices/4-0050/eeprom
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000100
# hexdump /sys/bus/i2c/devices/4-0051/eeprom
0000000 0001 0203 0405 0607 0809 0a0b 0c0d 0e0f
*
0000100
#

Here i2c-0 is the "local" bus, i2c-4 and i2c-5 are the remote busses on
ports 0 and 1. As you can see the eeproms are accessed using a name like
"4-0050", meaning physical slave address 0x50 on bus 4. No alias is needed.

Should you want to know the alias, perhaps for debugging (it's the
address you'll see on your logic analyzer), they are shown in the kernel
log.

Does this reply to your concern?

>> As I read the old thread, you have a hardcoded aliases using
>> "ti,i2c-bridge-maps". This means you can't have own DTSI files for e.g.
>> add-on modules, do I get this correctly?
>>
> 
> Basically hardcoding of aliases completely resolves the highlighted
> above problem. Still it is possible to have own DTSI files for the FPD
> link detachable PCBs, and this is an exceptionally important scenario,
> however some limitations shall be applied:
> * dt overlays for "local" derializer/deserializer ICs, it's a generic
>   and universal solution, it is successfully used in the field,
> * only "compatible" PCBs are supposed to be connected (same set of I2C
>   devices/addresses on every such PCB), this is imperfect for sure,
> * "ti,i2c-bridge-maps" list is excessive to cover "almost compatible"
>   (in the sense from above) PCBs, some of the missed alias matches
>   just won't instantiate a driver, this is of course also imperfect.
> 
> In general nothing critical should happen, if some I2C device on the
> remote side is simply not probed in runtime, in opposite you can imagine
> that writing for instance to another EEPROM of two on the remote side
> could be harmful.
> 
> Any technically better solution to the two given approaches (from Luca
> and from me) is more than appreciated. For non-dynamic/fixed local and
> remote PCBs the fixed mapping is better, the dynamic case is covered
> by the dt overlays, why not?
> 
> As a side note please do remember that the I2C bridging on Maxim GMSL
> and TI DS90Ux9xx are different, the former one is a real mux, and the
> latter one is not, I'm uncertain if it's reasonable to think of a
> generalized solution which covers both IC series, so likely we
> have to review the developed solutions for them separately instead
> of trying to work out a combined one.
> 
> --
> Best wishes,
> Vladimir
> 


-- 
Luca

From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Fri, 22 Dec 2017 00:07:55 +0100
Message-ID: <a0cbee79-29dd-686c-5069-d95e1710bfc1@axentia.se>
References: <20171221134842.31287-1-brgl@bgdev.pl>
 <20171221134842.31287-2-brgl@bgdev.pl>
 <0c2455ae-2f68-5342-14c6-14706d6f0e66@axentia.se>
 <CABxcv=kZk+Yrt9uj9uV7UVC+Tca7NCECfyZXmKkqHdopm5EZTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr40099.outbound.protection.outlook.com ([40.107.4.99]:37728
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbdLUXIC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 21 Dec 2017 18:08:02 -0500
In-Reply-To: <CABxcv=kZk+Yrt9uj9uV7UVC+Tca7NCECfyZXmKkqHdopm5EZTg@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On 2017-12-21 21:27, Javier Martinez Canillas wrote:
> Hello Peter,
> 
> On Thu, Dec 21, 2017 at 5:20 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2017-12-21 14:48, Bartosz Golaszewski wrote:
>>> Current description of the compatible property for at24 is quite vague.
>>>
>>> Specify an exact list of accepted compatibles and document the - now
>>> deprecated - strings which were previously used in device tree files.
>>
>> Why is it suddenly deprecated to correctly specify what hardware you
>> have, e.g. "nxp,24c32". In this case the manufacturer is nxp, damnit.
> 
> Sorry but I disagree.
> 
> When you specify a compatible string, you are not specifying a
> particular hardware but a device programming model.

That's not what it says in https://elinux.org/Device_Tree_Usage
in the "Understanding the compatible Property" section. I quote:

	compatible is a list of strings. The first string in the
	list specifies the exact device that the node represents
	in the form "<manufacturer>,<model>". The following strings
	represent other devices that the device is compatible with.

Pretty clearly talks about devices and not programming models. But
maybe I shouldn't trust that reference? What should I be reading
instead?

> It's very common to use a compatible string that doesn't match exactly
> the specific hardware used. That's why it's called _compatible_ BTW.

That's not how I read the above.

> For example when a DTS define a UART node with an ns16550 compatible,
> they don't really mean that have a UART IC manufactured by National
> Semiconductor.

That just tells me that most people are a little bit lazy and ready
to cut a corner or two when they can get away with it. Or that there
is some form of misunderstanding at work...

>> Sure, it happens to be compatible with "atmel,24c32", but that is
>> supposed to be written with a fallback as
>>
>>         "nxp,24c32", "atmel,24c32"
> 
> This isn't a requirement really, systems integrators are free to use
> more than one <manufacturer,model> tuple in the compatible string if
> they want the DTB to be future proof, just in case there's a need for
> a more specific driver or if the programming model happened to not be
> the same at the end. This is usually done for the boards compatible
> string as an example, even when there isn't a struct machine_desc for
> the specific board compatible and only for the SoC family.
> 
> So it's OK if you want to define the compatible as "nxp,24c32",
> "atmel,24c32", but that's a general OF concept and not something
> related to the at24 eeprom driver so I'm not sure if it should be
> mentioned in the at24 DT binding doc.

One problem is that if "nxp,24c32" (or "nxp,24c02" as in the example
below) is not a valid compatible, the tooling will be correct to
complain about it. Currently, it is just a checkpatch deficiency that
it complains like this:

$ scripts/checkpatch.pl -f arch/arm/boot/dts/at91-tse850-3.dts
WARNING: DT compatible string "nxp,24c02" appears un-documented -- check ./Documentation/devicetree/bindings/
#249: FILE: arch/arm/boot/dts/at91-tse850-3.dts:249:
+               compatible = "nxp,24c02", "atmel,24c02";

>> if I understand correctly. So, why is that deprecated in this case?
>>
>> What if (a few years down the line) it is discovered that some weird
>> quirk is needed that is only appropriate for nxp chips?
>>
>> nxp is of course just an example, pick any manufacturer of eeproms
>> (supposedly) compatible with the atmel interface.
>>
> 
> That's indeed a possibility and the reason why most DT nodes have a
> more specific <manufacturer,model> before the generic one matched by
> drivers. I really doubt that in the future it will be found that a
> more specific compatible string is needed for one manufacturer in this
> case, specially since the driver didn't even care about the
> manufacturers until recently.

I'm not talking about the driver. But if what you say is true, that
change would have broken a number of existing DTBs. Is that really the
case?

> So I think that makes no sense for a driver to support all possible
> manufacturers as possible compatible strings if all the devices have
> the same exact programming model.

That's what the fallback is for. With that in place the driver can
start to care when there is a need but until then it can work just
as it always has. Without knowing the specific device, the driver has
less chance to adapt when the unexpected is discovered. But again,
I'm not really discussing driver details, I'm complaining about the
proposed changes to the bindings. I simply don't see how they make
sense.

Cheers,
Peter

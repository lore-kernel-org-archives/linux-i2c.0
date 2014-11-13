From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Thu, 13 Nov 2014 14:53:07 -0300
Message-ID: <5464F003.7080809@imgtec.com>
References: <1415885111-4138-1-git-send-email-ezequiel.garcia@imgtec.com> <1415885111-4138-2-git-send-email-ezequiel.garcia@imgtec.com> <20141113173825.GD1275@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141113173825.GD1275@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 11/13/2014 02:38 PM, Wolfram Sang wrote:
> Hi,
> 
> Thank you for this submission! Wow, this is a lot of code and I
> have only very minor comments. Good work and thanks to all
> previous reviewers!
> 
>> @@ -0,0 +1,1415 @@ +/* + * I2C adapter for the IMG Serial Control
>> Bus (SCB) IP block. + * + * Copyright (C) 2009, 2010, 2012, 2014
>> Imagination Technologies Ltd. + * + * This program is free
>> software; you can redistribute it and/or modify + * it under the
>> terms of the GNU General Public License version 2 as + *
>> published by the Free Software Foundation. + * + * There are
>> three ways that this I2C controller can be driven:
> 
> Interesting beast. Offers a lot of possibilities and complexity :)
> 
>> + * Notice that the driver implements a timer-based timeout
>> mechanism. + * This is done to avoid slave events interrupts in
>> automatic mode, + * given the driver gets a slave event and
>> transaction done interrupts + * for each atomic mode command
>> (start, data, ack, stop, etc) that gets + * completed, none of
>> which are of interest when using automatic mode + * since those
>> atomic mode commands are managed automatically by hardware + *
>> rather than by the I2C state machine in the interrupt handler.
> 
> I read this three times and still have no clear picture. Please 
> rephrase. Smaller sentences. Simple ones.
> 

Ugh.. that sentence is definitely too long! I'll rephrase.

> 
> ... all down to probe()
> 
>> +	i2c_set_adapdata(&i2c->adap, i2c); +	i2c->adap.dev.parent =
>> &pdev->dev; +	i2c->adap.dev.of_node = node; +	i2c->adap.owner =
>> THIS_MODULE; +	i2c->adap.class = I2C_CLASS_HWMON |
>> I2C_CLASS_SPD;
> 
> You probably won't need this one. You have DT probing.
> 

OK.

>> +	i2c->adap.algo = &img_i2c_algo; +	i2c->adap.retries = 5; +
>> i2c->adap.nr = pdev->id; +	snprintf(i2c->adap.name,
>> sizeof(i2c->adap.name), +		 "IMG i2c%d", i2c->adap.nr);
> 
> Please use a static name, like "IMG <some type> I2C". This
> describes the IP block, not the bus in use.
> 

OK.

> Very close to go...
> 
> checkpatch --strict says:
> 
> CHECK: Please don't use multiple blank lines #234: FILE:
> drivers/i2c/busses/i2c-img-scb.c:181: + +
> 
> CHECK: Blank lines aren't necessary before a close brace '}' #621:
> FILE: drivers/i2c/busses/i2c-img-scb.c:568: + +	}
> 
> CHECK: braces {} should be used on all arms of this statement #810:
> FILE: drivers/i2c/busses/i2c-img-scb.c:757: +			if (i2c->msg.len ==
> 0) [...] +			else if (i2c->msg.flags & I2C_M_RD) [...] +			else { 
> [...]
> 
> And coccicheck:
> 
> drivers/i2c/busses/i2c-img-scb.c:510:1-12: WARNING: Assignment of
bool to 0/1
> 

OK, fixed all of these now.

Thanks,
- -- 
Ezequiel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUZPADAAoJEIOKbhOEIHKiPzQQAIjtDqsjpWZ9HxZzL26Jy2/j
DYct0t2wlo27Q2Y1GHjd34Or3ifTzPApAiOeD8cruY21JgEFv7nlw7isZM8yvd5M
NUNTxfgaAyiJ4ikEnfRioUm+aRabBv1WLWSBmW1PQ6dnpq+8Qe+PIoiQo4MY/sWZ
xBoxLuLpx9lSjhF+GedhI8q732hZrtAhcPVR3Lt44G36ArixLqGRcEaIwmrdtSNC
bUYJIkv7uKIAyyezMtxzUATAY6ZbaXNYwAGfSPoBvgff2gCuONHdpmGJl+5SCI+Y
CqIFw4TCgK5Rx+VNvthIIlFj4TQkKQd1vZBuF5IX4gEnNkyyUTYb4kiF/8KAe5rm
5fV4lp4aQmXjsQpos2A5qsO9LH058+9HdamRgbv68NLKopOrGRdvGEXVRC9quba3
y8EJ6gHphamMcYNd9VAaA+L1FVCsACPhUuJddUNmukmKSODeIAGAzfnXPmeoYcZo
6JNUKXyL/ouwhWA1jPe/FlBEmD77vqu1DBmO/5DlhNmYT6qiIA8Y32tJG5EsdCjb
uaq5inMSgMshFP+P3mbMWp/V7puogLxaaqSoZNIfi3sIfR5Fsad86eu+rlYV8VXR
byz05zurRZZyX0Eo9azvLC5vkCnJL0oXXULETmRwTXbHj6rRajsao5cjuU27c6Pm
uTsvJHndhCaC7S2Z1rLi
=YwwK
-----END PGP SIGNATURE-----

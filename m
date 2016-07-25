From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 25 Jul 2016 10:02:08 +0300
Message-ID: <27421469430128@web19h.yandex.ru>
References: <137031469256709@web4j.yandex.ru> <20160723195114.GA2104@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward1j.cmail.yandex.net ([5.255.227.19]:46542 "EHLO
	forward1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127AbcGYHJ2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jul 2016 03:09:28 -0400
In-Reply-To: <20160723195114.GA2104@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hello,

23.07.2016, 22:51, "Wolfram Sang" <wsa@the-dreams.de>:
> Hi,
>
>> =C2=A0I'm working on multi-master i2c support in Aspeed SoC (AST2150=
,
>> =C2=A0AST2300 and so on) and succeed with event passing to the slave
>> =C2=A0software backend. Besides AST has two operation modes: byte tr=
ansfer
>
> Which upstream driver does that SoC use?

This one:
https://github.com/openbmc/linux/blob/dev-4.4/drivers/i2c/busses/i2c-as=
peed.c

Plus my work-in-progress patch with slave support:
https://github.com/ya-mouse/openbmc-target/blob/master/aspeed/patches-4=
=2E4/0068-openmouse-i2c-aspeed-slave-support.patch

>
>> =C2=A0and buffer transfer. While i2c slave framework operates over b=
ytes. In
>> =C2=A0current scheme I would able to receive an interrupt on buffer =
fill
>> =C2=A0then call N-times event function with one byte. It is a little
>> =C2=A0overhead there. What we can do there?
>
> Let me quote from Documentation/i2c/slave-interface:
>
> About buffers
> -------------
>
> During development of this API, the question of using buffers instead=
 of just
> bytes came up. Such an extension might be possible, usefulness is unc=
lear at
> this time of writing. Some points to keep in mind when using buffers:
>
> * Buffers should be opt-in and slave drivers will always have to supp=
ort
> =C2=A0=C2=A0byte-based transactions as the ultimate fallback because =
this is how the
> =C2=A0=C2=A0majority of HW works.
>
> * For backends simulating hardware registers, buffers are not helpful=
 because
> =C2=A0=C2=A0on writes an action should be immediately triggered. For =
reads, the data in
> =C2=A0=C2=A0the buffer might get stale.
>
> * A master can send STOP at any time. For partially transferred buffe=
rs, this
> =C2=A0=C2=A0means additional code to handle this exception. Such code=
 tends to be
> =C2=A0=C2=A0error-prone.
>
>> =C2=A0Second one thing that I want to point is a slave support in I2=
C MUX/switch
>> =C2=A0drivers. For instance I use PCA9548 switch and want to have N =
(N <=3D 8) slaves
>> =C2=A0(one per channel)
>
> How do the other masters know that their channel is currently muxed t=
hen? And
> what if two of them want to access two of your slaves at the same tim=
e?

In current implementation this I2C switch might be only switched from o=
ne side (via i2c command). From the MUX point of view, there is only on=
e master (which may mux) and a number of slaves behind each channel. Bu=
t on proto level IPMB requires to act as multi-master to receive answer=
s from other intelligent nodes. To receive answer requesting node have =
to switch to slave mode after master write request.

Please take a look at page 13:=20
http://www.intel.com/content/www/us/en/servers/ipmi/ipmp-spec-v1-0.html

The quote:
"Intelligent devices on the Intelligent Platform Management Bus transmi=
t requests and responses as bus
Masters and receive requests and response as bus Slaves. Thus, the only=
 Master Write transactions are
seen between intelligent nodes."

>
> This setup may work for one specific case but in general sounds prett=
y fragile
> to me. This fragility shows in all the hacks needed to work around th=
e proper
> abstractions. I don't think much can be done about that.
>
> Regards,
>
> =C2=A0=C2=A0=C2=A0Wolfram

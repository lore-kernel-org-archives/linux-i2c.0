From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C master bridge
Date: Sat, 23 Jul 2016 07:44:57 +0300
Message-ID: <80161469249097@web5m.yandex.ru>
References: <578A95E4.1080903@gmx.de> <132011469036072@web17m.yandex.ru> <578FC09D.8040706@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward3h.cmail.yandex.net ([87.250.230.18]:33821 "EHLO
	forward3h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbcGWEwO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 23 Jul 2016 00:52:14 -0400
In-Reply-To: <578FC09D.8040706@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



20.07.2016, 21:19, "Jan Kandziora" <jjj@gmx.de>:
> Am 20.07.2016 um 19:34 schrieb Evgeniy Polyakov:
>> =C2=A0Is that a hardware limitation that there is no interrupt or ot=
her
>> =C2=A0completion mechanism which would handle this case?
>
> Ah, forgot to address that question.
>
> The DS28E17 has a BUSY pin. We could add an interrupt-driven busy
> mechanism but the mechanism without the interrupt line has to stay in
> there because most people wouldn't add an interrupt line to their
> Onewire installation just for having that.

Ok, I see, its just a hardware issue which requires to have this potent=
ially unhealthy busy loop.

Both patches look good to me, thank you.
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

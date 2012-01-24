From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Accessing EEPROM from Linux driver
Date: Tue, 24 Jan 2012 11:13:59 +0100
Message-ID: <CAGm1_ksgrtyAmo73f-GCr_ZH=8i8LxbwFpMH81U2STQzmT9GYQ@mail.gmail.com>
References: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A@mail.gmail.com>
 <20120124100636.GB2609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120124100636.GB2609-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 24, 2012 at 11:06 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> =
wrote:
>
>> sysfs from userland. What were the appropriate method of accessing
>> EEPROM from a network driver? AFAIK no functions were exported from
>> eeprom.c.
>
> Please state always which version you are using. There is code exactl=
y
> for your use case in the driver since ~2.6.30 (and clearly described =
as
> such).
>
> 437 /*
> 438 =C2=A0* This lets other kernel code access the eeprom data. For e=
xample, it
> 439 =C2=A0* might hold a board's Ethernet address, or board-specific =
calibration
> 440 =C2=A0* data generated on the manufacturing floor.
> 441 =C2=A0*/

Thanks. My bad, I overlooked this.

Regards,
Yegor

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Accessing EEPROM from Linux driver
Date: Tue, 24 Jan 2012 12:03:14 +0100
Message-ID: <CAGm1_kugwA-rWXmCNNcxRc4XZ5u-2N8Rwf+LBaoRrOgBWMTbDg@mail.gmail.com>
References: <CAGm1_ku3N0ksJ4USt9Rae=Yo3xcTFX=dLVh6=YMkFjUaLABu-A@mail.gmail.com>
 <20120124100636.GB2609@pengutronix.de> <CAGm1_ksgrtyAmo73f-GCr_ZH=8i8LxbwFpMH81U2STQzmT9GYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGm1_ksgrtyAmo73f-GCr_ZH=8i8LxbwFpMH81U2STQzmT9GYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 24, 2012 at 11:13 AM, Yegor Yefremov
<yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> On Tue, Jan 24, 2012 at 11:06 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org=
> wrote:
>>
>>> sysfs from userland. What were the appropriate method of accessing
>>> EEPROM from a network driver? AFAIK no functions were exported from
>>> eeprom.c.
>>
>> Please state always which version you are using. There is code exact=
ly
>> for your use case in the driver since ~2.6.30 (and clearly described=
 as
>> such).
>>
>> 437 /*
>> 438 =C2=A0* This lets other kernel code access the eeprom data. For =
example, it
>> 439 =C2=A0* might hold a board's Ethernet address, or board-specific=
 calibration
>> 440 =C2=A0* data generated on the manufacturing floor.
>> 441 =C2=A0*/
>
> Thanks. My bad, I overlooked this.

Wolfram, do you have any example how to access at24_macc_read()? My
kernel is 2.6.37. Theres is a statement to export this code to the
kernel via chip.setup(), which appears to be NULL. What headers do I
need in the network driver?

Regards,
Yegor

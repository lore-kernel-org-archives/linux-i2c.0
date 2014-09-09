From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of timeout
Date: Tue, 9 Sep 2014 20:59:26 +0200
Message-ID: <201409092059.26410.marex@denx.de>
References: <540DEFA6.9030600@elproma.com.pl> <201409091559.24900.marex@denx.de> <540F1734.6090700@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <540F1734.6090700-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, September 09, 2014 at 05:05:24 PM, Janusz U=C5=BCycki wrote=
:

[...]

> >> If it is too fast a slave has possibility to inform by setting SCL=
 low.
> >=20
> > Do you mean clock stretching ?
>=20
> Yes, I didn't notice it is the same.

OK

> >> However I haven't seen any driver which supports the method.
> >>=20
> >>>> |Checking CTRL1_NO_SLAVE_ACK_IRQ |bit for SELECT command will in=
crease
> >>>>=20
> >>>> code size only
> >>>> without special profit. Current PIO implementation also gathers =
all
> >>>> errors together and reads them on the end by
> >>>> mxs_i2c_pio_check_error_state(). Probably
> >>>> mxs_i2c_pio_check_error_state() call or
> >>>> enabling interrupt masks for PIO could be better than
> >>>> direct |CTRL1_NO_SLAVE_ACK_IRQ |bit checking for clear code.
> >>>> It also could support multimaster for PIO (MASTER_LOSS).
> >>>=20
> >>> Actually, the PIO is explicitly IRQ-less and is used only for
> >>> transferring very short amounts of data.
> >>=20
> >> Yes but error service could be more common probably.
> >=20
> > Feel free to prepare a patch please!
>=20
> On the moment the fix is enough for me. I did need i2cdetect to work.

You should be really careful here. Please note that the I2C is not a Pn=
P bus and=20
probing the I2C might have adverse effect on various devices attached t=
o the=20
bus.

> I looked on 2.6.35 FSL BSP. There both DMA and PIO mode use status
> interrupt and cmd_complete. It was changed to speed up?

Yes, esp. in short transfers.

Best regards,
Marek Vasut

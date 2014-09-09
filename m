From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of timeout
Date: Tue, 9 Sep 2014 14:48:40 +0200
Message-ID: <201409091448.40115.marex@denx.de>
References: <540DEFA6.9030600@elproma.com.pl> <201409082033.58959.marex@denx.de> <540EC808.6060407@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <540EC808.6060407-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, September 09, 2014 at 11:27:36 AM, Janusz U=C5=BCycki wrote=
:
> W dniu 2014-09-08 20:33, Marek Vasut pisze:
> > On Monday, September 08, 2014 at 08:06:12 PM, Janusz U=C5=BCycki wr=
ote:
> >> Subject: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of time=
out
> >>=20
> >>    (1000ms)
> >>=20
> >> i2cdetect scanned i2c bus very slow if address was not occupied by=
 any
> >> device.
> >=20
> > Shouldn't this check be used only after the 'SELECT' command ?
>=20
> It looks |||mxs_i2c_isr()| for DMA transfer does not differentiate
> commands also
> and does not mask irqs for each command.
>=20
> |STAT_GOT_A_NAK|  is a separate bit.|CTRL1_NO_SLAVE_ACK_IRQ can be se=
t
>=20
> both after SELECT and WRITE command. Should we differentiate?

What about writes that take long time, will checking this bit not break=
 them ?=20
(like programming a slow eeprom or such)

> |Checking CTRL1_NO_SLAVE_ACK_IRQ |bit for SELECT command will increas=
e
>=20
> code size only
> without special profit. Current PIO implementation also gathers all e=
rrors
> together and reads them on the end by mxs_i2c_pio_check_error_state()=
=2E
> Probably mxs_i2c_pio_check_error_state() call or
> enabling interrupt masks for PIO could be better than
> direct |CTRL1_NO_SLAVE_ACK_IRQ |bit checking for clear code.
> It also could support multimaster for PIO (MASTER_LOSS).

Actually, the PIO is explicitly IRQ-less and is used only for transferr=
ing very=20
short amounts of data.

Best regards,
Marek Vasut

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [rtc-linux] Re: i2c/rtc init dependency problem
Date: Fri, 25 Sep 2009 20:45:33 +0200
Message-ID: <20090925204533.69681f35@hyperion.delvare>
References: <152584230909240758h674ffe3cw4d5e6baef5efc9b8@mail.gmail.com>
	<20090924151953.GD3154@pengutronix.de>
	<8b192c78-6ebf-42ec-b334-756f56cc5400@g6g2000vbr.googlegroups.com>
	<20090925065843.GA4125@pengutronix.de>
	<152584230909250749w305b5202tba55bfedd742fea9@mail.gmail.com>
	<152584230909251138r7051a279k71e10ac778e28742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <152584230909251138r7051a279k71e10ac778e28742-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexander Bigga <ab-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 25 Sep 2009 14:38:39 -0400, Jon Ringle wrote:
> Alexander:
>=20
> On Fri, Sep 25, 2009 at 10:49 AM, Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org> wrote:
> > However, it still does not work with your patch. In the dump below =
I see:
> > [ =A0 =A00.250000] i2c-core: driver [dummy] registered
> > ...
> > [ =A0 =A00.290000] i2c-adapter i2c-0: adapter [IOP3xx-I2C] register=
ed
> > ...
> > [ =A0 =A03.780000] i2c-core: driver [rtc-m41t80] registered
> [Note: missing i2c-adapter i2c-0 debug msgs expected when rtc-m41t80 =
probe]
> > [ =A0 =A03.790000] i2c /dev entries driver
> > [ =A0 =A03.790000] i2c-core: driver [dev_driver] registered
> > [ =A0 =A03.800000] i2c-dev: adapter [IOP3xx-I2C] registered as mino=
r 0
> > [ =A0 =A03.800000] i2c-core: driver [lm75] registered
> > [ =A0 =A03.830000] i2c-adapter i2c-0: found normal entry for adapte=
r 0, addr 0x48
> > ...
> > [ =A0 =A04.050000] drivers/rtc/hctosys.c: unable to open rtc device=
 (rtc0)
>=20
> I think the problem is that rtc-m41t80 does not provide either of the=
 following:
>     struct i2c_driver: detect and address_data (both are null)
> as required by i2c_detect()

This should be OK. detect and address_data are optional and only needed
for drivers which autodetect their devices. The rtc-m41t80 probably
doesn't want to do this. The device should be declared by the arch or
platform.

>   -> called by __attach_adapter()
>   -> called by i2c_register_driver()
>   -> called by i2c_add_driver()
>   -> called by m41t80_rtc_init()
>=20
> *or*
>     struct i2c_driver: attach_adapter (null)

This legacy method no longer exists, so I certainly hope it isn't
implemented ;)

> as required by __attach_adapter()
>   -> called by i2c_register_driver()
>   -> called by i2c_add_driver()
>   -> called by m41t80_rtc_init()

--=20
Jean Delvare

From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/1] at24: add i2c_driver struct member for
 at24_driver, and reduce the priority of at24_init
Date: Tue, 21 Sep 2010 09:17:36 +0200
Message-ID: <20100921071736.GC3168@pengutronix.de>
References: <1285049243-17058-1-git-send-email-jgq516@gmail.com>
 <20100921063828.GA3168@pengutronix.de>
 <AANLkTi=BtMXtSuetDe60QMsVi-5gBy+JGi7+1X+=v4UV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=BtMXtSuetDe60QMsVi-5gBy+JGi7+1X+=v4UV-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: xiaojiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>    Yes, we can't cover all the eeprom types, but I think people need
>    one example with all the function can be used. If somebody need use
>    at24.c for another eeprom, he only need to do the change
>    "s/at24/eeprom type", which maybe helpful to others. Anyway,
>    current code aren't work because of the lack of these members.

The instantiation of devices is described here:

Documentation/i2c/instantiating-devices

I'd think that would do to help people?

>      > 2. Since the at24 driver are tightly coupled with i2c bus
>      > driver, make =EF=BF=BD =EF=BF=BDsure it's init priority is lower t=
han i2c bus.
>=20
>      Can you describe a scenario where the current method fails?
>=20
>    In my board, at24_init() is called before i2c-bus driver, because
>    the bus driver is initialized with module_init. But some i2c bus
>    used subsys_initcall to replace module_init, those i2c bus should
>    be ok without the change. I think only do one modification is
>    better than change all the i2c bus driver.

But they should still match, even if at24 comes first, no? Otherwise
there is a bug somewhere. (BTW changing i2c-bus-drivers to
subsys_initcall() looks better to me, too, because if there is something
like a PMIC or GPIOs connected to the bus, you usually want them early).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyYXBAACgkQD27XaX1/VRslGQCfbrq7O2syzCuBrqv5Ss/JQ1qZ
UTgAoLckXOz7oimSyzT4C5LJtVhc4gNS
=Yhcw
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

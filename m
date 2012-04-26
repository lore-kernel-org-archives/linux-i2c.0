From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: possible MXS-i2c bug
Date: Thu, 26 Apr 2012 13:42:01 +0200
Message-ID: <20120426114201.GC3548@pengutronix.de>
References: <201204261326.29388.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204261326.29388.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

you forgot the most important list, linux-i2c ;)

> I recently tried mxs-i2c (on 3.4-rc4) with at24 eeprom, didn't work as ex=
pected.

Yes, we had the same this week/last week.

> Apparently, there might be some timing issue, when I put printk() into th=
e at24=20
> driver eeprom write function, it "fixed" itself. Though, replacing the i2=
c=20
> driver with i2c gpio also fixed the issue, so I suspect the i2c driver ha=
s some=20
> flaw in it.

Try removing the printk and use the module paramter "io_limit=3D24" for
at24. Does this help? (Or bs<=3D24 with dd)

> If noone has any fixes already, I'll debug this tonight or so.

The write FIFO overflows, since it only can carry 8 words. There is
currently no check for that. One solution would be to check the FIFO
status and fill them as needed. This will probably require additional
locking, so I think the proper solution would be to use DMA for
transfers bigger than the write FIFO size (we would get MX23 support
then, too). Sadly, we don't have DMA support yet and I don't have time
to implement it.

I am thinking if such transfers which would fail anyway, should
currently be rejected or if the driver should depend on BROKEN or both.

I am still undecided, though.

Please also check the patch I sent yesterday, there is also another one
coming after I get confirmation from a customer.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ZNIkACgkQD27XaX1/VRu1ygCeJSRUzlIxVezNMxoHDTZ56cyC
7pAAoKzAiEbiNbGxmMB3DXA+S4d0oEcD
=QcHL
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

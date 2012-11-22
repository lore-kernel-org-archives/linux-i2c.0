From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Add PIO and mixed-DMA support
Date: Thu, 22 Nov 2012 12:50:37 +0100
Message-ID: <20121122115037.GA12080@pengutronix.de>
References: <1353477088-9660-1-git-send-email-marex@denx.de>
 <201211220150.37462.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201211220150.37462.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2012 at 01:50:37AM +0100, Marek Vasut wrote:
> Dear Marek Vasut,
>=20
> > Add support for the PIO mode and mixed PIO/DMA mode support. The mixed
> > PIO/DMA is the default mode of operation. This shall leverage overhead
> > that the driver creates due to setting up DMA descriptors even for very
> > short transfers.
> >=20
> > The current boundary between PIO/DMA 8 bytes, transfers shorter than 8
> > bytes are transfered by PIO, longer transfers use DMA. The performance
> > of write transfers remains unchanged, while there is a minor improvement
> > of read performance. Reading 16KB EEPROM with DMA-only operations gives
> > a read speed of 39.5KB/s, while with then new mixed-mode the speed is
> > blazing 40.6KB/s.
> >=20
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> [...]
>=20
> btw. Wolfram, you might want to drop me some credit into the MX28 i2c dri=
ver, I=20
> suspect most of the code in there is mine now anyway :-D

It's fine if you do this yourself.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCuEY0ACgkQD27XaX1/VRtr3ACeOrctJzu8IFrYH3MkhWkRjFDQ
GmQAn1MiyJA7bs5/Ns3kdEtNo+sCu5/d
=aomL
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

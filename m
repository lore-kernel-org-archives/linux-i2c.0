From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V2] i2c: mxs: Add PIO and mixed-DMA support
Date: Thu, 24 Jan 2013 15:17:15 +0100
Message-ID: <20130124141715.GJ12933@pengutronix.de>
References: <1359032181-10601-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tu8ztk+XgTAiG9Id"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359032181-10601-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Tu8ztk+XgTAiG9Id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 01:56:21PM +0100, Marek Vasut wrote:
> Add support for the PIO mode and mixed PIO/DMA mode support. The mixed
> PIO/DMA is the default mode of operation. This shall leverage overhead
> that the driver creates due to setting up DMA descriptors even for very
> short transfers.
>=20
> The current boundary between PIO/DMA 8 bytes, transfers shorter than 8
> bytes are transfered by PIO, longer transfers use DMA. The performance
> of write transfers remains unchanged, while there is a minor improvement
> of read performance. Reading 16KB EEPROM with DMA-only operations gives
> a read speed of 39.5KB/s, while with then new mixed-mode the speed is
> blazing 40.6KB/s.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

OK, the polling can be argued. I shortened the comment about the
threshold a little, since bandwidth measurements depend on a lot of
other things and it is not really needed there.

Applied to -next, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Tu8ztk+XgTAiG9Id
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlEBQmsACgkQD27XaX1/VRsN1QCeMgPyzGnYG7gUlBC6UVxckjuE
Ae8An0ffjQIe9CaUdNsu4Brd3UJyXkEn
=VxSo
-----END PGP SIGNATURE-----

--Tu8ztk+XgTAiG9Id--

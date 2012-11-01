From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: remove broken PIOQUEUE support
Date: Thu, 1 Nov 2012 17:08:28 +0100
Message-ID: <20121101160828.GA18425@pengutronix.de>
References: <1351771003-6071-1-git-send-email-w.sang@pengutronix.de>
 <201211011528.17596.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201211011528.17596.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2012 at 03:28:17PM +0100, Marek Vasut wrote:
> Dear Wolfram Sang,
>=20
> > This I2C master can do DMA and PIOQUEUE (PIO with FIFO). Originally,
> > only PIOQEUE
>=20
> PIOQUEUE ;-)

Yup, right!

>=20
> > was supported, then DMA support was added. The original
> > intention was to keep PIOQUEUE since it has less overhead what is nice
> > for small transfers. However, runtime switching between PIOQEUE and DMA
> > depending on the transfer size never worked despite a lot of trying.
> > Since PIOQUEUE mode itself was flaky (polling at places where interrupts
> > failed to work) and the implementation also imposed a size limit for
> > transfers, it is best to remove the support altogether which makes the
> > driver a lot cleaner and more robust. If somebody really wants less
> > overhead, plain PIO mode could still be implemented with the addidtional
> > advantage that this mode is also available on MX23, too.
>=20
> Yes, looks to be the way to go.
>=20
> Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Thanks.

BTW have you tried combining all i2c-messages (msgs[]) of the transfer
into one DMA chain? That would reduce overhead, too, no?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCSnnwACgkQD27XaX1/VRtLWQCgxJaGhURLhp//cyL+33+6+xS/
QKgAoKmzp4RKpaMZt8fkUESoncsWHbQd
=YFFv
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

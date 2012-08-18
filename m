From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Fix ifdefs for suspend mode
Date: Sat, 18 Aug 2012 14:12:16 +0200
Message-ID: <20120818121216.GA12839@pengutronix.de>
References: <1343655187-18282-1-git-send-email-ldewangan@nvidia.com>
 <20120818070732.GA24639@pengutronix.de>
 <20120818120138.GD21888@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120818120138.GD21888-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 18, 2012 at 01:01:38PM +0100, Mark Brown wrote:
> On Sat, Aug 18, 2012 at 09:07:32AM +0200, Wolfram Sang wrote:
> > On Mon, Jul 30, 2012 at 07:03:07PM +0530, Laxman Dewangan wrote:
> > > CONFIG_PM covers runtime only PM.
>=20
> > I am a bit confused by this description. CONFIG_PM_RUNTIME covers
> > runtime PM, no?
>=20
> The issue is that CONFIG_PM doesn't actually enable any of the PM
> callbacks, it only allows you to enable CONFIG_PM_SLEEP and
> CONFIG_PM_RUNTIME.  This means that if you use CONFIG_PM to protect your
> system sleep callbacks they may end up unreferenced if only runtime PM
> is enabled.

Thanks for the explanation!

Laxman, could you update the description to reflect that?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvhqAACgkQD27XaX1/VRtUGwCglSe5uQRmDW9RHO+wfJjDuH37
fI8An2P/PT9e+ZvZFS2zUNY4pXdzA7kY
=H7JU
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

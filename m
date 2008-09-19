From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: pca9665
Date: Fri, 19 Sep 2008 12:08:19 +0200
Message-ID: <20080919100819.GC4307@pengutronix.de>
References: <48D12295.8080008@gamic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8883645724354796749=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48D12295.8080008-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============8883645724354796749==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marco,

sorry for the late reply, I had to work on other parts first.

On Wed, Sep 17, 2008 at 12:30:29PM -0300, Marco Aurelio da Costa wrote:

> I looked into the code for i2c-algo-pca.c and, if I don't want to=20
> implement the buffered mode (I can live without it for a while),

But it may be worth to already get a rough idea if the buffered mode
will fit into this algorithm at all.

> only changes I need to do are:
> 1. Implement the reset via parallel bus.

I can't see this point right now. The algorithm expects a reset routine
=66rom the driver using the algorithm; this should be flexible enough, no?
Or do you mean you also want to share i2c-pca-platform.c among those two
chips. Then it's correct to change it there. Otherwise, please enlighten
me, it's been some time :)

> 2. Change the way the i2c clock rate is treated, by passing the=20
> frequency directly instead of an index.

Yup, this has to be generalized between these two.

> After this, this module could handle both chips. I need your advice:
> Should I just duplicate all code and make the changes to this new algo=20
> or should I add a chip_type field to i2c_algo_pca_data and handle the=20
> chip on the existing algo code?

Concerning the algorithm, I'd really go for the latter. It is easier to
maintain if there will be bugfixes to the state-machine, for example.
And they seem to be similar enough (perhaps modulo the buffered mode,
which I didn't look at so far).

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI03oTD27XaX1/VRsRAqiRAKCzkaokuCXmSBgibAzJpHbh4Sw3uACfRgmm
iVVjBWCl1iL/c7iAoosal/o=
=6UWk
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--


--===============8883645724354796749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8883645724354796749==--

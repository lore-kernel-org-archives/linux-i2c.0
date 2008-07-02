From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [i2c] [PATCH 1/2] Convert i2c-mpc from a platform driver into
	a of_platform driver, V4
Date: Wed, 2 Jul 2008 15:33:43 +0200
Message-ID: <20080702133343.GC4253@pengutronix.de>
References: <20080630230126.12482.87927.stgit@terra>
	<20080701181444.505c1544@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1994247879=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080701181444.505c1544@hyperion.delvare>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org


--===============1994247879==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Tue, Jul 01, 2008 at 06:14:44PM +0200, Jean Delvare wrote:

> Applied, after fixing the patch so that it applies, fixing it again so
> that it is correct in the polling case, and fixing it again to make it
> pass checkpatch.pl.
So, it cannot be applied directly? :(

Could you repost the correct version perhaps? I'd like to test it, but
can't find it at http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
(because it is scheduled for 2.6.27?).

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIa4O3D27XaX1/VRsRAl5cAJ9FLuUHbhGraXdmbton7AZz0ouFAQCgy1+/
ttcR+txcbspDocV9iLIVobE=
=HhBQ
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--

--===============1994247879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1994247879==--

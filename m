From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
Date: Tue, 26 Jan 2010 16:37:59 +0100
Message-ID: <20100126153759.GF4431@pengutronix.de>
References: <1264411234-5400-1-git-send-email-u.kleine-koenig@pengutronix.de> <20100125111055.05ccedf2@hyperion.delvare> <20100126143830.GC12774@fluff.org.uk> <20100126162515.230bdf36@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754268Ab0AZPiK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100126162515.230bdf36@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> So I see no objection to a mass move of all embedded/system i2c bus
> drivers to a separate sub-directory.

And with the PCA9xxx-controllers? The ISA-driver into non-embedded and the
platform-driver into embedded? Hmmm...

And (in 80 years ;)) there might be just one I2C-maintainer taking care of =
them
all? Then, why the split?

I am all for taking the embedded-burden away from you, just I am not too fo=
nd
of this idea.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktfDFcACgkQD27XaX1/VRvBdACdGcOB7kKbnYutaSkD/VYAGuDg
lOUAnjCn6z2Zpug5h1anrHaQu1/eOLhE
=wUUR
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--

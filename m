From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/1 v4] i2c: Add default configuration into the Nomadik
 I2C driver.
Date: Sat, 18 Aug 2012 10:01:10 +0200
Message-ID: <20120818080110.GC24639@pengutronix.de>
References: <1344266253-14050-1-git-send-email-lee.jones@linaro.org>
 <20120808131158.GD8227@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6623433267419234264=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120808131158.GD8227@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============6623433267419234264==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2012 at 02:11:59PM +0100, Lee Jones wrote:
> From: Lee Jones <lee.jones@linaro.org>
> Date: Tue, 7 Aug 2012 12:27:24 +0100
> Subject: [PATCH 1/1 v4] i2c/nomadik: Add default configuration into the N=
omadik I2C driver

Actually, unlike Linus said, I prefer "i2c: nomadik:"; minor nit,
though.

>=20
> At this moment in time there is only one known configuration for the
> Nomadik I2C driver. By not holding that configuration in the driver
> adds some unnecessary overhead in platform code. The configuration
> as already been removed from platform code, this patch checks for any

  ^^ has ( I fixed it )

> over-riding configurations. If there aren't any, the default is used.
>=20
> Cc: linux-i2c@vger.kernel.org
> Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to -current, thanks! I added a note from Linus that it is needed
because of boot regressions. That is also useful in commit messages.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvS8YACgkQD27XaX1/VRsncACgxi8CiSYzfQv0HrukPKTvi9pS
PKAAmwQel/F0zw6rpk/t/Q5mI3gwUsZY
=CYe2
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--


--===============6623433267419234264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6623433267419234264==--

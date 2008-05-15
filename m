From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4] I2C bus driver for IMX
Date: Thu, 15 May 2008 10:30:04 +0200
Message-ID: <20080515083004.GA4302@pengutronix.de>
References: <g0c44d$2ji$1@ger.gmane.org> <20080514213214.GB16881@fluff.org.uk>
	<g0gqiq$21q$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8196090245684529531=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <g0gqiq$21q$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============8196090245684529531==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2008 at 10:55:30AM +0300, Darius wrote:

> >> +	for (i=3D0; i<I2C_IMX_TIME_BUSY; i++) {
> > spacing in here: for (i =3D 0; i < I2C_IMX_TIME_BUSY; i++)
> what is there wrong with spacing?
>
> > spacing in here, (temp & I2CR_IEN) ? 1 : 0
> I really should add dummy spaces...?
Please do. Documentation/CodingStyle recommends it. While personal
opinions on ceratin topics may vary, I think it is indeed helpful,
if all kernel sources look somewhat similar.

> > yeurk, put these in a seperate header file, or place them near
> > the driver. The "One Big Register File" is horrible, and hopefully
> seems, everybody has her own opinion. Is there somebody one, who can say
> how that should be? Because I have already two times changed that... I'm
> only beginner, so ambiguous comments are very unwanted...  As I know,
> Jean Delvare is responsible for I2C drivers. So, his word is welcome:)
He suggested the same (=3D no register file) to me in January for the
PCA9564-driver.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIK/SMD27XaX1/VRsRAp2kAJ96+ZkP4a6aUmSGKNkJthnOZDzROwCgtLfU
DeMaVYsvDS8vr9Xq6kaE1y0=
=3+x+
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


--===============8196090245684529531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8196090245684529531==--

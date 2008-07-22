From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Remove client validation
Date: Tue, 22 Jul 2008 17:56:37 +0200
Message-ID: <200807221756.44738.laurentp@cse-semaphore.com>
References: <200807021332.15495.laurentp@cse-semaphore.com>
	<20080702133457.05a75e7c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8056295967511722974=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080702133457.05a75e7c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rod Whitby <rod-wR+KslBqWDsXC2x5gXVKYQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--===============8056295967511722974==
Content-Type: multipart/signed; boundary="nextPart1884358.x5eOJ2d3qt";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1884358.x5eOJ2d3qt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Alexander,

On Wednesday 02 July 2008, Jean Delvare wrote:
> On Wed, 2 Jul 2008 13:32:14 +0200, Laurent Pinchart wrote:
> > Validating clients with black magic register checks doesn't make much s=
ense
> > for new-style i2c driver and has been known to fail on valid NXP pcf856=
3 chips.
> > This patch removes the client validation code.
> >=20
> > Signed-off-by: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
> > ---
> >  drivers/rtc/rtc-pcf8563.c |   58 -------------------------------------=
=2D-------
> >  1 files changed, 0 insertions(+), 58 deletions(-)
> > (...)
>=20
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Could you please push the patch for inclusion in 2.6.27 ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1884358.x5eOJ2d3qt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiGAzwACgkQ8y9gWxC9vpfrxACfQqmwWpoaJK4HzPCsLEvBElNi
UdIAnjcBrZBKyhfeUeZAFkGNCwRXt6Gl
=o9p5
-----END PGP SIGNATURE-----

--nextPart1884358.x5eOJ2d3qt--


--===============8056295967511722974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8056295967511722974==--

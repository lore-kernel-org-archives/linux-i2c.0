From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: Re: PCF8563 doesn't pass validation check
Date: Wed, 2 Jul 2008 13:17:48 +0200
Message-ID: <200807021317.50944.laurentp@cse-semaphore.com>
References: <200807021134.59668.laurentp@cse-semaphore.com>
	<20080702131020.28e1979a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5965440441399414032=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080702131020.28e1979a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rod Whitby <rod-wR+KslBqWDsXC2x5gXVKYQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--===============5965440441399414032==
Content-Type: multipart/signed; boundary="nextPart2503923.We6ivNc4W0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2503923.We6ivNc4W0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 02 July 2008, Jean Delvare wrote:
> Hi Laurent,
>=20
> On Wed, 2 Jul 2008 11:34:55 +0200, Laurent Pinchart wrote:
> > I'm having issues with the PCF8563 RTC chip.
> >=20
> > The Linux driver tries to validate the chip by checking if the
> > BCD-coded time and date registers contain valid values.
> >=20
> > When a low voltage condition is detected, the registers are not
> > guaranteed to contain valid values. Experimentation showed that
> > while the seconds, minutes, hours and day of the week registers
> > didn't cause any issue, the months register could get out of the
> > 01-12 range.
> >=20
> > Has anyone experienced the same issue ?
>=20
> This issue sounds familiar, I think Alessandro mentioned it to me a few
> weeks ago in private already.
>=20
> > Would it be acceptable to remove the months register check ?
>=20
> I think you should convert rtc-pcf8563 to a new-style i2c driver. Then
> the whole validation function becomes pointless and you can delete it.
> I guess that the PCF8563 chip is used in embedded designs with platform
> code to instantiate the I2C devices as needed, so it should work fine.
> Apparently some IXP4xx platforms already expect rtc-pcf8563 to be a
> new-style i2c driver... I'm curious if some ARM people have already
> converted the driver. Rod?

Isn't rtc-pcf8563 a new-style i2c driver already ?

> > I've contacted NXP to get more information about what the chip
> > guarantees and what it doesn't. I haven't had any answer yet but
> > I expect them to tell me there is no guarantee at all.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2503923.We6ivNc4W0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhrY94ACgkQ8y9gWxC9vpdHmgCffQKiyPmUff+1C+tShSiSsoOf
XSAAn0TBYwjwTurQJDN9zrs2uFkNyTwY
=PbOZ
-----END PGP SIGNATURE-----

--nextPart2503923.We6ivNc4W0--


--===============5965440441399414032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5965440441399414032==--

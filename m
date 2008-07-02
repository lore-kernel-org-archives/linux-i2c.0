From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: PCF8563 doesn't pass validation check
Date: Wed, 2 Jul 2008 11:34:55 +0200
Message-ID: <200807021134.59668.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2119053514055701885=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============2119053514055701885==
Content-Type: multipart/signed; boundary="nextPart29637863.OIjQ6mEHTu";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart29637863.OIjQ6mEHTu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm having issues with the PCF8563 RTC chip.

The Linux driver tries to validate the chip by checking if the BCD-coded ti=
me and date registers contain valid values.

When a low voltage condition is detected, the registers are not guaranteed =
to contain valid values. Experimentation showed that while the seconds, min=
utes, hours and day of the week registers didn't cause any issue, the month=
s register could get out of the 01-12 range.

Has anyone experienced the same issue ? Would it be acceptable to remove th=
e months register check ?

I've contacted NXP to get more information about what the chip guarantees a=
nd what it doesn't. I haven't had any answer yet but I expect them to tell =
me there is no guarantee at all.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart29637863.OIjQ6mEHTu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhrS8MACgkQ8y9gWxC9vpeJGACePhKnefk0dpa5LlyqZ8nvh0q7
Nf8AnRC48dA4Hbj9IVojxKOd4+SYp/+l
=9iHm
-----END PGP SIGNATURE-----

--nextPart29637863.OIjQ6mEHTu--


--===============2119053514055701885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2119053514055701885==--

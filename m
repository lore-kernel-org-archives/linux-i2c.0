From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Tue, 1 Jul 2008 15:26:11 +0200
Message-ID: <200807011526.14514.laurentp@cse-semaphore.com>
References: <20080620084155.GA17701@pengutronix.de>
	<200806241615.08826.laurentp@cse-semaphore.com>
	<4864A342.4020900@scram.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0872942472356755687=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4864A342.4020900-NIgtFMG+Po8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============0872942472356755687==
Content-Type: multipart/signed; boundary="nextPart5816937.M3Qm872koP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5816937.M3Qm872koP
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 27 June 2008, Jochen Friedrich wrote:
> Hi Laurent,
>=20
> >> Bugfixes to the i2c-cpm driver
> >>
> >> - enable correct interrupts (I2CER_TXE instead of I2CER_BUSY)
> >> - replace forgotten iic with i2c
> >> - fix typo (devided)
> >> - prefix debug-output on init with 0x and add frequency
> >>
> >> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >=20
> > Tested on a MPC8247 board. I have experienced I2C issues since migration
> > from ppc to powerpc. This patch seems to solve the problem.
>=20
> What kind of problems have this been? In normal operation there shouldn't=
 be
> any I2CER_TXE interrupts being generated.

I2C devices would frequently (about once every 10 cold boots) be undetected=
 by the kernel. I tried to investigate the issue by hooking up a scope to t=
he I2C signals, but haven't been able to reproduce the problem once the pro=
bes were connected.

This might of course be a case of Murphy's law in action, but the problem d=
isappeared after applying the patch.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart5816937.M3Qm872koP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhqMHYACgkQ8y9gWxC9vpe0vACgkEaz01SMTtqpTjmVYX2swf8f
/eYAoK2dwXylW3pMTu4dDhHjAeeUZSfq
=z9BS
-----END PGP SIGNATURE-----

--nextPart5816937.M3Qm872koP--


--===============0872942472356755687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============0872942472356755687==--

From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Wed, 2 Jul 2008 13:40:23 +0200
Message-ID: <200807021340.26926.laurentp@cse-semaphore.com>
References: <20080620084155.GA17701@pengutronix.de> <4864A342.4020900@scram.de>
	<200807011526.14514.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4657196607570836131=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200807011526.14514.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============4657196607570836131==
Content-Type: multipart/signed; boundary="nextPart5845269.3B3qxj3L67";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5845269.3B3qxj3L67
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 01 July 2008, Laurent Pinchart wrote:
> On Friday 27 June 2008, Jochen Friedrich wrote:
> > Hi Laurent,
> >=20
> > >> Bugfixes to the i2c-cpm driver
> > >>
> > >> - enable correct interrupts (I2CER_TXE instead of I2CER_BUSY)
> > >> - replace forgotten iic with i2c
> > >> - fix typo (devided)
> > >> - prefix debug-output on init with 0x and add frequency
> > >>
> > >> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > >=20
> > > Tested on a MPC8247 board. I have experienced I2C issues since migrat=
ion
> > > from ppc to powerpc. This patch seems to solve the problem.
> >=20
> > What kind of problems have this been? In normal operation there shouldn=
't
> > be any I2CER_TXE interrupts being generated.
>=20
> I2C devices would frequently (about once every 10 cold boots) be undetect=
ed
> by the kernel. I tried to investigate the issue by hooking up a scope to =
the
> I2C signals, but haven't been able to reproduce the problem once the prob=
es
> were connected.  =20
>=20
> This might of course be a case of Murphy's law in action, but the problem
> disappeared after applying the patch.=20

Seems Murphy's law was involved :-( I've run into the same issue just now.

[    0.555664] i2c /dev entries driver
[    0.564539] rtc-pcf8563 0-0051: chip found, driver version 0.4.3
[    0.570038] rtc-pcf8563 0-0051: rtc core: registered rtc-pcf8563 as rtc0
[    1.576209] i2c-adapter i2c-0: I2C transfer: timeout
[    1.579642] lm75: probe of 0-0048 failed with error -1
[snip]
[    2.766230] i2c-adapter i2c-0: I2C transfer: timeout
[    2.769602] rtc-pcf8563 0-0051: pcf8563_get_datetime: read error
[    2.775345] rtc-pcf8563 0-0051: hctosys: unable to read the hardware clo=
ck                                                              =20

The lm75 is there and works after a reboot. In this particular run the pcf8=
563 was detected, but it would sometimes time out during probe as well.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart5845269.3B3qxj3L67
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhraSoACgkQ8y9gWxC9vpdr8wCgzUSbk4F5SDTUMQ2iTvzshMyT
QisAnj/3dlq6mYmvjUXRks1zR2mZ+sz7
=OaCc
-----END PGP SIGNATURE-----

--nextPart5845269.3B3qxj3L67--


--===============4657196607570836131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4657196607570836131==--

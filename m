From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2.6.24.3] 24xx Eeprom driver
Date: Mon, 17 Mar 2008 14:23:44 +0100
Message-ID: <20080317132344.GA21177@pengutronix.de>
References: <47DE2ECB.6050609@elpa.it> <20080317092154.GA6159@pengutronix.de>
	<20080317125350.253cd04a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8184612221157435119=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080317125350.253cd04a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: "ing. Davide Rizzo" <davide-Rm2/HqoNtBE@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============8184612221157435119==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2008 at 12:53:50PM +0100, Jean Delvare wrote:

> Not sure if you refer to something I said, but that's not exactly what
> I said (or if I did, it no longer applied). I am fine with a driver
> that allows writing to EEPROMs as long long as it is a new-style I2C
> driver. What I don't want is a driver that binds automatically to
> anything at address 0x50-0x57 and lets people write to it, because
> users would inevitably break their hardware from times to times.
Understood. When I discovered at24.c, I thought I found a thread coming
to the conclusion I wrote. Well, I can't find this thread right now, but
probably I simlpy got it wrong.

> I totally agree (even though I still don't get what's wrong with the
> user-space approach that has been working for years, with i2c-dev and
> eeprog).
For customer requirement specifications, it can make things a lot easier if
you just say: We provide a file which can be accessed using standard
unix file operations. No need to specify version numbers of extra tools,
which are prone to change (with all side-effects).

> at24 driver is the lack of review and the lack of time to do the
> review myself. But I really would like to have this driver upstream as
> soon as possible if many people want to use it.
Ah, this is great news! Then I will change my priorities, postpone the
ADT7411-driver and test the EEPROM driver first when my time allows.

> I'd rather have David's driver reviewed and merged (possibly tagged
> EXPERIMENTAL) in 2.6.26. That's the best visibility it can get.
That's for sure :)

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH3nDgD27XaX1/VRsRApA1AKChACTWpc9ZbIhheivkkjq64lZTPwCgq1gs
8C7JYyA628EFlwOqgxCJzzM=
=rx3f
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--


--===============8184612221157435119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8184612221157435119==--

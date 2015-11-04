From: Kevin Fenzi <kevin@scrye.com>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Wed, 4 Nov 2015 07:51:43 -0700
Message-ID: <20151104075143.44053d44@sheelba.scrye.com>
References: <20151029112913.1036f00b@voldemort.scrye.com>
	<20151029183032.GA8992@katana>
	<56332316.90506@linux.intel.com>
	<20151030100442.50ac07bd@voldemort.scrye.com>
	<20151102124728.52e82bed@voldemort.scrye.com>
	<20151103081840.GK1509@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/lNlAky0D=gXJZEmPxImyczJ"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 75-148-32-185-Colorado.hfc.comcastbusiness.net ([75.148.32.185]:49228
	"EHLO mail.scrye.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932365AbbKDPAF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Nov 2015 10:00:05 -0500
In-Reply-To: <20151103081840.GK1509@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

--Sig_/lNlAky0D=gXJZEmPxImyczJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Nov 2015 10:18:40 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Mon, Nov 02, 2015 at 12:47:28PM -0700, Kevin Fenzi wrote:
> > Any other ideas or things to try?=20
> >=20
> > It would be nice to have a working touchpad. ;) =20
>=20
> Please attach acpidump of that machine to the bug (or send it directly
> to me) and provide full dmesg with i2c_hid.debug=3D1.

Just to circle back here, I exchanged some emails with Mika and this
one liner gets it working...

Hopefully something can be made upstreamable from this. Thanks much.=20

kevin
--
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/buss=
es/i2c-designware-platdrv.c
index 3dd2de3..31ea736 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -90,6 +90,11 @@ static int dw_i2c_acpi_configure(struct platform_device =
*pdev)
        dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt, NULL=
);
        dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
                           &dev->sda_hold_time);

+       dev->sda_hold_time =3D 30;
=20
        /*
         * Provide a way for Designware I2C host controllers that are not

--Sig_/lNlAky0D=gXJZEmPxImyczJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJWOht/AAoJEEs3sNgP+7teDxIQAMJr1EUT9+2HVRzDUiaZfVRh
fbu2HCBt6AvO7vQ1WDm8VJx5cPylmqek8FnzoPSClmO2p3ihns6VUvkBOtTYn2FN
VtXeir5JECgCZVM9ZWLzrlBNa9HOj+tbiGUub9LWj1vQ2cBZw4LaFBMXA3x3Lbhp
10Fh20XiNew2qPxJO7tqrlaVzeuKTKujhvkgOvxTr6yXBl7LdOTs9hkPhFH85HB5
zq7TkLmIhGcnARg3BT9J/+er+sIrE3KBNOYLLQCQMgC2KGnc2JIl/xHfWD50pZbp
8fWccuFxiCLAhXP78sqsNA5DKKMLrBLYigCQixAztc5hiBDYWmfhINqpSN3pTkzx
vV+r6qFxDdA8tvG6n/aAx2XAZt951ogNekFTuhtwDVv8On0gnpzPHbGTTiyvz21A
RMd3zRlfMJoCZNKCYVT4e22X0CqDkduWHfy6F3EGiQ4uiEN08826A3AgiLmegnae
kduPmRCl+V+GNiRGVj/bFt5vJDWoVAl4u4n5mSarE3dGAZepAAM5wpuVb4nElr5d
BbGnk6htccYdaVtpYhK2CkqsoLw4mX1MaHwUQIVzdPHWVNypHrkS+8jdbhW53UOi
TqdIbuwJs2RGOQfu2N8ohPMssMq7iDPOSY83L5vK+VoOyB9hC0BJOu4UporhlTmK
JwfCgyF7wckzORuPV94m
=hX14
-----END PGP SIGNATURE-----

--Sig_/lNlAky0D=gXJZEmPxImyczJ--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/8] i2c: refactor core and break out blocks
Date: Wed, 31 May 2017 21:07:41 +0200
Message-ID: <20170531190740.2meqs4gcyvfm5bm7@ninjato>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3le6jn47xn3kxe3c"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--3le6jn47xn3kxe3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:20:51AM +0200, Wolfram Sang wrote:
> Yes, I wanted to do this for years now... The I2C core became a huge mono=
lithic
> blob getting harder and harder to maintain. This series breaks out some
> functional parts into seperate files. This makes the code easier to handle
> because of the smaller chunks. It reduces ifdeffery because we can now ha=
ndle
> compilation at the Makefile level. And it helps to spread responsibility,=
 e.g.
> the ACPI maintainers do now have a dedicated file listed in MAINTAINERS.
>=20
> This series was tested with a Renesas Lager board (R-Car H2 SoC). It boot=
ed
> normally and all device drivers for I2C clients seem to work normally. I =
wired
> two I2C busses together and used i2c-slave-eeprom to let one I2C IP core =
read
> out data from the other. That all worked fine. Buildbot is also happy, it=
 found
> two issues of the first (non public) iteration. Thanks!
>=20
> I did not test ACPI and hope for some assistance here :) I'd also be happ=
y if
> people could check the includes of the newly created files, there might be
> missing some.
>=20
> As a result, the main i2c-core file goes down from ~3600 lines to ~2000 l=
ines.
> I think this is pretty helpful. I plan to apply this for v4.13 to not blo=
ck
> other core changes. Let's see if we are there yet and the series is ready.
> Looking forward to comments.
>=20
> A branch can be found here:
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/core-refa=
ctor
>=20

So, I pushed this series out into -next to get broader testing.
Everything went well, so far. Might be famous last words... ;)


--3le6jn47xn3kxe3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkvFHwACgkQFA3kzBSg
KbamYA/+ItzlLQpIqXB3OWGC2LJzzs91bnd3A9j2Dh/+EyC3GLeoJ4nQoqNa6CO6
SpX9vN/KmipinShYRbxstEBb1vyyI3ZYbl3NpxE+J2spTJwoJje2d1O+m+Ub6Wmn
R0p4mPGyNrkyPFn0U8MtpM2cF1JB7VlMuNHq1MUKSr/CzOfUTCoUB0J738DeUb2Y
+eY8zM4w1XyRoh7S2ZBdfmQn/l1J66qEB/IJD/VU4hMuMlwfumvzvRvpLu2Sjqwy
inUNe7Xb5+63c9bYiFefQgQNEt2SfuGPJ7/vPX/aWsyEi52rPbA7v4/PYDK8l7v1
5CUoIjWoubEDehdMk6EA1n2C5lfVr2bYCRrdELPKsJDah78Gwz/dn9Zuc1I6trov
brek5KB/Di7S4Z8G5ESrN+9nVd4UTq0dMmSabqgP9hYErtDE5fLnhgHrBCvW6EOb
TBHKqdWmNm8+VNEwaeo3HcAys9p8/W2uyo5AA/XapP04dQECb/aVVfcGQGmVfpIn
XDC01Lmm6SPQq9sjeC8A7J3HUzWoqzoTSt+SgHBi+XJbIjsiyDRQ402MrDtmd0oe
YA4XSxmyzqGh6Tx3IGPIAFD5zmvAt7OCoIcjIfQW5wKHdNLJwac3GPzTZ0oeXrqp
HXOAMYz95kdjNT3+IptmHJobKZVSMBhgoK+zEmZ1aE6TNjGzFjY=
=KTRM
-----END PGP SIGNATURE-----

--3le6jn47xn3kxe3c--

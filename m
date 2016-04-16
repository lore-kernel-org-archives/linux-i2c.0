From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 00/13] eeprom: support for at24cs and at24mac
Date: Sat, 16 Apr 2016 23:17:33 +0200
Message-ID: <20160416211733.GD1522@katana>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52749 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbcDPVRh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Apr 2016 17:17:37 -0400
Content-Disposition: inline
In-Reply-To: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, Andrew Lunn <andrew@lunn.ch>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 11, 2016 at 11:57:16AM -0700, Bartosz Golaszewski wrote:
> Chips from the at24cs EEPROM series have an additional read-only
> memory area containing a factory pre-programmed serial number. In
> order to access it, a dummy write must be executed before reading
> the serial number bytes.
>=20
> Chips from the at24mac familiy, apart from the serial number, have
> a second special memory area containing a factory programmed
> EUI-48/EUI64 mac address.
>=20
> The read-only serial/mac memory area is accessible on a different i2c
> slave address (addr + 0x08). This patchset makes it possible to
> instantiate a separate at24 device on this second address and access
> the read-only area through the regular eeprom sysfs attribute or the
> new nvmem subsystem.
>=20
> This series also contains several patches intoducing some minor tweaks
> and refactoring.
>=20
> Tested with at24cs32 and at24cs02 chips (for both 16 and 8 bit address
> pointers). I have no means of testing the support for at24mac chips, I
> relied solely on the datasheet.

Thanks for adding at24mac nonetheless!

I still don't understand why you want to add this to at24 instead of
doing a seperate driver for it? You basically tie a read_function to an
nvmem device. You don't need the special smbus handling, cutting large
requests into chunks, write support, size flags and all this from at24.
And with the function pointers, it makes the already complex code a bit
more complex.

IMO, this could be solved by a simple, seperate driver. You could start
with at24 and remove unneeded stuff. I think there should be mainly
nvmem-init code and your read routines left. I also think this new
driver should be allowed to set the "compat" option of the nvmem
framework, so you'll get the "eeprom" file, too.

Or am I overlooking something?


--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEqvsAAoJEBQN5MwUoCm2e2wP/1f5ACEtEcr321/9aU1QPidf
6F0/QA6T5nucAQGtG9FpZYHnWR7Ls0q9g1OPnbXeQ1+Q7ygEYtcnOBXRB6rnEO7H
JzkYg+CZuSAXVDYtDriUZrtLv7odZS8AT5Y2w4sIb/iHpsBBCLhqrhzcetWH3MaX
tKvYzcyk2q8fPt78pUxx27+EZjJ/rAKL0gAKSodirPdRigasf502z4G3FeoHNGcc
K/ddWdZuiyo///leDFATIm5z4Us8G7DR9F0asmGfqZSNwOCXdGiyFmWkGVANHk33
yMq59iXhX2jaolFdsN7KAHP0r9EycFSpad+HB0fgK10jh3zH31iPVtx529qoQjd+
Lz2dQFSMDiM/1nn16JUgcMAEVQ9O+NvHYYsN8GBQyHc0W0yXDI7P8GLcpCWXKA9P
LxA2DrFLlhy/sGrqysmtMdpG2jCgEFfcMxzU0bLGmTp86gzo//r8jWWB+KPnFvGs
cRhiB9KoNrxCg/DaXErCmxu/8E6w5vEZ5tmHc94naqcZhQY9xOpEihHrtiQsFSyE
Ntz08VgWqPgnFAXZvXv3yG27byZVaMhF39WQvmJTGV3tAbls1oXaSVymOeg2Kl5H
Z0g335IEclhIxD7aZY2GAG0AY0v7gAazHoLjGLAizkRTdN6ZF+Ij+C/9Mrxwkau5
9FkypvyjejkxAFQ5evRM
=d7bS
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--

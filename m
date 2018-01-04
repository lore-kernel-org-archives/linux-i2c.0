From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: gpio: Enable working over slow can_sleep GPIOs
Date: Thu, 4 Jan 2018 01:03:47 +0100
Message-ID: <20180104000347.vmkedndw4tygdqfl@ninjato>
References: <f105ae7f6b9ae9f5a26ecdac8d71c55dfedfe688.1513979394.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hz6wrq34habvlvzy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48417 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeADADt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 3 Jan 2018 19:03:49 -0500
Content-Disposition: inline
In-Reply-To: <f105ae7f6b9ae9f5a26ecdac8d71c55dfedfe688.1513979394.git.jan.kundrat@cesnet.cz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan =?utf-8?Q?Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Cc: linux-i2c@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>


--hz6wrq34habvlvzy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2017 at 10:47:16PM +0100, Jan Kundr=C3=A1t wrote:
> "Slow" GPIOs (usually those connected over an SPI or an I2C bus) are,
> well, slow in their operation. It is generally a good idea to avoid
> using them for time-critical operation, but sometimes the hardware just
> sucks, and the software has to cope. In addition to that, the I2C bus
> itself does not actually define any strict timing limits; the bus is
> free to go all the way down to DC. The timeouts (and therefore the
> slowest acceptable frequency) are present only in SMBus.
>=20
> The `can_sleep` is IMHO a wrong concept to use here. My SPI-to-quad-UART
> chip (MAX14830) is connected via a 26MHz SPI bus, and it happily drives
> SCL at 200kHz (5=C2=B5s pulses) during my benchmarks. That's faster than =
the
> maximal allowed speed of the traditional I2C.
>=20
> The previous version of this code did not really block operation over
> slow GPIO pins, anyway. Instead, it just resorted to printing a warning
> with a backtrace each time a GPIO pin was accessed, thereby slowing
> things down even more.
>=20
> Finally, it's not just me. A similar patch was originally submitted in
> 2015 [1].
>=20
> [1] https://patchwork.ozlabs.org/patch/450956/
>=20
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

Applied to for-next, thanks!


--hz6wrq34habvlvzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpNb2MACgkQFA3kzBSg
KbZCmg/7B0U+rPCbmUq9OStVSl2xKBwj80SEJ/wetdoG9xYWZnjjb/+1Yao/5g+H
/cWdT5u1GV/zUTacyQn1japoAPCJSbx1DjLRks8ujGwJbg2i90xVOsbAzQYtxr6n
LSemvXuKShoAWk8b/+JdsDRCPeKazXJNVhYQNQ+dr74/uqlK7jlmvKXlnsTjNkSJ
MrUv3Ule4tzVn2zeu4TCJ5c9ttb3uJzwx9G5+W8BXBCn/+D6wTEtuuUBU90ZKB1M
/hxPYjL3oXveplENKWsa+WLhlAE1s5S/SmOYkz8o42h+ODiBihJyO+hZtvmplNSy
nE8sgs2q2l7J/Mvyq1Ry2MeAKYlkcFas2EoCF6MFrlnUto97KMAYP2XiNQpOHmzi
CP8c1K+f015x0lLO0dL1JxXcrMFa8YbrOmjhd27TQ2cgIzTFlnLH2yvwY17zwMfP
hQchH9M8MOpPphoR8rrMfhfyifxlizPUgP7IMjPFy1P47PfBk36LqjfJXgd7Wk43
dKT1XRuNhbnGADfcjSSrOUHCiXgAIaKkqM1Ij5M7y59SUq/TQlJ6r9xoberAX26I
xiM4L7rWHxxMqPlTQz+U6V5+CxBU1q57fNfrK7RyMvSZ4vidUC7vJWKWet+GU7nt
o/bO/4DpND83/cbndWveF3Pf36s/St3Yon54xIEuC+tMJxj0cdk=
=ArDW
-----END PGP SIGNATURE-----

--hz6wrq34habvlvzy--

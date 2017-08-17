From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c-cht-wc: Ack read irqs after reading the data
 register
Date: Thu, 17 Aug 2017 18:16:16 +0200
Message-ID: <20170817161616.enyzqjy7yl3xqgsg@ninjato>
References: <20170814201726.21045-1-hdegoede@redhat.com>
 <20170814201726.21045-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lnyzrdc5ofggqmkr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60360 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbdHQQQR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 12:16:17 -0400
Content-Disposition: inline
In-Reply-To: <20170814201726.21045-3-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--lnyzrdc5ofggqmkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 10:17:25PM +0200, Hans de Goede wrote:
> Testing has shown that writing 1 to clear the read-complete irq does
> not work until the data register has been read first.
>=20
> This commit fixes the driver to read the data register first, halving the
> amount of interrupts in most cases since we mostly read on this i2c bus.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-next, thanks!


--lnyzrdc5ofggqmkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVwU8ACgkQFA3kzBSg
KbZTlA/9EUgxu5Dt2Jjl8Z85dt6nsww0JlKPGqF9QA+jyPJOdxq6z8xGlIqOCoiu
27wmNZ03ptExw69X00zXImeV/kkYIDjf0ofsNx8D/m7kaVzczH160aCV+WtaYuF0
lvMXK9YtJizY9zTp4fGRsYnVm5eXd5MeCe5gcKBGe75e6ynHwe6jamuB0Ea4mnhY
/ecBI1ncWW6nTDPGG1yTfOIqhqE742JFxIwwfNWtaT5XMbAlIjMC9CJ0PLfL888u
ONtGrNgsVmqgDIL3fn1me/MG67PzS5pCujHR30NJcYiJP2V70bO7B7L4zbg04FTY
y+5SFRXNmkA2kK8mhlaQBvTT0/Rc/r/j9DyohUQYktQW25UevskJLrrLqwihUjei
uXXA0/6kHougm3BvDQkMAYLaIOIPS81+1D/oFE50khO1cWSL45tfEI8RkRZ1GXx2
ytRIURkpSP1ca1HmrNIgbNxQ7fCldHnTFODPd9CUPJsuiTRnP5eYFgIiGQRmRw8+
/+ZXQ8wXzZDQpMUfAWhXtaLtHLHgxUVq4zjQknFfA+r7ulVAEeQMyXLwJN+92XIY
0ffD8Ng6e/UGQdiVdgtFd91ZrXExFANuczbcXY3HqatssvByDEQwO82jBkASpdKd
U6SNIKxAMUiu5zruGFXboTMwD4nXggY8MPypA8TC/enMi7WQYs4=
=sz6Z
-----END PGP SIGNATURE-----

--lnyzrdc5ofggqmkr--

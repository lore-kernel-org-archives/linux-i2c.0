From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 01/40] i2c: qup: Move bus frequency definitions to
 i2c.h
Date: Tue, 25 Feb 2020 11:22:33 +0100
Message-ID: <20200225102233.GA3677@ninjato>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36756 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgBYKWj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 05:22:39 -0500
Content-Disposition: inline
In-Reply-To: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 24, 2020 at 05:14:51PM +0200, Andy Shevchenko wrote:
> Move bus frequency definitions to i2c.h for wider use.
>=20
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A cover letter would have been nice so we could discuss the general
appraoch there. And to read more about the motivation.

> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -39,6 +39,13 @@ enum i2c_slave_event;
>  typedef int (*i2c_slave_cb_t)(struct i2c_client *client,
>  			      enum i2c_slave_event event, u8 *val);
> =20
> +#define HZ_PER_KHZ			1000

Unlike Jarkko, I think such macros help readability when calculating
frequencies within drivers. However, they shouldn't be local to I2C if
we agree on them. They should be available Linux-wide. There are some
other (few) local implementations already.

> +
> +/* I2C Frequency Modes */
> +#define I2C_STANDARD_MODE_FREQ		(100 * HZ_PER_KHZ)
> +#define I2C_FAST_MODE_FREQ		(400 * HZ_PER_KHZ)
> +#define I2C_FAST_MODE_PLUS_FREQ		(1000 * HZ_PER_KHZ)

For such a header, I'd prefer the plain number, though. There will be
enough review to make sure we get it right ;) Furthermore, I'd prefer to
have 'MAX' in there, e.g. I2C_MAX_STANDARD_MODE_FREQ etc. Just to make
clear that I2C can have other bus speeds as well.

And finally, I'd think all driver patches should be squashed into one,
and all core ones into one etc. Or?

Thanks,

   Wolfram


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5U9WUACgkQFA3kzBSg
KbZUVA/9GtyDtsHjyN7s71CWfWYSm6btgldTq/79Su7Cr4kkXIjvV0TSsAgNS8/R
/RjkQycxilvOr7fGYoBzAK95TGHGKNgbCDInltkHStBgtoRIoUYWvVBKb9pA7aZD
HS59qIEPFSX37rBfCRT4bUMN1t0zni9ejyMKNR9KdOWamcoZXTd/sEQ8wI3cR0GH
6kvIrUPIXSK7HaG17jCzk+0RKQM2CwqgErFpUejDjvQHJR/Gi+pBRLWnLF0jxV75
fD5VTiMo8wcgLli7U00FVp/IiYAoJ8qMtu6UNd4GiyeueJVcuANw0i8gUyS8vk/P
kBO25YiKmmbB4QS7RoxKs6VuWgfMG89Rfj+W9dD8dL3lOxA7kL7Y8YKNolivAwKN
/8eqtf4ASUag/0mqDUjU2zK8LRCiZbdFh1LnJA2L7AY4j3Sk7RUSbY6UnO1y54ne
lgvNechATSAuXOsaEihD3BVBZwwDUXZMBKP51zs7Qa9iLxDl29+mT2092rhbCgXi
Ur6dbUFmL3QJmzw/vtIbaIG+QqJSbH4fx1zJgGCcF9IN4UPG7X08bQ9xbekKradm
xys7luJQHaNudZilUqKVWTZrOgafmcVgvIpo8bFxmgvpgebYz0Kbwirsc8zNSR0z
z3ti1+mFCnEe+e/17bRU1yebFMqNLGI89zbNGY31n7L/3+hCjZs=
=4bYb
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

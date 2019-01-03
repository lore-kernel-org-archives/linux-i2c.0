From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: dev: prevent adapter retries being set as minus
 value
Date: Thu, 3 Jan 2019 20:30:06 +0100
Message-ID: <20190103193006.2ekn4ugibm73nfcy@ninjato>
References: <1545384726-12463-1-git-send-email-yizeng@asrmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqvrkkyrqslvon2x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545384726-12463-1-git-send-email-yizeng@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yi Zeng <yizeng@asrmicro.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--fqvrkkyrqslvon2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yi Zeng,

On Fri, Dec 21, 2018 at 05:32:06PM +0800, Yi Zeng wrote:
> If set adapter->retries to minus value from user space via ioctl,
> will make __i2c_transfer and __i2c_smbus_xfer jump the calling to
> adapter->algo->master_xfer and adapter->algo->smbus_xfer that
> registered by the underlying bus drivers, and return value 0 to
> all the callers. The bus driver will never be accessed anymore by
> all users, besides, the users may still get successful return value
> with no any error or information log print out.

Thanks! The issue you observed is correct. It also applies to
I2C_TIMEOUT. Would you mind fixing it there as well?

> Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
> ---
>  drivers/i2c/i2c-dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 1aca742..c349f58 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -470,6 +470,14 @@ static long i2cdev_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
>  					  data_arg.data);
>  	}
>  	case I2C_RETRIES:
> +		/*
> +		 * The adapter->retries is defined as int type, and as
> +		 * the upper limit for times of i2c transfer retry when
> +		 * get -EAGAIN, it should not be set as minus value.
> +		 */

I usually like comments explaining the situiation. However, here I think
it is pretty clear that the code does just sanity checks. So, I think we
can drop it.

> +		if ((int)arg < 0)
> +			return -EINVAL;

Minor nit: I'd think this is a little more readable

	if (arg > INT_MAX)
			return -EINVAL

But I have no strong opinion here.

Kind regards,

   Wolfram


--fqvrkkyrqslvon2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuYroACgkQFA3kzBSg
KbaNNRAAqRMn4n+no9XQWb8yZWMPEex6lmgx1JuvggwO45QXv9xBBNLYpcjJJp3o
YLRMAtV5NV7FTaJcHhBSXujOYp46aXS1a2Z8haQYSeHd6HhAmoWu5EcXLvpa+QIs
30inN579nScs98BYhbKUuFE/gDpdBixku++tfAT+/bOZNL5sYW4ZYG2cV+7EFows
Ak2n89L+ZGVv9rpt9m3jszdiAZukDuGzPLv6EtNIFDOAqVnGxUsyrR3M2DrBN6Lq
pxu96LWy5X5AfGeQiRYSpt+E+1z09OmaJd7DU1EzK4t8SfHtfexBdnAYrbz/dvDo
nJryQpFB1AznSoVuO3xMlm24qrKKgmapHviJVJ3AvmtACPuGPER0ae6czofyBS1x
nJrL2Xnp0MS2vrLqkI71i6MD/tWJUukdKM4umwk4dYXGWr9jVysf097v7BrOzJvT
lhy5xxf0sgCOGp8uWJP/P/Q/DzggkY7x+EO+25Poqgkjw8FN1QKFzxMdlUdyBiyK
YjT1DDqn/7MQAE3fYCHj/8HDdZDiN1xIeZcpaTbcarlqMb3qi87VsGIdsPwVMZAV
lY5n9LKvgBYsapE7V5tlSE18/hukrRVpnfTd65sfkeW6eWrM7Vp++d7MgqisJFf/
OLXYw72vMw3IH5Rcz4ro9n7MYk5Rpu84L/1sP8cCeYU7Ab0nHAM=
=1e5m
-----END PGP SIGNATURE-----

--fqvrkkyrqslvon2x--

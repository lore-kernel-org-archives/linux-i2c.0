From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/3] i2c/busses/i2c-icy: Add LTC2990 present on 2019
 board revision
Date: Fri, 16 Aug 2019 13:51:12 +0200
Message-ID: <20190816115112.GA3507@kunai>
References: <20190815125802.16500-1-max@enpas.org>
 <20190815125802.16500-3-max@enpas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190815125802.16500-3-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (IS_ERR(new_fwnode))
> +		dev_info(&z->dev, "Failed to create fwnode for LTC2990, error: %ld\n",
> +			 PTR_ERR(new_fwnode));
> +	else {

Braces for both blocks. Did you run checkpatch?

> +		/*
> +		 * Store the fwnode so we can destroy it on .remove().
> +		 * Only store it on success, as fwnode_remove_software_node()
> +		 * is NULL safe, but not PTR_ERR safe.
> +		 */
> +		i2c->ltc2990_fwnode = new_fwnode;
> +		ltc2990_info.fwnode = new_fwnode;
> +
> +		i2c->ltc2990_client =
> +			i2c_new_probed_device(&i2c->adapter,
> +					      &ltc2990_info,
> +					      icy_ltc2990_addresses,
> +					      NULL);

i2c_new_device (or better, the new i2c_new_client_device) should be
sufficient, or? You only have one potential address.


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1WmKwACgkQFA3kzBSg
KbZMmQ//ZBq1brXRRfdkskpVP+8JjmV0KgajQaYkzpD1kdopZeDaTY8/i9VwS0cJ
l73N6VXurxXBHHmjN/IBJ8WZnlJfDnJ5dTzYbnO2jkkC9aj3bgtD0UL6V89RMHva
TeSu151LD9ggFjveggTZ82DTRPwEwQr7v8Q2R6fpr5Wv2odkBHinUQsFZ8ny/fWV
WmGEdtOfXhhKsYgf6l+zT/ua3nlq4pobJiy9zT+7IiWpiWiwFOtUX5ZCFwWcPjBT
i0PWm+S3GSCzAA687e6AqJ7ylOeCXrQGP9fefe8OfG9OP2ubuP8vBIOrb1ffdniI
mVS2xxBqGAWusjxQe47O03A5RcEpAcGnd6WRtpS94C5aX+z48dxe+ZncGVwEIABI
NXRmbD3LdCyvpev3YC0Oq8TNvc0ikXpbK68KRdcxYVTDIBdHT5w8AQmcPjfpPEHF
4X6Fyipyc7TvlccaE95xIZjqqa0NQOVjdSJwgez+cTYnvkDoTIHR0f8iS/7fP3+J
tqaaXtupGDa+jBCBXeb45gWEHE9dWuTgJLbiYPhif2f+HSuJHfumi+oirBF7828c
uX0fjR2PKDWbLF9//4EyQTAlKGRVTRMe6CL5F3wr6inQjZd7sTjD6DyagMBFf5HQ
aQCiwWFAAlUKhDpDtjq6GEmGVaAJtcrb0365OZHKlO35nZYI11A=
=Sdz1
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] i2c: mux: only print failure message on error
Date: Mon, 15 May 2017 07:53:22 +0300
Message-ID: <20170515045322.GX3616@mtr-leonro.local>
References: <1494780073-13713-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HqPpMaT+a6TeY/Q4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32810 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEOEx0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 15 May 2017 00:53:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id w50so13433072wrc.0
        for <linux-i2c@vger.kernel.org>; Sun, 14 May 2017 21:53:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494780073-13713-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org


--HqPpMaT+a6TeY/Q4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 14, 2017 at 06:41:13PM +0200, Peter Rosin wrote:
> As is, a failure message is printed unconditionally, which is confusing.
> And noisy.
>
> Fixes: 8d4d159f25a7 ("i2c: mux: provide more info on failure in i2c_mux_add_adapter")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/i2c-mux.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 26f7237558ba..ccf2ce1836c8 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -395,18 +395,22 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	if (force_nr) {
>  		priv->adap.nr = force_nr;
>  		ret = i2c_add_numbered_adapter(&priv->adap);
> -		dev_err(&parent->dev,
> -			"failed to add mux-adapter %u as bus %u (error=%d)\n",
> -			chan_id, force_nr, ret);
> +		if (ret < 0) {
> +			dev_err(&parent->dev,
> +				"failed to add mux-adapter %u as bus %u (error=%d)\n",
> +				chan_id, force_nr, ret);
> +			kfree(priv);
> +			return ret;
> +		}
>  	} else {
>  		ret = i2c_add_adapter(&priv->adap);
> -		dev_err(&parent->dev,
> -			"failed to add mux-adapter %u (error=%d)\n",
> -			chan_id, ret);
> -	}
> -	if (ret < 0) {
> -		kfree(priv);
> -		return ret;
> +		if (ret < 0) {
> +			dev_err(&parent->dev,
> +				"failed to add mux-adapter %u (error=%d)\n",
> +				chan_id, ret);
> +			kfree(priv);
> +			return ret;

It is better to add goto label, this will give one place for kfree->return code.

Thanks

> +		}
>  	}
>
>  	WARN(sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
> --
> 2.1.4
>

--HqPpMaT+a6TeY/Q4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlkZNEIACgkQ5GN7iDZy
WKdeXhAAox/X5jcW5bZw5vj29i0pRuCkXjv7/5ZK6bF6JZWnSaCF4wEzQU4nfLAU
pPJdl0chSRR+A36GLC6jhLgF2h4SnpWCw9ztDtp3owkSFsTGGi1Uf1qhrpKmjk/x
x09MyKLHfPefO7WZIU70OFEHN2eeR340dVpNrgbRzIJj0lE3QyFLjJ6BEBLqrA5l
kXv3OVDsSBiGpQd5jM2GqqnuIV4bmtOAwRJXAKf65Dw/PQPoonhzTVR0X5uBmKw8
G0x4aHs/ndIgWTwRJ+/0HU7ag+1OjOEvH/echH/RPkd7P5xFe57DGR3LlyLs+PDH
R57YwwC2INgM5rcMmusEHaKYkArbYYnnFXJtbzaDpfKVURi4r+MvR8BGbss5fXAO
fyn0az4eUSUaxVMT6gTPZe3WYcToUjwQoSeYjpfC2yn3arZM9niwZOKU+YvJzfz/
Zy3lxT0XhzFwowoEkifvKpAkeORS8hJIKw/vCrz7NReWzjUeYKWd2FYaUr8YNTiS
lr2cGTNNnMb0KJwlZDgEKJnP6CYUH+9sS4ohgkK1Ab6nWlDhTkbKUc/LJqLkYTOW
98X1it77+WTrVyIJWqJ/yrsPIWRFNdJUKRzco/T0AFtk8bVVChFi8FxhG8cCSviN
6DOOkNVhHcfHWtDQ2aB4j+nd4A9v3XTPzHQccTh8kw6yympE2HM=
=xPLV
-----END PGP SIGNATURE-----

--HqPpMaT+a6TeY/Q4--

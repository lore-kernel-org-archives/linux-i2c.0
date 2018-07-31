From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xlp9xx: Fix case where SSIF read transaction
 completes early
Date: Tue, 31 Jul 2018 23:05:14 +0200
Message-ID: <20180731210513.izqbzpvvqq5lq4uh@ninjato>
References: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nt3kfhluwrtxt5wh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jglauber@cavium.com
List-Id: linux-i2c@vger.kernel.org


--nt3kfhluwrtxt5wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -191,28 +191,30 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
>  	if (priv->len_recv) {
>  		/* read length byte */
>  		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
> +		len--;

I don't know the HW and assume the above line is correct because of
merging two interrupts into one. However, the line looks a bit stray,
and I wonder if we shouldn't add a comment somewhere explaining the
situation similar to the second paragraph of the commit message?


--nt3kfhluwrtxt5wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltgzwUACgkQFA3kzBSg
Kbbmig/+JiAwv3RFIsTmwQQXLznqylgQBPxO6YN4ojCac7DTAhvObGUAMRNeD1AV
3WGPZn54UFkbgiBWFcLqzea6HZEQJXcYLjbk1OrKmi1A6MQXgVEKcGos0HZRco6p
B9HEb1+APeBN/VMCDFDerup5agLOmwg+5h2qGxjL6sWy0N9jBOIrhvdA+c5ML9rp
9DVVehQ19l5r9Ui8p4fQww2A6F49VdGf+5oyaJLWTNcvhzc/bnt0Utk/7kD2VR1Q
S1NlFXzG7WE2yTNYiUjDkt8d/V4x9oMfmheD7UaLZeJCp0Z9vWSpG/opuX5e1PPK
P4wnu/EEy/Ioc3u07tWh8+QT8xmmkJaM4T8ot6MazADPr5J+XhRC0yKWjyiMrvoC
CeV1gqSJbRcidhD5ix4KCtBs+7QWABNQ9F6SAAQzCbd6YVHmfHfKajRTSh7nkgfI
cIUoOc1RtOSA+r1SXpOtbWW1/1LKb8ao2wUG77TviuqunkBd0n86SqOUdRoGq6vi
RmXjgv0S2OwZU4R4T+gfBBjzkJWqaPZJq8XxyLpkN7FRGHRa0he7lnSeid/r3JRO
T+Ychssq/c2/G2ztZRz31ymPw+W7Mclqy2s65t+1wsekthe07t4P8+ftPiqV79xD
lYA3SKqlWIe/V/Zcvoh0rGRAdOEUJCzJHSX8HGYS2Sfz9G1WbZY=
=79Yu
-----END PGP SIGNATURE-----

--nt3kfhluwrtxt5wh--

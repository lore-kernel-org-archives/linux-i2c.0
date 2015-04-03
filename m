From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] drivers/i2c/i2c-core.c: Fix sparse warning
Date: Fri, 3 Apr 2015 20:28:23 +0200
Message-ID: <20150403182822.GC1298@katana>
References: <20150403025338.GA18595@Caladan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150403025338.GA18595@Caladan>
Sender: linux-kernel-owner@vger.kernel.org
To: Nickolaus Woodruff <nickolauswoodruff@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	u8 addr = (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
> +	u8 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) != 0);

I prefer !! as an idiom for "bit to bool".

Thanks,

   Wolfram


--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHtvGAAoJEBQN5MwUoCm21FcQALWpvJaHemccxM8O0RuuOpK1
lV61Pj3E42v8Q6Kt5l6np9xi6YU67gAqD+ky+mwyh4j0uoVufFeblbe1buda+ZP1
bY1VcvUZzYW4V63JEVCzyHvnp1gVpt/ChzJkolPyry/uwJNWYGy2q3OLu/4gtQ1n
GONrzS1Wk0J9SczeYiqtKuziBjbk9SRGLEwySfx2GrKX7WsH4+rnh8QflGycOME5
Cn3UIylu4dsErLvrfDLnw1BKgvDN40hkbxbEVpWXvxBDXNBzblljetAof5RFlmEd
EezkYE9VtF4btwy8UAqcI1s+UHUvJoj87tBP6N2k6zhfsbVqx+xagHe6+7dPA3YI
cc1mKdJ8kfIT7ifkaVhA672QJZF/X/V72Iz2SXSHAL6+681SZnB6OvnPUnzj7zUZ
nRpUuab3Aq0/KwZ+U0lT5INsGizRkEnfR2LJKSRdhTAgL2H/n9i2uoirHg//36mE
pHqyfptz0M2EMeMiV6Xhxq2I7TQ9ERu0NiZBO/Pe/6AoJU7YAgM3THJ6kKZElQYt
9o37ctDdoMixito1ZH2+jF61UYQhCbOB4dyozur5dr/xfkyrTR8LQg2wnEcciWjQ
/war04r+zk5YY6pKzHJb87qlq5E806WrGKMYGS4ynvZ1m4cXs/WRU8sRdu3Ig749
xbIWeA8nCKhN0vbnffI/
=g8cg
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

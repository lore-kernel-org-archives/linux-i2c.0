From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Deassert reset in probe
Date: Fri, 13 Oct 2017 20:44:26 +0200
Message-ID: <20171013184426.5xfq4jhvvz5jzwlz@ninjato>
References: <20171010044828.20913-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bnokx6tgqs67gg6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171010044828.20913-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4bnokx6tgqs67gg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/reset.h>

Please keep the sorting. Rest looks good.


--4bnokx6tgqs67gg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhCYkACgkQFA3kzBSg
KbYj+xAAr80EbA4Mc+IZjVbYzVpcCSEIlRdccoDecAB0+eRxx2hpPaXuWZzG3ghZ
8PaO4kgvR50X7/qexbCPrT2JshLfTCNGj47B4o0CVQ4G0AfWIrJlQ25VWP4YWY4f
GKqRS/fpxCvX+xFFtiFhdfbybWiMG5imIGLEJO/jMnPZgMKtUZCsWfDj68v6vf2F
Pt3FsmH5Gl7SLUj6VZ64rzKDd8QDYVH2RhTFcwW05+cRiiIVuNU+LQjLs6itUIGR
ZaYv0DKNhkYcI6ILPihEfwn1UNzVpZYxvFPxTiiBgDIG2fPwCEc8cBKW76PLYcYx
VRvrKcOn9e5BOD5+/gb34iK8j//Cw3D6/mnCbtryX1QAhLYl5m6oZER/HVa1kfz6
n2FyJ533rhYv9yeVH0hzqlxvf2dO1Euho1GfOV4Y3ZIQic/kykjblCvZ76s8RJEu
/ajS9PYswKnNcwNIoinS/MhY3edhrdZcG6hlPlsQV5bpeLLc3wfk86FRfdOt8U/G
wky83+1RCh0Y6dysUVCKIzrP3J2jZCb9FuJocwZQPK1RSe8vI/WQHBnKXEb8qD4H
7FxmoWFW1CaQ73y/ANpUXyTrSn9++RTMK4IzpmhLkmWFuPIWvUqnhnyPFRs3vfIj
1GvKCZxiZHjpQzOUYdyIWYGQ6CxX8JWlsSCmsZnIZsNq3JFEdFQ=
=+rCM
-----END PGP SIGNATURE-----

--4bnokx6tgqs67gg6--

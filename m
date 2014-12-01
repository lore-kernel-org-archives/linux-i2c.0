From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: pca9541: add return value check on register
 writes
Date: Mon, 1 Dec 2014 18:33:27 +0100
Message-ID: <20141201173327.GE3212@katana>
References: <547A4C9B.5080705@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547A4C9B.5080705-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> -#define PCA9541_ISTAT_INTIN    (1 << 0)
> +#define PCA9541_ISTAT_INTIN        (1 << 0)
>  #define PCA9541_ISTAT_BUSINIT    (1 << 1)
> -#define PCA9541_ISTAT_BUSOK    (1 << 2)
> +#define PCA9541_ISTAT_BUSOK        (1 << 2)

What's with this whitespace noise? Please fix and resend.

Make sure you read Documentation/email-clients.txt about GMail and send
some test mails to yourself only. When you are sure everything is OK,
then send out.


--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfKZnAAoJEBQN5MwUoCm21gIP+wdiXHIeWhbOr4QSF06HZU2K
HTN3TL+w4QTvxImCUYqiG4QnyVfroAEmI571B3KDleW0PWMuygLhvKkitIgL1pYn
Y1ymhrZFEvje3kdjDh8v77i68LVnxWsvAD1cp8IlF/ve96tl2NoV/x2GAd7pP8Yf
J0BDOIs9uRb5TmZ/b+/0ULqUw2fyGdq+SF7+LhnqM7/an+RSwSN41mZAa3Otc9EZ
BHtKvtRS6RU7x19h1usua4gOgCoc8bfcer7h7T3r4KRYFAfrcREWlfYnRoTVKrH6
qjHjcpGeVkkpf0YwgKUoWl4VoX+eeodQiqjBwMY1kekrSYj6QkVeyPE7RYQsDwKi
XnAvxsZIoIWFW+KNhcb8fTe9uTFMreOJ85rchNDIYAsZpHszJSyHE/4tJ4dWxFiC
bTthVZeusuRPVOMX0XYGOSmB6/IizIZ6GVIP5jaAfAWSX5nBOmBGLkDks+880Q7J
g2hDHamRZqHNQJNjRiiQD7tHNqmzn4CSTGcLqo1GCMPOa01vrYxHmR73l727/SmD
EHmtSJAurbaJQtt6Zkg1BY/gWXG0RQA0+M55VYnXOt5hv73+ZuAT9sFXO9uBEvxr
/CQYQx6IRNlpVA/kCKnP0gGDaFbSHL+qD1H3roaL+U3JwUyqwCjULrsDjTXx2U/K
gCohYTjZtVrc3/jLiuU5
=wDV1
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

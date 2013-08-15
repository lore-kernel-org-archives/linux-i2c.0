From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Thu, 15 Aug 2013 14:13:40 +0200
Message-ID: <20130815121340.GB17155@katana>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376039158-1896-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if ((msg->flags & I2C_M_RD) == 0) {
> +		for (i = 0; i < 4 && i < msg->len; i++)
> +			data_reg_lo = data_reg_lo |
> +					(msg->buf[i] << ((i & 0x3) * 8));
> +
> +		for (i = 4; i < 8 && i < msg->len; i++)
> +			data_reg_hi = data_reg_hi |
> +					(msg->buf[i] << ((i & 0x3) * 8));

Same comment as in the last version: What about be32_to_cpu and friends
instead of the loops (here and later)?


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDMX0AAoJEBQN5MwUoCm2bDMQAIEIC47HsTU2net7t8EWhOx/
7SVsAwNrmNUWNvgn29A8wM+AWIDmp6sZLEoRD70zRQQq4MTtiANQ/shsp5CCRik2
KyOiCG16e06/j0wE9QrQNz+97rOFqUMDl8tJbGkDaz3/BWHF0uTh12Skkj37g9TC
FWlIo9QgFI/r8HApcGjuFqiiw3El6SqGvPoLkBnzHoJ1dj1TiLG4Y+4QCkxrUOFc
PofWqYA+0wiXCnb2FZmF5NJwKPA//txVpQd976TrRpifZ4AJNXREYrQu/fiEdSBr
DyNhiEvbDvzuP2MRD7Uk8Uh7CGeOzUynGnWKDV2mxTY0TX3SkShEze6lBoC7Ekc0
pnfBW0ECCMLfLvJeFwrXl7UtI2z7ehCxLE5/43sCNCQ80BOcQ0cZlr4z84dBy4Dk
/LYO+VPoBNF87folXzp9CmGgQG0jqFaRgVh2VMEXbpZBwT6Nm4doJhQ2leSTxSwm
JWHxeskO7dn9rxGeXaScClt44ClS7mudj8CJ05Jv/Ymjs3DNMUruBWQDEBLXvRw5
CDGWSBcmskgf97f+TYnxQy2G6kR+hi3gkaSSHCZwRt9As6c71qQeozbWehVoZmkm
Q/ImCBzEx2usyf7jIYW7vxFYOexwF6P0BVCzsexT8mAUhy12/bAUR1xrXPUlo44+
jzQlu7jItYTFH7Byc2lb
=7oqp
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

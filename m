From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [patch] i2c: dev: use after free in detach
Date: Sat, 28 May 2016 10:57:20 +0200
Message-ID: <20160528085719.GA1625@katana>
References: <20160528050146.GC4107@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52210 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbcE1I53 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 28 May 2016 04:57:29 -0400
Content-Disposition: inline
In-Reply-To: <20160528050146.GC4107@mwanda>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Erico Nunes <erico.nunes@datacom.ind.br>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 28, 2016 at 08:01:46AM +0300, Dan Carpenter wrote:
> The call to return_i2c_dev() frees "i2c_dev" so there is a use after
> free when we call cdev_del(&i2c_dev->cdev).
>=20
> Fixes: d6760b14d4a1 ('i2c: dev: switch from register_chrdev to cdev API')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks! I'll revert the offending commit nonetheless because I still
want to understand first why it slipped through my test system. And then
we will try again with a better patch.

>=20
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 2562a45..3bf4f0d 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -592,9 +592,9 @@ static int i2cdev_detach_adapter(struct device *dev, =
void *dummy)
>  	if (!i2c_dev) /* attach_adapter must have failed */
>  		return 0;
> =20
> +	cdev_del(&i2c_dev->cdev);
>  	return_i2c_dev(i2c_dev);
>  	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
> -	cdev_del(&i2c_dev->cdev);
> =20
>  	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
>  	return 0;

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSV1vAAoJEBQN5MwUoCm2Q0wQAJ5Nxapj00lJJMeAtgCO6TyZ
MbvM2Uz0j4BG7myjAL/gkgsmgS3nib2CysCehqgwzx1kQzDvG2eEc57OAYD1S/pm
jx7DB5EEdZu2BpjA4mr927wHd4m9RBit4p1jMV+SCTsDWPvyDVKGJaOn0a/iYUBZ
WIq4xEb4eULgulKzncIJtB3APCdPa37uBB68hMTE7GMszLtigbvMPB9o8LnsaBum
gZa40N3EAnO/3hFaquJrDJRuv5yg+FWsEfcsKBYP3BRvY9eFEve7LDro7V4ZV4eJ
K8u2y9Z7QlfdpPa69BVhV5fUKPZYQipervrptp+dyYX6EU2ezh+i1Gkdw9NxAYj4
3EjzH38iFERzLAQ+s+BazxE/Ik0YbBXk6XYQg92MlW/WmK/ZgI4QUD5R0c0+uLk2
UK9rjYTwE6GIjo2EkK0wFQkk1OGCWkqYl3wquxd8o2/sCUntVkY07Jp5USDmo+XV
cq2RXk//RRFUXsa4aNBbIFazTeg0nAfgLRFA/MBWBDOtE7jOjeqQAe7k3oHrPr+B
EuKsSLVJoqsT0y4vWzNuWlIYOyC0CVIJBeKU7Gysp03jniL0eV82ihPWZGajVWEN
KdWQfSR/CLG1swC7iTeJMnUhdfXZl/DMf08nRuOllxV2JJjpFTox5jIPa/EYFtig
WUNpt0NyNKcQdQkSOkNO
=fSED
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

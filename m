From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: tegra: drop duplicated code for assigning algo
Date: Fri, 23 Oct 2015 22:51:15 +0200
Message-ID: <20151023205115.GJ1520@katana>
References: <1441595335-31672-1-git-send-email-21cnbao@gmail.com>
 <20151020154046.GJ5379@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHh0aNzodMFDTGdO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36864 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbbJWUvT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 16:51:19 -0400
Content-Disposition: inline
In-Reply-To: <20151020154046.GJ5379@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-i2c@vger.kernel.org, ldewangan@nvidia.com, Donglin Peng <pengdonglin137@163.com>


--wHh0aNzodMFDTGdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 05:40:46PM +0200, Wolfram Sang wrote:
> > @@ -825,7 +825,6 @@ static int tegra_i2c_probe(struct platform_device *=
pdev)
> >  	i2c_dev->adapter.class =3D I2C_CLASS_DEPRECATED;
> >  	strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
> >  		sizeof(i2c_dev->adapter.name));
> > -	i2c_dev->adapter.algo =3D &tegra_i2c_algo;
> >  	i2c_dev->adapter.dev.parent =3D &pdev->dev;
> >  	i2c_dev->adapter.nr =3D pdev->id;
> >  	i2c_dev->adapter.dev.of_node =3D pdev->dev.of_node;
>=20
> I think it would be more consistent to keep this one and move the quirk
> assignment also down here; then all adapter assignments are in one
> place.

Lucky you, I accidently pushed this out in my for-next ;)


--wHh0aNzodMFDTGdO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKp3DAAoJEBQN5MwUoCm2r6MQAKILzlumz0H5EO1MBWpOoa2k
sh3GfcjRnRSVgBzZoPsJmwarnrobiq6Uft0qDvIujfd2oAyNbwrNroB5yP407Cs3
9xeinpGuRLDqVsl5z8rfiM8hIsqrf0ovSK6AsjIpTvLy9ncgiOqX8VnOVZ99IV7g
F13pNwNY2a9kvu0ejkogb6MMNO/yIfRdmI3/bbhW/EUA0hWRI5dOP3R+gtCAeV0r
brgyFglgfzpZ7ISzq7A2ng9xHa4pA6KFy1u9XB8RuvsdzexqMo4yDMDi/L1iCyjo
vSjzQXKt/AIvG/9Ujb3WAt2fml67PltUX50ooeOU0mq4H9Z/8daG5QVwN9CqjaDs
zNEnj/eX2b7kRFeimUzI9X9+sq2BUzBPZRU+ns1swa2vH3/jZFy8MGqU9o/OKxnj
PrXwVgjZxdd1VO3taZ+SrPdte39NxUuj4BFRq9st9bEATVUqHTPyFbOy8Z/LJug1
fo3FphaaaLQETCS3ON1JeR4OwmPOPHfVDW8auNKp9Hc9L1nDrXw/2UzKjsD7xqmJ
jlya2sgptgM3mJTCeZ/khQYsscJ36wrO4omd4nGh4U6dbEkaBIxeuAbwmRivRUmt
3eJfYHzqpS5fbO8jBl7TSmxz490pIL/4gDz7kUIRuFYAUzlP5wPbkiq9xBTZMKAm
qsFeKiMo4Tt6rqbgog2f
=01lr
-----END PGP SIGNATURE-----

--wHh0aNzodMFDTGdO--

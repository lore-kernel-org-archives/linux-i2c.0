From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ARM: dts: mvebu: Introduce a new compatible
 string for mv64xxx-i2c
Date: Fri, 21 Jun 2013 17:03:23 +0200
Message-ID: <20130621150323.GA3450@katana>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-5-git-send-email-gregory.clement@free-electrons.com>
 <20130621140707.GO31667@titan.lakedaemon.net>
 <51C46001.30500@gmail.com>
 <20130621145629.GQ31667@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130621145629.GQ31667-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > from a quick check of the patch set (which you forgot to send to LKML)
> > I am wondering why you didn't update the of matches struct with the new
> > compatible for "marvell,mv78230-i2c"? This will save you from still
> > having "marvell,mv64xxx-i2c" as additional compatible to match device
> > and driver. With that the above should also be s/and/or/.
>=20
> agreed, good point.
>=20
> Gregory,
>=20
> I'm sending the last PRs for mvebu today.  I'll include this one with my
> suggestion and Sebastian's if you're ok with it.  That means you'll have
> to respin the series for the i2c folks.  Does that work for you?

No hurry, please. Most of the patches are 3.12 material anyhow, so we
can as well just wait until the I2C patches are okay and then update the
dts later.


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRxGs7AAoJEBQN5MwUoCm2ytYP/i++JCKwS+84VwPIYaar7RYT
3OQfVHKN6GoWBelO/yvGCOzbrt5tjLwX2jf6BQWqRyKV7p8vrQDtGTYQRXU8Ixao
F64iRETBAHU3QISg7Bdubp82jK8L8666gxp4YXElMr2Tiun4ByFOjWJdTTYetvgT
bDO7UQsIfyQ3OcH/i6WqEb2Q8Lhv3ZH8M7/2OStCuzhlIwZoW+R06Zng4Og4+I76
zLKjr/yamtwNiLxF8Jgy3Vgrxj5F0nv6UfsGKDRInHoqh1wwP9dCZsMfWapKOnat
gYcn1DdVgYk/N2cA5+z8BYQ3uhgTOFqsuQmfj5YzPPJzMHjcHt2+NoP5VhPv5FIC
1jF17TzkgrGG8auXN79tPvf+RETYYHaYKMW0iq99c1CwGndUDbwkoPR6pZIYZBCM
lylwupCECgnZ2w4mkiRwW4Q91xKKSVKKeRsz8NTA/Y0bh5CZYIrA0L0lQnIqblW9
R17x91oxTXa0JZGzYHucSVGb2NJX0jJC2sZMlruL6uWF3N5dRqgSjjKRY9FE2NpN
0j0u3u3rsEz5QPOR+D3oTNJp0zBKs7QG+Hdw1JiC7jatP1ft16zhSHQm7ooF8ptd
p+sCrJZEulK3bohqNrEnCfBrruHNZnkSaG9jqToxEBl1i4bO+bhT6AqoJ5Uxy5Ud
feDsh9qkNkaJLIPdJeDj
=HZLa
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

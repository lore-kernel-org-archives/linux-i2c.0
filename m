From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7] ARM: dts: mvebu: Introduce a new compatible string
 for mv64xxx-i2c
Date: Fri, 23 Aug 2013 10:09:16 +0200
Message-ID: <20130823080916.GA3035@katana>
References: <1377243174-15877-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377243174-15877-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 09:32:54AM +0200, Gregory CLEMENT wrote:
> The mv64xxx-i2c embedded in the Armada XP have a new feature to
> offload i2c transaction. This new version of the IP come also with
> some errata. This lead to the introduction to a another compatible
> string.
>=20
> This commit updates the Device Tree binding documentation accordingly.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Applied to for-next, thanks!


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSFxisAAoJEBQN5MwUoCm2xaEP/1xBhZUGvOAs3S8943CBs6qH
W8kdaBEbeeFB717jBZxeuZjB+UYI2LGakVqqu/l1z6ebOvNRYEX8GYjcP9gWgJx1
QQh+mcaPV25jWnDMzDNkMv7PcLXOU/dFEd81cGNjq8PG7I3MYXWUNVJ0BCDG835I
+ugqSK+wEIojnsnZRzq4B3NTQXXS3Ma6uKKUgtaZMeCs72RNC0s7YKWG3tGVmadQ
atUtslLtXSfja0yWurD7eBbeVdwPljD8mY6HtQzqn79sLVC+U4oD2vAlTJiR2gxW
g/du5l+J47trxX+xMKi4hiXenPNMa7pea9jPJjIyNX0mJwPnJY2KfQr/wswmxrs2
6OcCE6Zg5XCnbK4Z4W/+AkfVEwfhPy0QmMHtNcdf2gn4pf8Ho5d3+DN63hW278+Y
ApQHJQ0Z2ECjwgVcUaiModFQl2ZgRFJ93MpWQoCnCZNb9jTDZWoyv5Bz1hoxMyul
9eap2oOt9HnmPCI5KXts1S5+uowuWAhrpEAKcGG/SeBCYST8vDHiLPUlgUGslltM
BTzi4GBOr8Mu1DUAORLyj/PFaS0dXfsLylzQP3Mb/nMh2HZbg9h/c2/Vk2ns3cbA
MrJ8tlxrAR2F1aiWOn3vRTCB4YMDCgIEIsmZze/pPUf9R0gWgQjdac8MRiTzYkWy
S69zZvIxTglVvTvcxdtf
=p0i3
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

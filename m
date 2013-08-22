From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 1/4] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Thu, 22 Aug 2013 18:17:16 +0200
Message-ID: <20130822161716.GA31704@katana>
References: <1377181146-17341-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377181146-17341-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2013 at 04:19:05PM +0200, Gregory CLEMENT wrote:
> The I2C Transaction Generator offloads CPU from managing I2C
> transfer step by step.
>=20
> This feature is currently only available on Armada XP, so usage of
> this mechanism is activated through device tree.
>=20
> Based on the work of Piotr Ziecik and rewrote to use the new way of
> handling multiples i2c messages.
>=20
> Signed-off-by: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Applied to for-next, thanks!


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSFjmLAAoJEBQN5MwUoCm2CowP/jiai1kxt/GCNo5p9fS5ykax
hdA4A+AzqqnhX8zEGjYvs8xOjl+m08qNMAhXjKAbNbMMy4sEIkn4v9BH4/nbvpQM
Wxr+8ROo1I2mey8h91wO401PvLcatNl5q/PcPutaNUvvuM9DTVJgFY3WYPwC76d8
1aTX9caAQvr2y4gUuzs1YlTJMX7O6TC52FpHSVn+a9lJIQR4yJ71SqsbzRgDlnez
iujFotDLNIaJkaAk65H2AbCJ8uLegoklCODb8X2fxWqltPlbviIkvsZVtQMh2s9o
/eMbbPktFz01THh0My+lfRE61rPLG0qzncBKJ4bHm7CdzRdqL0WZ8W9nij9bIVBT
Z1GWkB5WSEU3niuiDGvblUHi3Avuexv4/Nj5C7wqIvx9lT8w7EvM5tUNdC2HrkaL
0hCPJZBEhAfrwHJglPCFw2RxYHy9inlY/XloadLKcs3gdZmAyXt8d7fdY5lgnK78
zglfrYlsO3kmgSLciO/MsTdH1C7pDMJWsFwsHpE5z1I9j0qrz+Ub2pZk1QcNfprr
36tQoUbXcAAdbauDKqXgvk3eynEubMa+SNcXIWk7uiVACWHP2ZajsbrFe3woCRhK
8FN5Un8EQeZ0EEEFyU1OMEQvYAPILh5700Nc4KdjcQLpPvedk3j5Uf0uRhJUK5ZZ
6Trt55nbIWyUUvW2Y5Is
=qnfB
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 0/3] i2c-mv64xxx: Fixes and new feature for controlers
 embedded in Aramda XP
Date: Tue, 20 Aug 2013 21:07:14 +0200
Message-ID: <20130820190714.GB24466@katana>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <5213979B.4050306@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5213979B.4050306-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Jason Cooper drooped the third patch as it conflicted with a patch from
> Maxime Ripard which adds the AllWinner support. Olof also asked a formal
> acked-by from a device tree maintainer even if we already answer to
> Mark Rutland request.
>=20
> Olof also requested that you take the binding update, so I am going to se=
nd
> a new version of this patch set with the last patch split in two parts.

Yeah, I wondered about the binding already being accepted when the
driver review was not done.

> As explained earlier today, unless you really want I use be32_to_cpu in t=
he
> mv64xxx_i2c_offload_msg() I won't change anything else.

I found some more (minor) issues. Expect a review by tomorrow evening.


--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSE75iAAoJEBQN5MwUoCm2i0UQAJCbQr7XFnz6Sctdw2jtKeOY
37wrTL8F/NPoi9tvbXdiqZrZ7zLSSiqG3d8gge5shbXlYqRj5DoLK0wPPwbKo9db
OH9rcDsGqkZTTrcEDE/yGjiLQN0mY9l1oX3ebu/yL3bue9eY4pKblig39eCQ+vYN
NCePbqCigGUguQcn5xoL0g1cAxqs0tSUC5EWhzIR78QOdqtQjYREvzdFWC33UBp6
Y5b5PIhHqNoYnWc9qDCBK7eSWv4Iq9nJP0qtJ4XH5SCV6/OyTnmP9BlUG1o0pEQu
aaqhtpVcvaJld5p8Pkr/V0RZFQboc1ca/w/yrXgJc2UVtt0qBuigz9oTLPRkhArm
ryswSvF5Byjep3GxMlLukOaa8tIW8EwQ+GQH9rhg57V6l5XaAyE9N079bf45Z+Ee
DQXZ3cWHn0zNTU8Jj7OWqFBT9RJSEpgIkd5f6wm7E+2MlU76nejvQgcos0GCFVfe
Cr0FBe6PzFRdTVFypClbOEeW7LmiSe+hgXDzNR8NBQjQeNcC3nZe/5w0pI/riCCY
XZuETZq3zwbLHxVQCuF6iV4b+1uRkKwxb+OQHpw6BCVk9ABX+Uckx8wX0XciQuVq
+BKVo96sTDhfwtdINdwF2ojWg/4xDiIqhWSH0zcNk1Te0vNPZYil/EuLGW/WfYPU
1rRU6cTIS9aJkqjRVykR
=cItr
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

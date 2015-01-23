From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4] of: i2c: Add i2c-mux-idle-disconnect DT property to
 PCA954x mux driver
Date: Fri, 23 Jan 2015 17:13:50 +0100
Message-ID: <20150123161350.GF9592@katana>
References: <5494599A.8050803@nsn.com>
 <20150115123237.GC2549@katana>
 <54B7BBF5.4010001@nsn.com>
 <20150115131935.GE2549@katana>
 <54B7C206.8030809@nsn.com>
 <54C26BA9.4050405@nsn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C26BA9.4050405-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 04:41:29PM +0100, Alexander Sverdlin wrote:
> of: i2c: Add i2c-mux-idle-disconnect DT property to PCA954x mux driver
>=20
> Add i2c-mux-idle-disconnect device tree property to PCA954x mux driver. T=
he new
> property forces the multiplexer to disconnect child buses in idle state. =
This is
> used, for example, when there are several multiplexers on the same bus an=
d the
> devices on the underlying buses might have same I2C addresses.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>

Applied to for-next, thanks! Added a newline after declaring
idle_disconnect_pd.


--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwnM+AAoJEBQN5MwUoCm2neUP/RTavF6pw+x+kSTBTlYPOI/y
RT0P1xmxvXjOkj/21e+2F6FsUHdgDWWvtyYvPr+60P6m123jxsaMLplSk3xDqv57
FfiIdSr83Z3ja1kbR1U24WeiDN1j+/O8L9o0IRWxuwJjAz3rK+uLZU/bPF08kBMx
FfUU1kNxZsL1Dag5DzTTrCw6dAQTAVl/SuhGddEPS2fG3YKQa+YOxmCDZejjs/Mj
tTMz/gEnBzw5CcAN1+0IUPKFexCn3VqcIZnbQkcs9F6RB8vZKDtwRT1QEB5iGaj9
dXW+AfAi5EuAtGRbLNw+GdCJkCfimqbNT4xLnSfajlPXenoExeiAq63bexuskS9Z
GffuTsTTJQTdIH+SJIBJCEVYOgHWRv/xCneoF7neMhHQNqwfIbaswIrd3qWeB47O
o5tz37PZsoGsov/qYeU6quYli15QQqf+SvuFV0t5oA9uxWI5rKcbRFZHox074EP5
LUZh+4xxnySKLvZCAeCPt38Nl/OIB4zfyL4iZXpEyLpVnvMX/moPpbW/j8ZLmGma
+Bnt9MN3MZ70MY7UR1vWvcIBH7bM9+gOvEfS4Z2sFp9LGVkpohGMChOH5tbwaKv1
5JQyXFesn5ebUqB1i03S1oz33Gj6DqYdCst/F1qrFaOx8cLXyl6PQ5nEa8aC+Cxs
6bXCJc3mZYWigI2x47SK
=p2VC
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

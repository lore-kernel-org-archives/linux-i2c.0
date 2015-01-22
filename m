From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] of: i2c: Add i2c-mux-idle-disconnect DT property to
 PCA954x mux driver
Date: Thu, 22 Jan 2015 15:56:43 +0100
Message-ID: <20150122145643.GH3413@katana>
References: <5494599A.8050803@nsn.com>
 <20150115123237.GC2549@katana>
 <54B7BBF5.4010001@nsn.com>
 <20150115131935.GE2549@katana>
 <54B7C206.8030809@nsn.com>
 <54BD069C.2080108@nsn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54BD069C.2080108-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -				(pdata && pdata->modes[num].deselect_on_exit)
> +				(idle_disconnect_pd || idle_disconnect_dt)

I like that. Very readable.

I don't like the buildlog, however:

drivers/i2c/muxes/i2c-mux-pca954x.c: In function 'pca954x_probe':
drivers/i2c/muxes/i2c-mux-pca954x.c:231:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
drivers/i2c/muxes/i2c-mux-pca954x.c:190:22: warning: unused variable 'np' [-Wunused-variable]


--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwQ+rAAoJEBQN5MwUoCm2ProP/jbg/OCdC0j7NnIIY7w0sXHm
lfiTCUcC/VXTXJJTxaRQ8pNOXHNU0wEB+DDbz0sGiMTnwJyx84QMja4b23z0dzkf
LmYREj9iQyAffyFEg5fep6nDVfw2P+kGxiKonQggnBUUdMAcQakIrEP2fazkH4nL
28KYO4ZeP+s50MkSGcRyTEB1HuLyVtfS3cxtGdbSePZijDGKEJVBrQiDBTUhZwZX
aeX8ituSV3Y8vco9tORQ/VKuQ0z1+YiJ9kprzUU0DFLYFEL0lieJGXwtmVAJp5t0
CxdW2lKmMdqiTN0vRI1ZKp+bZlGC+tNJsEFJrA2HNwYZ3pMzTeth+N1IJyTNO8Jf
QKZkF8EVa7WBzgc1DB6ZsuOG08bXY1Jcz7MmQlqdyoZfQWJW6y1O90WNyk2LERVB
n3zOw2c2FLcZaqofRC9ZtIxrAtEM0t5H+cIb0oC1fItmDkZwDWEG1sGUd+FMnlNR
WGGMd3z6OUxVUmmCDSPrdtv5IrGCtZAKQThB1DPU+NL9u0bHfXrbcihr60lmZ5Zy
sfwmL6KYQaUi9SYNvrlT+es9lMjjQrjWeF4B9cx34a0S9ZQ+vsdjWqTSXNM8hN/t
hEL367J3mhqe44MI4SW9lRgoI9CmSViDUJz/u06O8XMYiaf7ukyvOJo+qSP1+QJv
h91pru4kD+ktp5c/OuNe
=Jocc
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--

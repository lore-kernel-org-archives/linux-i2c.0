From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Fri, 13 Jan 2017 09:29:03 +0100
Message-ID: <20170113082903.GA1446@katana>
References: <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
 <20170112120309.fmrt2lwz3vklqmti@pengutronix.de>
 <CAOAejn289GLOSP-nPJnO_VpXLpyhTsF1bWQ7Ns9OfgPQCa8YTw@mail.gmail.com>
 <20170112174902.j52foglkdouyz36n@pengutronix.de>
 <CAOAejn3tPi0fjy+t-UhMTvAq7LfdKJJdbcLw2su1-YAGDZMxew@mail.gmail.com>
 <20170112211004.z3wylc7vrubulc3x@pengutronix.de>
 <CAOAejn1HAU5spQeXmYPH4XH0L5bGuoFgguozwMp=uLKcXDEPEw@mail.gmail.com>
 <20170113072650.orx6vl2orqfakcuk@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170113072650.orx6vl2orqfakcuk-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> (But note that this is irrelevant for the patch as the driver doesn't
> claim to support this kind of transfer.)

Yes, I wanted to mention that, too.

I'd think the series is good to go in?


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYeI/PAAoJEBQN5MwUoCm2bVsQAIbzqUM2p/ozk3KTiSifrM0z
/m0hxQjaXEN4FW71iFacZnmpdS8dQI+o56OyDpgc887LjQP0pjGUdSEsIKumsqZp
zfpdBOMv05MR4kXFijtMEhpboOlmq8Nz4xjrtio4xXAGceqqhLfPIrANJvFPLFE+
oSU//hcr4RPLBT5z19wtO0bTp72T8x/mWpxlIU7U+TRnjhtPE3K0bkvqoDmRJgIm
dAcrubLdRzLxcAHQGSv4UJzXqf6npSwyjvfo9I7xvthceSmSJd9yVVuBELR4+IKO
IZtoCKxk4rPFAkTrvw75LzAWmcZMmJOl3Sh/S/VrdpqsQ4bwTizxIkb6KQgU/wS0
CQu+7Oq4nKnc6MeG8wt8nJ063RgM8JZQVEOs6Si8LJkvdTnz9BACXdRi5ijzVevj
19yRNtm3jnhbmQpyYkO3OtGqwhrPK/bSFzayeTCJlLRUDGqYX4tVRsfBDFhygGLq
lS9IP46q+jopMtJOUv5jHqEV1GmD6aJ25qmMNftV1I/ReSMDeiZ7kbaL0HjLTKHO
FzlmGLAD5wesqCffjJK4hMsnz5asBz+54h3+p+x0Yg6ozO5h+e28Ox2Skfs+O6Lb
I35B3p/6GmuW7Vsd0FZzJ4/eWaaA9cG+v1Q4uPxKxBO1mzniRp97jrhGYc7nCmVA
95DjuLiqoqYshhU3yH+O
=CPaC
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

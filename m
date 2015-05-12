From: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Subject: Re: [PATCH v7 3/3] I2C: mediatek: Add driver for MediaTek MT8173 I2C
 controller
Date: Tue, 12 May 2015 15:00:57 +0200
Message-ID: <20150512130057.GC4447@schokonusskuchen.bad>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <1430901427-65146-4-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430901427-65146-4-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo
List-Id: linux-i2c@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	if (i2c->irq_stat & I2C_RS_TRANSFER)
> +		dev_dbg(i2c->dev, "addr: %x, restart transfer interrupt.\n",
> +				msgs->addr);

I'd tend to leave out this debug message. But you may leave it if you
like. Rest of the patch looks okay.

Thanks!


--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUfmJAAoJEBQN5MwUoCm2DdoP/3ZYoROZlW7IDuykTUQw4iUl
5dalmTI1vfkGW9EUBKCda6VawpgAMCD2ZED98QLIVnAiIr9R+V5QAts55pZhCuRF
DMZjUQBeyhgFg3I5WQ6tyv2BH2J1UaTgR1NASf/KNwkQPxdafmySePiSkdmKFVgv
UEGPulLfpwEC2pvfwuzQKrQFawp30L5j+tYB4l169CBUIHhCE6juXIZXM5/+5fTc
Iz6F+xKsoRXqZejO1r/uUs2tKruzOxwxLl91WJNJZGvccq2Ycuusw/+csxuTMzjO
XEnq9DjCcy9s4rNrUdJjJlQS1T6+SJezLlj05+6N7/juto/LhrMkB4pdVTGsvsEL
qLs3AjaC/MeMkIuzl/umFP4UdbwEsi0AgB0NF2o2dDEXCE5TTRMlaMXp79tCtK8s
8N/hN7W1lZvP5fgeqs79Tw8ZUfZhEw9D1KZ+frHYD5JXvET0JeFPqEhucW2hZ7rp
yDl5FyZke7dkUuIs7/nBZtG7KbFeFutKkRgDXYRIhk7oURuHfkHJkLMHtdHJFOUD
9ZoaOSHGi7UGAvXoOosMGtido/tyGBmE5bOdrnbOdqhGXqDW7IqTekfuo0yyCLal
YepaTyCWpYo2DiBZKYJLI7S/jtubRNJVYO3hP6BoW5n8CnsHd8B6UHU4MClwroL4
L+ymMrCbeRoT26Ct7/4u
=1Pos
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

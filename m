From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] staging: imx-drm: document internal HDMI I2C master
 controller DT binding
Date: Tue, 2 Dec 2014 14:21:59 +0100
Message-ID: <20141202132158.GD4072@katana>
References: <1416073759-19939-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1416073759-19939-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <547C8113.3050100@mentor.com>
 <1417446703.4624.18.camel@pengutronix.de>
 <547C8B9E.8050605@mentor.com>
 <1417450979.4624.23.camel@pengutronix.de>
 <547D5DE2.2040704@rock-chips.com>
 <547DBA99.1010703@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547DBA99.1010703-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Thank you for references.

Yes, thank you all. Really great to see this consolidation effort going
on!

> I'll try to review all out of i2c/busses/* registered i2c adapters, may
> be there is something in common between all of them.

Yay, cool! Thanks!

> I'll prepare the change of the HDMI DDC support for review (will be able
> to test it only on iMX6), Wolfram, please skip from your consideration
> the published version of the i2c bus driver.

Okay, will do.

> Wolfram, by the way is I2C_CLASS_DDC adapter class in operational use or
> deprecated?

Class based instantiation is NOT deprecated and will stay as far as I
can see. Many platform bus drivers did set the class flag needlessly, so
we had a deprecation mechanism to get rid of those flags in drivers in
order to speed up boot time.


--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfbz2AAoJEBQN5MwUoCm2VgcP/RgU3B7AYR+/Q8GqQkwmH/AH
2rtjpgnOhZUTOVs4nq4J1LYdxdoW8rUKmupohD7uOz0+wySlWVl3GU8ahO5uzykp
Q6OrsquSGvjfLbSyBCiZ/DvS40J4I5w0p1OwYK1IUbOYaIFdWzbjQrbctTPfsRBr
QX9tSHh1nuknXMPShO/ePiV5qGRsadKBb8FUMOVoaOffgal9BtCWTfj4mwoHQMro
Lj0qcC2duG2PuDnZW7/EWTnxQ8YczcaE/ABuxVnZoQoyKHvr/hXaN/2jn9aeTaqk
fbq4mzHRdS+zN1x51pqbPsEe6aqZtFJ6oIWpO4CWzNI3llwT+BG5uyngrJ+X3r8B
82aRSxoi1HJEm5P5mbjhOAo6YDCc9XPpq5qwp0JDVtxb9rfEE86kQaeabQEH+Mvi
yCyFqPxaOTYwBB4JRb28Yrk10RsbEuIK1Y/zK/jcsEJgI5VkzZbEtgI9nuYvpOFW
xV69Kbi0c5ys/PU4Dv5f3qdCL38CJCbz6p95BnWzJRyG1z4IRiLy9oUPF1yi5VyR
0Hlc3TdrsNWcdVZbr7xfC6OPIvuhGojmhE2GoJVdxmMkh3Vza85WEgmyEO+OoUbd
BQRBnk7FKCaIp2pWeBFPO9En7m1pVen1pl1xFlYJNX1VY1N1/79HR0rkdtFVe0y6
8RTvBVrh6uMPt2FRNve5
=Phgz
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--

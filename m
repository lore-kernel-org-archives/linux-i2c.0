From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Add generic support passing secondary devices
 addresses
Date: Sat, 20 Sep 2014 18:49:07 +0200
Message-ID: <20140920164858.GA2260@katana>
References: <1409925739-28188-1-git-send-email-jean-michel.hautbois@vodalys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409925739-28188-1-git-send-email-jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2014 at 04:02:19PM +0200, Jean-Michel Hautbois wrote:
> Some I2C devices have multiple addresses assigned, for example each address
> corresponding to a different internal register map page of the device.
> So far drivers which need support for this have handled this with a driver
> specific and non-generic implementation, e.g. passing the additional address
> via platform data.

This raises the first question for me: Are the additional addresses
configurable? Sadly, I can't find good documentation for the adv7604.
Otherwise, if I know I have a adv7604 and know its addresses, this
information should go into the driver and not the DT.


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHa/6AAoJEBQN5MwUoCm2cowQAInZoQAN+opPxEQBakjTtvMO
PBst3S+3n1IL75pEgsx6nqA9Jj5DrdEPTL4NRXwK5Oa9Cd1AyrjsmyX4267YeGz8
Ud73Zxz04Szs6h4iYOJebuBBkHKttTETqv4RVpHDm0PGRR2e6K1zPl8Ik9bxfSI8
FvLhQAv6ijO6iTtKzv3GnrMdqkHO1iY+vwy+M01caP52ruRl4aatEziLgY/1hn6v
reCClnyswVdbz/JEcCIoiHScirRVUJpIMYqbdgcJp1nqcQ6W3wsg4JNUrxa18+Rm
pRuJLVwqyzuM2aLvKA22C3i4uHz8L6zdSWswmrnyV/Sy6G/7CVG4CB4iIS6X5sSo
p7ay1aLrPYcFTX66hr0Fz+1nDPkQ8lp/gT3mnZ2D1pLxwSJyyC3+/1vKVtkItSA+
BmQicrewzCnspQ7H+3lSez7RaC8ye6pGIKF4dQABNIj8/IaxU7onHW9wOwB/Q8Y1
sXId4PPNoIMn28duS5M07lB99aSruemP1EHUXx1XaAkSLmD2SBvK1QUvE2v9zCcS
kNGTqlxnvb/TE38UoFtdQ8yQs7tH8awdavDzUvpPTOP4x0Vv8GmH3YHcQDcndz0d
gnCpLzdLE3ukRr33AsKKU5rsj9vA7BStb8g35EvCVwlKjerVaierYc+CWWUOpQgv
w3M6pKO7MFZ/o3t+QJeY
=Kl2+
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c for 3.13
Date: Tue, 19 Nov 2013 16:56:46 +0100
Message-ID: <20131119155646.GA2569@katana>
References: <20131118193802.GA14925@katana>
 <CA+55aFxZaC=beR+dN36Sv==6fjY7SdOdwXaSHU+wnk+-oDJp4g@mail.gmail.com>
 <3690707.5664qBQcL8@vostro.rjw.lan>
 <20131119150001.GM2281@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131119150001.GM2281-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Actually, can we remove the whole clientdata setting there?
>=20
> Commit 0998d0631001 (device-core: Ensure drvdata =3D NULL when no driver =
is
> bound) modified the driver core to always clear out that field. Same seems
> to apply if driver probe fails.

Oh, nice, missed that commit. That indeed should help cleaning up the i2c
core a little. I will prepare something.


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSi4o+AAoJEBQN5MwUoCm2dDIQAJJAuFfAzmhcYrK1Ns8Y/K3y
BhiBkbqdOKoyAVbdSCiqO7kNDGO+nVp+V9TiELLuJg3d74D4Sq7Ml9qRbIhWiH6E
APoRjmgYC+c4XZ9/o57SGPmcBoFckx1KZaT9AI/W9/lL6FAnKIgrDLDcrwZOV4+V
/F9OIbXKaDkDsIkDhPw7Yj89WGNKy+LAIlngUKLl6bYfq+Xa5Ympfr13z25qbh+y
zZ9A5bM3ruImEAkdqtSH/d7Yop5LlRLDmwrGOZt620r/OYjJzfYbsvESCagetxrX
uA0wrufem5shuON4zem8FgEHitnCzX8StkxZvGLWtUBOxNsnny+EV1uYWWpLCYdH
pTaDCRdH0C7jVlAy9sLP96KAQDVCcTW3M5QKBevEs5NVom71P2oIufAwcuef5JTK
t+oPuco1W2E0UNmaDh8CZmrXmtrS9WadUd1ubuTpkRrJhB4ec0cq/N03WCADapsg
CjUZsm6+ve4osvVMmdPrkdcKBm2mjDSaY3V4m2LhgYSfijwzweklSMJgtejx2B7I
7thHRh54xJ4btmq+HEDRck3t4ZKcMn77zp/ofdwqPIjuO29ub6VtM25M/8MCqLmc
pZ0mwDXTiwjpIzSXEm0unpWrXzYuB3vWBfkwC5t2Iqmeegu6sBhmheTJ99xpxgXf
0iMZf+Wis0ru1uhypHRh
=aeJ0
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

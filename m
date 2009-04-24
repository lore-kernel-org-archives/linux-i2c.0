From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Fri, 24 Apr 2009 11:09:11 +0200
Message-ID: <20090424090911.GB26169@pengutronix.de>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com> <49ED9132.9050806@gmx.de> <20090421115936.28656d09@hyperion.delvare> <49EDD423.3050302@gmx.de> <9e4733910904210900r4c5d1a8en178ad106134b7e6d@mail.gmail.com> <20090421183310.50ff7e0c@hyperion.delvare> <9e4733910904211218l8428128k1f8dd021c50c7846@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9e4733910904211218l8428128k1f8dd021c50c7846-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Something has to trigger an interrupt (or the user types a command)
> indicating that new hardware has been added. The driver of that device
> can modify the device tree. The rescan of the device tree will cause
> the i2c modules to automatically load. This shouldn't require any
> changes to the current i2c sub-system.

As I understood it so far, the purpose of the devicetree is done as soon
it is presented to the linux-kernel and once parsed during boot.
Changing it at runtime and reacting to that looks like a bigger step to
me. Hints for that are that most fdt-functions are __init and I couldn't
quickly find an add_node-function...

Shouldn't really matter anyhow, should it? As soon as we are run-time,
there shouldn't be any difference between DTS and platform_devices. It
is just driver-model then...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknxgbcACgkQD27XaX1/VRvDOACgnUbFM1DyY1BtzgEaAcscb0TM
ogAAn27eTr6+CmAcLigNmlffVqKDNBbv
=FR/P
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

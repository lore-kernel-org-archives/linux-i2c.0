From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/2] i2c/of: Populate multiplexed i2c busses from the
 device tree.
Date: Mon, 23 Apr 2012 19:58:29 +0200
Message-ID: <20120423175829.GA2767@pengutronix.de>
References: <1334265263-13549-1-git-send-email-ddaney.cavm@gmail.com>
 <4F880960.8010803@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F880960.8010803-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Jean Delvare (PC drivers core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2012 at 01:09:20PM +0200, Lars-Peter Clausen wrote:
> On 04/12/2012 11:14 PM, David Daney wrote:
> > From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> >=20
> > v3: Integrate changes from Lars-Peter Clausen to make better use of
> >     the of_*() infrastructure.  Get rid of ugly #ifdefs.
> >=20
> > v2: Update bindings to use "reg" insutead of "cell-index"
> >=20
> > v1: Unchanged from the original RFC where I said:
> >=20
> >   We need to populate our I2C devices from the device tree, but some
> >   of our systems have multiplexers which currently break this process.
> >=20
> >   The basic idea is to have the generic i2c-mux framework propagate
> >   the device_node for the child bus into the corresponding
> >   i2c_adapter, and then call of_i2c_register_devices().  This means
> >   that the device tree bindings for *all* i2c muxes must have some
> >   common properties.  I try to document these in mux.txt.
> >=20
> > This is now tested against 3.4-rc2 and is still working well.
> >=20
>=20
> I've been using these patches with a pca9548 and a pca9546 for a while no=
w.
> Both:
>=20
> Tested-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

Both applied to next, thanks to all involved.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+VmEUACgkQD27XaX1/VRveAACgzATmTRrdC81RV4mAaV37qp/R
bwwAnRlRY27ZXHk2qWeVgF9GfVmesKs3
=jCHJ
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

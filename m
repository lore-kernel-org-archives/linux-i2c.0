From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Add device tree support
Date: Sat, 18 Aug 2012 14:16:28 +0200
Message-ID: <20120818121628.GB12839@pengutronix.de>
References: <1344409609-1904-1-git-send-email-thierry.reding@avionic-design.de>
 <20120818094846.GA24812@pengutronix.de>
 <20120818111745.GA15702@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120818111745.GA15702-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 18, 2012 at 01:17:45PM +0200, Thierry Reding wrote:
> On Sat, Aug 18, 2012 at 11:48:46AM +0200, Wolfram Sang wrote:
> > On Wed, Aug 08, 2012 at 09:06:47AM +0200, Thierry Reding wrote:
> > > This commit adds support for probing slave devices parsed from the
> > > device tree.
> > >=20
> > > Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
> >=20
> > How are the devicetree nodes of the slaves connected to this PCI device
> > which should not have a node itself?
>=20
> The matching is done by pci_set_of_node() and pci_set_bus_of_node().
> The latter will eventually call pcibios_get_phb_of_node(). What makes
> you say that PCI devices shouldn't have nodes themselves?

I thought to recall that busses which can be probed at runtime should
not have nodes but should be probed. Maybe that was wrong. Can you point
me to a dts-file with an example?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvh5wACgkQD27XaX1/VRvjTwCfaK03r/DLNoxuRZnN3QdTO6+h
qhUAoJyBcZCUf9NbcFUJEW/H7wQmf0dg
=ZmQM
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

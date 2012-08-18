From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Add device tree support
Date: Sat, 18 Aug 2012 13:17:45 +0200
Message-ID: <20120818111745.GA15702@avionic-0098.mockup.avionic-design.de>
References: <1344409609-1904-1-git-send-email-thierry.reding@avionic-design.de>
 <20120818094846.GA24812@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120818094846.GA24812-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 18, 2012 at 11:48:46AM +0200, Wolfram Sang wrote:
> On Wed, Aug 08, 2012 at 09:06:47AM +0200, Thierry Reding wrote:
> > This commit adds support for probing slave devices parsed from the
> > device tree.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
>=20
> How are the devicetree nodes of the slaves connected to this PCI device
> which should not have a node itself?

The matching is done by pci_set_of_node() and pci_set_bus_of_node().
The latter will eventually call pcibios_get_phb_of_node(). What makes
you say that PCI devices shouldn't have nodes themselves?

Thierry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQL3nZAAoJEN0jrNd/PrOhSxEQAIS8NBwXdp7WeVUznYH+rwoE
L7Z4wjtaBX8Xo55/3rM3DuXciQDdMiNAnLG+kT1TcnUTidmKrXroWSnI7Tm5OTdB
Y6o4aneggDWlHJlv0tCkuHGUN6u0fYh6yfOL07Nc0KmC20fNxkkoNIaFR2x5+UB8
orggxWqu6MT5vqQpKwP/Y1n8CdMZiXcITolazsDUZw7UA75tiCA/XIqi+Zvp8+P7
SqOG44Gw4dSytMjcYFKweHI3zb3qiztbBAuMo2j7idf/jTQ1TzG9OJpJbIsA7n+8
ZErce+LX6fPcno+FL4q6xMZVHribE3DEMozP913q9zOT5pj9/h5QhQfE+QRhHXen
eirsYDmMpSQUvcwMhCxGMB41rKiuq6wGieF9JRWyVkTMEg3eTFpYavy/Ew69IdJ3
pOSdpM9tXi73XkUYO2BTv9DSRvYCV6IblPx5yC6GOx9B+a4qA4nd0oPGKkxIU3ei
n2dYtrL85jxc16QbgpKXqCUsG9VjA436FWL04kNnMr2DYcfEHq32YetTcJA9g8ij
UrAF2SIOueW4qGOvczXpvrliy16JZCdrddWs+IuLYTFSPNeNhRv2oNWPs6Gw1xOx
Yxx9nXIIz04RTbSlvwa/xc6knxPeCYabvFOF77DjTUxYU07vwOcGkW8BrHb69py/
Xed9sXKJrNLhnE3Db0Fm
=EmG3
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

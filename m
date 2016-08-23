From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 4/8] i2c: thunderx: Add SMBUS alert support
Date: Tue, 23 Aug 2016 23:39:48 +0200
Message-ID: <20160823213948.GH20872@katana>
References: <cover.1465997603.git.jglauber@cavium.com>
 <4ba9512e145ee8d303393874a0033ed83ae33a8f.1465997604.git.jglauber@cavium.com>
 <20160823205724.GD20872@katana>
 <20160823212859.GC28936@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160823212859.GC28936@hardcore>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com
List-Id: linux-i2c@vger.kernel.org


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2016 at 11:28:59PM +0200, Jan Glauber wrote:
> On Tue, Aug 23, 2016 at 10:57:25PM +0200, Wolfram Sang wrote:
> > On Wed, Jun 15, 2016 at 03:51:30PM +0200, Jan Glauber wrote:
> > > Add SMBUS alert interrupt support. For now only device tree is
> > > supported for specifying the alert. In case of ACPI an error
> > > is returned.
> > >=20
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> >=20
> > What about 'select I2C_SMBUS' in Kconfig and skip all the ifdeffery?
> >=20
>=20
> Wouldn't that prevent a distribution that has I2C_HELPER_AUTO set
> from enabling the ThunderX i2c driver at all?

=46rom commit e2ca307439fb9df922c3e8891289a2ac05812fb7:

=2E..
Bus drivers which implement SMBus alert should select this option, so
in most cases this option is hidden and the user doesn't have to care
about it.


--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvMKkAAoJEBQN5MwUoCm2IusP/3OwdSMd+BR+eqTWndOihAA7
oyL8TkOABk0c6SY66J7BSUtGkttf8kj4+9/04VOOT6YvEvP7nMU7lB0RNBJnDmjW
/11EsbTnJ/QGteseVG2HZNFTxyIOR/Crkr9G7hv5fqF/43MuhU/7JvfECDnmC304
C865QUZf7ytQO04HDWLibGyHvAKC3n1IqvnW/XUbXVSpUPyGcNHngoxyq4nW4xjb
2xNCa3ESseSu3pFaOiQui/Ne6UHTemFirr0PpyYKGELxlpo3VJH1bcRJNj+2AH39
PH6u1ak/mwbO58WftiFtpMAmr1XDcBpFVByP0+IHX8sGAtuWuL5Bkc07nvXTyHzN
6+jG2KFzbocD9Y3oF1eQp29skzebYqJmsOzYF6BoMcKea2e02B9oCnpTYzN3lvr/
901j+F9MNb4UB1ukDt9xhiEHUnpXqgQMmHpu4Q/O5odc7t7MgTwR755DZENsB/RK
kR/FtBYP+QJdDY3Rh6EMBiAYU5rBOIfbhlHVPPFqzAK/+DK7qpnVQd1i7WSsxApv
V0WZJlHGXTWgWGODvqJQ/UExTYBOCjjOiAbtUYaRMeVJz3K9bONIDZe6+gfjQvK+
0Bn1M2OH9l+y7b85SJJWAhD+utwH+Bks+3UIMGZKRXxLiycBOXkCx759sTMpGRax
eQ0V9fv80+Zw+ZtyuM9s
=OMmI
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--

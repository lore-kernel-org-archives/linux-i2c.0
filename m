From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 03/19] i2c: octeon: Rename [read|write]_sw to
 reg_[read|write]
Date: Thu, 14 Apr 2016 10:58:16 +0200
Message-ID: <20160414085816.GC1533@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <be18c6fc7331af1b383419819a5a947f35dd6d00.1460387640.git.jglauber@cavium.com>
 <20160413084409.GD1563@katana>
 <20160414075847.GA2532@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160414075847.GA2532@hardcore>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 14, 2016 at 09:58:47AM +0200, Jan Glauber wrote:
> On Wed, Apr 13, 2016 at 10:44:09AM +0200, Wolfram Sang wrote:
> > On Mon, Apr 11, 2016 at 05:28:34PM +0200, Jan Glauber wrote:
> > > octeon_i2c_read_sw -> octeon_i2c_reg_read
> > > octeon_i2c_write_sw -> octeon_i2c_reg_write
> > >=20
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> >=20
> > Please add the motivation of the change (the reason). No need to resend
> > the whole patch. Just reply with the updated commit message and I'll fix
> > up locally.
> >=20
>=20
> Sorry, forgot to expand the initial description a bit.
>=20

Applied to for-next, thanks!


--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXD1uoAAoJEBQN5MwUoCm2WyQP/iKsu8yMPkSCmAWFbxUk6b7+
bs271jVAciz8SPZa+84doZISmdblKa+8+ot5ec73gFIex9VujNenEK1EGfBaRDMH
ZiEAuPVC4oQp7RbinVlClKn5aNO/u2mScnw2D7XKMj0Hb/JeAfKHq5bueP/v50U7
8ko32BYxErykM6VixriSOfrSZszVzi1gpFeP1or7K8DJdNRRASuqPf6Sb1tI3O3p
cZbjrxbzmFZhFZH79iOanSelgtqLH6CA8HxSpKHreFGoYDA5BYd36EepTmHOe+xA
pTdnLfUp70OKdpkIGwo4FxFQwoQD/uH96kls8Cdo94soty6s8pqvFJTie5knjf4G
9qbLnaWJQKIWq9dgW33QN3wddShSQQq836gEg/kvyA556E835Q1fK43zVfPjn6wY
MI7RVqONEBDLWU+HAJNdnTLP5ll96Ma4jMWJUFbqadxwp4ZSytMxVNfd3I85zUsJ
U5z9S91L5TkAgfCiS1nm9WSOoAGn1volbjPJF1i5acWuxY0wBJRSalfLYIlounqO
8uoqBqcFonGfvcASOU+Ye5U1FA8dpdUMVykYjOwFkyMd6wlkCrb4AiiSJs/wofIF
hbVJLtkXko1H8k2bXbRgMAWruDYFnzk6sjiDVcfFqohwFIonYtDcX/c8PXDrQpvq
V+gOOdgLvQD4KZFKFq55
=ypXg
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

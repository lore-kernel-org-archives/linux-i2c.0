From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] I2C: mpc: insert DR read in i2c_fixup()
Date: Tue, 3 Jun 2014 14:17:38 +0200
Message-ID: <20140603121738.GC2713@katana>
References: <1401786032-17818-1-git-send-email-valentin.longchamp@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401786032-17818-1-git-send-email-valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Cox <adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org>, Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2014 at 11:00:32AM +0200, Valentin Longchamp wrote:
> The mpc_i2c_fixup function is called when the bus is not released by a
> slave. The function generates 9 pulses that should lead the slave
> to release the bus.
>=20
> The sequence that generates the pulses disables/enables the I2C module
> that controls the blocked bus. We have found out on the P2041 SoC that
> this could cause the CPU to hang (for a short delay).
>=20
> To avoid this, this patch introduces a read to the I2CDR register
> between the re-enablement of the I2C module in master mode and its
> returning to the slave mode instead of the delay (the final delay,
> between the pulses is kept), as proposed in procedure from the P2041
> reference manual (16.6.2.3), and the other manuals from the mpc83xx and
> mpc85xx families.
>=20
> Signed-off-by: Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
>=20

Applied to for-next, thanks!


--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjbziAAoJEBQN5MwUoCm28e8QAIqBn+E1BDdy6jhvlsLUKxRW
ZmNP/cq0Kir41z2zwSQpswWRnZYsIn4+Ktdg0rMDgd8X1XWUPp3IdNsVnpisEV9L
nL7lyKKbdRpzIGLq5bnmjib9bfQv3+rt+GQISpXIIEFoIJBHlqxZlw7DAz7pQOEi
bovWNJ/lEXRMFjOPRHusj7NncWF9BbktoyJcrxNujut42V2ff2PrptVm/aNU1yQr
jWvlu7mIdyEy6e5JNkce6qyNJS15/BZ2O4os40vvMTykxG96Mrh5nQ+AlDaDeQpX
vdBR9dY3+16NTSNyp1m69P3AuFRm4aY/KA/VnOlMfon4TsxJaGf/NWGKGUy8y3YU
dRRSztVK32A0qrsmWh1Usxgr/95jJ2rKZOpQtM94OrJpnTX3fqqgJwxtf/NUvQDb
pCstTvDyA5BCcdS8uJB/UwVmIoldo4n+87t32VfiYLs+Jp/aGMWrSZ07fwSFZtjJ
ZbPj+f8HZj5c9m0AHx5V9lda8d9YCQ+HHQJenrADlfs6JdsFw9rb+FF7Q2Bmek6s
+ZSufrstptdklW29hML7cqqM4azt7XPca5awEu2hA5/0z4hKgQcD1+L9pxXnSvxX
z+kahuhj5R3K7KW2gTTu207jgT30O5+0bNUlMrIU9xmkWCwjP22IboGoCE84tWzw
eJmNaiztpl/Z1Xhbff42
=/3n3
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

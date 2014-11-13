From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] at24: extend driver to allow writing via
 i2c_smbus_write_byte_data
Date: Thu, 13 Nov 2014 18:42:35 +0100
Message-ID: <20141113174235.GE1275@katana>
References: <1412845678-18933-1-git-send-email-christian.gmeiner@gmail.com>
 <20141113001628.GA2062@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141113001628.GA2062@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 01:16:28AM +0100, Wolfram Sang wrote:
> On Thu, Oct 09, 2014 at 11:07:58AM +0200, Christian Gmeiner wrote:
> > I have a at24 EEPROM connected via i2c bus provided by ISCH i2c
> > bus driver. This bus driver does not support
> > I2C_FUNC_SMBUS_WRITE_I2C_BLOCK and so I was looking for a way
> > to be able to write the eeprom. This patch adds support for
> > I2C_SMBUS_BYTE_DATA writing via i2c_smbus_write_byte_data.
> > It is quite slow, but it works.
> >=20
> > Signed-off-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Applied to for-next, thanks!

Since I haven't pushed out yet, I did
s/use_smbuse_write/use_smbus_write/g on the file.


--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZO2LAAoJEBQN5MwUoCm2B2oQAIDGBlOddMIEy9dXsR8yKyAA
mKsP7/KJYtr12t0KS8B7CQd5+S8Fq4jH38rK4x1Lu5oEsa9kNjIU4+y0wIFPCS1g
7IZlN0DPLvbsnDYE2jy5PkFR/zzLMSw8iyzpaGoS+uHb/eRkOL8SjN9iE4cjUMGp
mY39woKKYFxKIypsBk2qZp4pZgA+CgNKl52oFjoqj7OCcXpEnmdd4iLx3Gr7Ojnp
D2jHg40lKyOqG0fVd0ms5Bv/fwvcA/GQNrVTVBSaf0wNlpjkzqHiwzH/OX72hd06
0cTBbsgY+lHbilzigBQv+LqO9r6rxJZl3jEEaZAAhiR+Ys2Gzqqh19SjwoT6WmSU
7lOeK/TUmt1L4z1TMita61TqXgNkQ61KcisPrADfBDytPHrVERuQDnzqbPCilyqf
LvDahjrQoTs2Zd6Q/x6as0Cl5dOVox50i7AMjBM2T01Y6CPvCtFaVCRCwA/Qh+pz
foWzafADHuc2NEXW2T0loPy0bODaAWFnNmwL1YutkEfltt4rWB7yXYiqlSc1RmhH
23han+ZJa6HiWtsd2rmObLPa8HZonI+wHttDK67Hc4QC81DR8mElbLMorqeQrOrE
MoEws4lwEZUjHb6gRwHPFTg74l5Brq3xitkEh9gHy3mhx8f/4iVqxIb5SgpdbuFt
JgtNxPNdyNTfQNap8o50
=4wn7
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--

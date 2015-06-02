From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: davinci: Avoid sending to own address
Date: Wed, 3 Jun 2015 00:48:36 +0900
Message-ID: <20150602154835.GD2661@katana>
References: <55534B7A.8070105@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55534B7A.8070105-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Lawnick Michael 61283229 <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 03:02:50PM +0200, Alexander Sverdlin wrote:
> Sending a message to own address locks the controller up in very bizarre =
state,
> it behaves as slave even if MDR register clearly states master. The contr=
oller

Eeks...

> =20
> +	if (msg->addr =3D=3D DAVINCI_I2C_OWN_ADDRESS)
> +		return -EIO;

I think we should return at least -EADDRNOTAVAIL here. Otherwise the
user might wonder if the slave is broken giving always IO errors. Maybe
we should also add a warning message, I leave that decision to you.


--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbdBTAAoJEBQN5MwUoCm2aCAP/0o7O6sDMbVBM2jzfSeHD/7E
f4UbfKOnfQPEk6Ej1WaU4PfQBFJzQM8gSZ+4JC0093CXrWbEC5ACqHXFrpcPmBxU
NJQ+axynKp32TtF/BWgBuCl8ZLq/2cqHpyxDYMgFXSaZkd7kyx+Mh52keH1sH+QU
nSBDNTiL9O5StB9pbIoSK6ytxT2hEv6oXcgitug3ifqaOldwYVBciWJNICTsba+l
ijvjTxdiGLRdcsabYr9Xa5ZpNrNp8MuFK6P8AFtIgWcrybUZqOPbX30yEP0/npr9
dnIcmf8nyaDrkhoauuF0hbTsTyfUELq2lUOGgQPeUeUlHRhVuj+kbZjiP55tIpVs
3B7U7Sw+RhF5Y88d3iBMNUPvdN2Z19dfHRhPzxp7Pe9EghJ4Fahj7ginmdZWzYlY
z11VbnqS9KtWIxLCU4ILwADHCeYA3eTXOI6CnO+eKAlHUTETG0v4sy8f9kxtiSgU
UjLu7RhB/rmLSmZCICoZlncTQkF19Q/QEXb928gWPoc1KJm/bydq0efZ7jIXptLR
J+t4xszMh+gh6uFh94bbrBQ3jDoeGPq57rM/xiy3So9vPjhelnOO3Lb0yXNi6y9/
uDmvi80o0glSQllAviXuEWSKyu32YFzXssljeezKJ9DhHbGvNthZAlsIU99CDzdj
S6wCZ2KFOhrtni+GG55b
=k2VH
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--

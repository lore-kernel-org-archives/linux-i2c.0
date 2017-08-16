From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: slave-eeprom: Add an OF device ID table
Date: Wed, 16 Aug 2017 15:41:12 +0200
Message-ID: <20170816134112.GA1391@katana>
References: <20170809101256.31204-1-javierm@redhat.com>
 <20170814195236.4miomp2omul5qikt@ninjato>
 <1b2335bb-50e5-5664-0e01-38902cf717f1@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1b2335bb-50e5-5664-0e01-38902cf717f1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Luis Oliveira <Luis.Oliveira@synopsys.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> What kind of change are you looking for? The example was introduced by co=
mmit
> 04606ccc84e3 ("i2c: designware: introducing I2C_SLAVE definitions") that =
says:
>=20
> - A example was added to designware-core.txt Documentation that shows
>   how the slave can be setup using DTS

My fault, I missed it :(

> So I could change this example to instead use a real EEPROM compatible (e=
=2Eg:
> "microchip,24c02") instead of "linux,slave-24c02". Would that be correct?

I think this is Luis call how he'd like this to be changed. Given the
current discussion, I'd think it must be dropped entirely.

Luis?


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmUS3QACgkQFA3kzBSg
Kbb89A/9H2tev7C1gPCzlYaBpPCX8yfHKyoSW98UXSSXzdnHxK0ZlO8ynnroLeyJ
JvqwpUUJx3gG3Hn3v3TTNcmF7UbVTFLGlfm67xPmYEXfl0QJPsrCXbFTovnBoX/u
4t+iU8Uz90QcrJcvA/0OszS8+pkxseYZXQsHGl1fDfcrXSggbIDIBAp/pIiB3tcM
eAz1vDS9xgBy284Ey9wtWtL6xHTfat5dYcTeR0fLa+pWYyetL1NXAbD3wP1L4udH
JB2WT6PegJg4cbQJ370BQu+PmC6ipojHDIsFQFpXhiHT3P9owQH8BTctWzkePFI3
hCAB5c/Grpb+dsuZPsxAGI3pMGxzEeVHoeIikuuiijtIxm1BFgyB+9jILbLgJat2
1FxF3yPHmzuXQj1qme2bVS7TkcfVSYrcftw75Oljx8TL+HEg6+NiZJC0yq+3jGFN
cZfVih2HhalrhcTorEgFYeZJVX3lx5BX4qf9s3lI14O9rhecKVIN+qNtrTcFbJpx
OwzsVdn1seWL6uVSP362m+fMvT+AWASwV/G0Mhh4MIyeQNIJ1TTRC03/gdNjAikS
NTdwba+fxgywcaPLlN/8qHQPSu7d4vRtILfzMfXWTKTnb5G0GoocVJMXm9x58Lwb
+/X1MnWbpONYZcQRPUtwi+tIC78ysYo+hDg92Os+hG0jyW6RgE0=
=NCFi
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

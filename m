From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c/nuc900: fix ancient build error
Date: Wed, 14 May 2014 18:27:25 +0200
Message-ID: <20140514162725.GG12911@katana>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-11-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399560990-1402858-11-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan ZongShun <mcuos.com-wSZih8+RwX/YtjvyW6yDsg@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 04:56:22PM +0200, Arnd Bergmann wrote:
> As far as I can tell, this driver must have produced this error
> for as long as it has been merged into the mainline kernel, but
> it was never part of the normal build tests:
>=20
> drivers/i2c/busses/i2c-nuc900.c: In function 'nuc900_i2c_probe':
> drivers/i2c/busses/i2c-nuc900.c:601:17: error: request for member 'apbfre=
q' in something not a structure or union
>   ret =3D (i2c->clk.apbfreq)/(pdata->bus_freq * 5) - 1;
>                  ^
>=20
> This is an attempt to get the driver to build and possibly
> work correctly, although I do wonder whether we should just
> remove it, as it has clearly never worked.

I'd go for removing. For this platform, the last patch which was not a
generic cleanup seems to be from late 2011?


--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTc5ltAAoJEBQN5MwUoCm2PgwP/3OQlPYP7PlfTFovjqujX9i2
9AnQjjazSvwk2lHbJVQSZI2PrEYq/FuMlaKwKoDmh2j92MEc5ChgCcmOQusVApTQ
BkhSag2qUSB+Cv4l6BqmsC5XkNWI1+4pYVt7FgsRVyCd5ay5Kv9O4bYZ/EtZlrRH
lx5Aw8tAkL0bsllrck9VDlNBWDkx65OEQRPBelt45R0jdHEZRwVqYc6ASgvR56dr
TgXxnclq18ftG67IbeTNzbbGzm5TLbZ/upftz0o39j12JV6AH5vsuv0F7Jv3h3ni
N3I2wxJN5E670RbGmvGHuV2saVD4NTPEsBVn4r0/hKwzu+HID3nO0OTE3/iGDAAF
ZxAka2AaSCiDjNTNNapp9SWKv2MzSlPzefektBwI6KZcEVMANAzHhbq4Cn4hbil4
qpLOGUlkKvKEOoSmFErkgB4gpHJtMJKV6o1KHJs0RfP9rYDzSWW1/IjQEzRJ1/3t
FInsQV9LFidMirW7pkUVykLnLEDnEsAp5qRbEm1jreai+0dkIyF8hm0cV1Kzv4zT
SClb16hRTUomQG6CdeftcnxOAV0IaUPUVMayEKWqBbq43khuS4qe7C1EVuYHeOUs
bkwIIkHiUp2UVCx6pV55b/PtShRh8Y9DHsuj4nyWiUYDMktFkQlZRNziXl1eux35
hYMlA/xVbT75VQwTJzgt
=Xm4p
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--

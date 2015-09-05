From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: fix compiler warning
Date: Sat, 5 Sep 2015 20:13:51 +0200
Message-ID: <20150905181350.GA2612@katana>
References: <1441476310-11162-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441476310-11162-1-git-send-email-michele.curti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michele Curti <michele.curti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05, 2015 at 08:05:10PM +0200, Michele Curti wrote:
> Fix compiler warning when CONFIG_OF is not defined by changing
> the 'mux' parameter type in the i2c_mux_reg_probe stub.
>=20
> Signed-off-by: Michele Curti <michele.curti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks, this is already in my for-next branch:

https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/commit/?h=3Di2c/=
for-next&id=3Da05a34e7f6ff4a942186e99932885b10c6bc1d1a


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6zDeAAoJEBQN5MwUoCm213wP/Aypm8C3aM/eUKz7R7UE7N3T
v/7XyAzfxhCe9rGi+jEJanlXdoViVHevr/H8Ln+ZJ/DDQKpEg+UsCToOJTzzI3oX
pwmdQa96iOte6O9aWw0HNQXsnX6ZuHKH2fhpQYMEU6WEz1GEm+/Yp8OLrhaUIohB
ZUz69VJLWXRfWJT/UIYS88QBtMALBGALZUbTLVklCerf7oVhWSghueO7GCAHD0QK
/zMmnJJUQcy/PyQFuqpFEMykZIno9iK/xDOqHi0XPfR6qwFRLLmKEfGL8FgsU2L+
aWFOuDEWvG6rxNfJgBpaw0mC/s9hPQfeNbNUg4O2+sIdIJiahDVle1Zk8DGRtUmZ
hJKfVquiQekl2cHljKtjc8YvQ2bnNHTavzW6nrFvDBmngVe11gIxKFYYo5KhDUVF
LVDU4loWRp8noTwB7fBRADtpitboN0R1Bo2zSq1EK9V9LGbyzlL/62iCKuuKTCuF
FwLaTeafIfTGAeYLpbep0Smu0cIZJtQvxk6LqY8/9+corlYXeIE7I7n9gxJ1Q8b1
f2EHUjGn7jcL1upPeclmt8I/sxfIR/JaRPZnRtgpuUJQvyiorWLKYcHDpsVgNI3q
tJjmW5dv+5xHY2zH0Ub7QWVcuayVfHm6jDqmv0n3PjJutKHK4p6zhR0hCEyn2LXy
ajIzNZwVGTGwR1na/WTE
=1+XZ
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

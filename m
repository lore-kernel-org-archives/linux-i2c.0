From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: sh_mobile: I2C_SH_MOBILE should depend on HAS_DMA
Date: Wed, 17 Dec 2014 19:29:15 +0100
Message-ID: <20141217182915.GE3981@katana>
References: <1418650624-28174-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418650624-28174-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2014 at 02:37:04PM +0100, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy:
>=20
> drivers/built-in.o: In function `sh_mobile_i2c_dma_unmap':
> i2c-sh_mobile.c:(.text+0x60de42): undefined reference to `dma_unmap_singl=
e'
> drivers/built-in.o: In function `sh_mobile_i2c_xfer_dma':
> i2c-sh_mobile.c:(.text+0x60df22): undefined reference to `dma_map_single'
> i2c-sh_mobile.c:(.text+0x60df2e): undefined reference to `dma_mapping_err=
or'
>=20
> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Applied to for-current, thanks!


--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkct7AAoJEBQN5MwUoCm2kHIP/08aq8IEDCGmfnuAn5A+3a6t
C1fspkLXZ5MXGVM2Pygtu24CT5cmJ+CLGBQrNDu6zIShq1nRCtZOrXAqaNTWCadO
vzQyE1RRXIeh9dlQdKx3q75P+4KB8c5C1AL7OEwqNMM6W90vARmZf8NAwMSi4scC
lLDUqZttEdyL+CQ7bUcVjyYvUhPIbFFQ10daPo/71xC2VyB/EyP+AkOL5MiCbKQW
i9AhKSKoK321VTB7c+9BPJTvSty/lA6mJ93PDVlhuGQ7iF3b5/0Omnv34o9FNBRh
8bfjehmfnJAZ8JvJut4Ptf2m20TzQ5CQj9oiop3lHqaXTH2DGPebNvaHrJPUzX38
7ndwUEkt9vOAI48d7dY2fIqCJE/xKJNL71j1kqSzDIUkq7tDn0vWfat3A0Yqdnf/
IP8aIRFmEhHhROF8aym5mcmkBRBwj5COAQEyDB/oHwyIomaVOcYK9TzmWaGnw8lQ
xV7EqLziKOxrepLm3DC8a3Xid3uZ8G8UqrcrR1lUlehNRUNlqpjwrhhlXL/kvrGs
mYMaahW7efwdjWThkAY4Dh8mnJQPY9RUz6wWKUzel5vP+agChxdfhzV0CEswdeFG
4+83E7H0djKVIGj1ydS/ETxPkrZ2+/DKZZSVABTgEhDVeQ2mYRME94R0uPcq5pm0
BcwOzvy3pJp3y1wQeGm+
=ilcy
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Mon, 30 Nov 2015 14:58:49 +0100
Message-ID: <20151130135848.GF1513@katana>
References: <1448351007-4067-1-git-send-email-clabbe.montjoie@gmail.com>
 <1448351007-4067-2-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448351007-4067-2-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 08:43:27AM +0100, LABBE Corentin wrote:
> The simple_strtoul function is marked as obsolete.
> This patch replace it by kstrtou8.
>=20
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Tested-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Applied to for-next, thanks!


--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXFYYAAoJEBQN5MwUoCm2xpwP/0+Mp+HrsXWpR6sa/O3j/YNa
9+0FRhnSmgJqsOawkJkzoNKI7igYOlmQCTbrM8/foOEOOaM3xz01v0+0mJLcs+ZX
4hDH8nePNgCbdxwnSAv/VeljvYS+SxsRHgeZFWCgHt1QpX70a9ywSWcnq2O8Kx4A
2vLcv7NxqoVEiktMGq87rb/6tPjqZw4UqTatgZKG0tyB9CmFjvdIHxuZZc/Xiu2v
WHgcqCPwaRRc3HNodoNf4IdZCmiCI+xQM3Bia5qp2Yfqp65IH1C93nbK7REht7Bq
Ch8PVPcy4Ih8U/HUbPqqBQxVFg5qszPJleS06D6X1DQqPdrlOswriBToa1v+oTT2
IzxGdTP2D8dKmklDOhXtulyUYf1wcCEA770FF3tGcchcAp0/BW2LPj8c7sEK1aCy
zkWRWJv4E4CsQcJic3hhxKEyTbFCB+4Cyr1zQVuHFOrHKi+glwPxr2BWXu56xoWH
dVs2ZJ9zt/3GNMv6SRrc3jdXT79otPGu6kTC4dXGrU3ArsCB03RmHDp5M7MBkzFB
WrUJW74wpQdg0uuTfQ784kY6CZyrBM37YNvT1rcjEcl+M37Eul6UprPe2tQ0TuZW
2rCPxACAN1g4swteu6JgGazVeGI4D0dcURzueuD5Z3c2qS3u7qBJwg7w4uf8Q68Z
Pw3FMRdvk/J67hpbatXL
=n4s8
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--

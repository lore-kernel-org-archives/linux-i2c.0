From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xgene-slimpro: include linux/io.h for memremap
Date: Thu, 15 Jun 2017 15:57:40 +0200
Message-ID: <20170615135740.fa2g5wbdwx7psn2w@ninjato>
References: <20170609102937.3054567-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="quiyfmjhm7ora6no"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170609102937.3054567-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hoan Tran <hotran@apm.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Tin Huynh <tnhuynh@apm.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--quiyfmjhm7ora6no
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 12:29:12PM +0200, Arnd Bergmann wrote:
> The newly added support for the pcc mailbox fails to build
> in some configurations:
>=20
> drivers/i2c/busses/i2c-xgene-slimpro.c: In function 'xgene_slimpro_i2c_pr=
obe':
> drivers/i2c/busses/i2c-xgene-slimpro.c:516:25: error: implicit declaratio=
n of function 'memremap'; did you mean 'memcmp'? [-Werror=3Dimplicit-functi=
on-declaration]
> drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: error: 'MEMREMAP_WB' undec=
lared (first use in this function)
> drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: note: each undeclared iden=
tifier is reported only once for each function it appears in
>=20
> This includes the missing header file.
>=20
> Fixes: df5da47fe722 ("i2c: xgene-slimpro: Add ACPI support by using PCC m=
ailbox")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-current, thanks!


--quiyfmjhm7ora6no
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllCklQACgkQFA3kzBSg
KbYV5g//Y+2K+zHo0fCzJV9fwf4TocQnXiv+Ga32x0TZpf9wipacS2vldNOx4rZG
YtaPvpNAuNp/AB5oYxaQKiMW5GUom+iU9lrT94PAR7ngmDjZpburdB4oMviVZIks
rmbIakQZQ7iW+nZXvJFMhBQLCXgYg+yHGoIzO/AfhsDtNz0B/CK1VbfrlGFKwyIw
wqk5DqtuBdanWkgimajwAjb6X01Kjtfz+BJDQsojcxktwDs+OcgRIVxQj8nmMOeO
KtFs7ExYmHdiXJUJmbPPjX72ejozWoPTkC1fFbuw/R1zJum7seh/B2w/RaKp+MbJ
GqKgG28juMGbEKycMH3RrUQy4C9/up3qAs8+EfcaZQPHPYav1qXJJJbl/KwrJBQt
e76QqCuuyWv8YZNCfXfg+xzuC8iujOw2+wpgaikIsSVvgCxbE3TipS6uU/yZrm7C
6CMHDNu291EJvw02uYynf8eSZVtWkHP5ZxfplJ72c6AU+SGZ23aSsqlTIHVpq+3U
fJSWMnl8OhXOEW7vdGpk07ie1HmbuZZ2Y9vzc+HA3OnTFcJouckY5WWJywaoScwd
cazdDE3BLbTeTh+iSHSpK4HZv8apgTsa9ymT8zeEc17RgjJhqVUEZRWOfk6CB2w5
byXRyuzq0HOupFiRfJmxj9oxiKUxTJuseqAkofSWrxgXgjhGxhY=
=RXcz
-----END PGP SIGNATURE-----

--quiyfmjhm7ora6no--

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ARM: dts: renesas: Convert to named i2c-gpio
 bindings
Date: Fri, 1 Dec 2017 12:09:08 +0100
Message-ID: <20171201110908.u7xjrt7xmlqgigvy@ninjato>
References: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
 <20171201081850.4tqbnlvxdax7phfs@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ck437fd46wd3ogsg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171201081850.4tqbnlvxdax7phfs-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ck437fd46wd3ogsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 09:18:55AM +0100, Simon Horman wrote:
> On Thu, Nov 30, 2017 at 01:57:22PM +0100, Geert Uytterhoeven wrote:
> > 	Hi Simon, Magnus,
> >=20
> > Commits 7d29f509d2cfd807 ("dt-bindings: i2c: i2c-gpio: Add support for
> > named gpios") and 05c74778858d7d99 ("i2c: gpio: Add support for named
> > gpios in DT") introduced named i2c-gpio DT bindings, and deprecated the
> > more error-prone unnamed variant.
> >=20
> > This patch series switches all Renesas boards to the new bindings, and
> > adds the missing GPIO_OPEN_DRAIN I/O flags, which were implicitly
> > assumed before.  The latter gets rid of messages like:
> >=20
> >     gpio-208 (?): enforced open drain please flag it properly in DT/ACP=
I DSDT/board file
> >     gpio-91 (?): enforced open drain please flag it properly in DT/ACPI=
 DSDT/board file
> >=20
> > Patch 1 was extracted from series "[PATCH/RFC 0/3] i2c: gpio: Add
> > support for named gpios in DT", hence the v2.  All other patches are
> > new.
> >=20
> > Note that after this series is applied, the i2c-gpio buses are no longer
> > detected when booting new DTBs on old (v4.14 and older) kernels, which
> > should not be an issue.  Booting old DTBs on new kernels is not
> > affected.
> >=20
> > Thanks for applying!
>=20
> Thanks, applied.

Phew, you guys are fast. For the record:

Reviewed-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>


--ck437fd46wd3ogsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlohOFQACgkQFA3kzBSg
KbbNcg/7BrCh9DHg38ctotuB5mbxfvNcmlIZFwUAMuJa+IrC/xuQq+1499+z7zHa
VrIdeRdXZdaoiv8/2JybkA8esBASE/G4DN9bvuT+mZvw52OiMRt+pm1P+O1nYF0D
fBNQkfRRH4/DHP8jIynPHrC2ZX4Xjw8oMgkQY65KmNzQZS/VXPMO1JCCds55TKdv
PWu7EpWo5yXMQk5JrPJZZQTcqDFEMJFFxvcIzGVOICguowBUziFl5Z1vnuvTpHzM
jzvspg5qJytE1Rfu635lH0UgFQmkPFcSTrcT7Y96/hGQvDypvrZTkMQ24GExBjl0
VZpvDVd0nSuYG74ZlgOEt6bLs3d6+0hhWEL2r8o2MJYlIEwwhhpmbnR6RlGvuI0X
jDpT/8Q/aLtDMF10GX8mBj2EMYWrTl6fMXru6bgJbJsSOzT18H6mRbvrD4FmluS6
pMCIMLdSdjc0beajJz413UcJ0QTk/jy+fS/D5jZ6ov3UBKarVMQ8aYaGscZ1Tjld
ZrttrFYr5md9bb4FYRC3npVSD8AM9y0SrHJ/Fg7xFILuwB4n6D5KaAmExBa7uega
4Mze1N8QkMCwCDi/KjFJQb2YRTy1l10Hx+TcoXYjmdTesuO9Gw7FWzWGDrww9jKY
4riKhv2GH6vkLOWilJwDD8Gll6NbXlmt+ntPyv8yy49iKwtoBfk=
=TCRk
-----END PGP SIGNATURE-----

--ck437fd46wd3ogsg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

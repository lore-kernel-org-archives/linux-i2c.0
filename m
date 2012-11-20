From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-s3c2410: Remove recently introduced performance
 overheads
Date: Tue, 20 Nov 2012 18:48:10 +0900
Message-ID: <20121120094808.GE10560@opensource.wolfsonmicro.com>
References: <1353391041-28943-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGS+omAkOwq7m_zGCYjwgrFY_jjNfWqvFqS29F5b6GBPr62UFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6U+WTAJHBcf3BHs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omAkOwq7m_zGCYjwgrFY_jjNfWqvFqS29F5b6GBPr62UFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--i6U+WTAJHBcf3BHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 05:45:55PM +0800, Daniel Kurtz wrote:
> On Tue, Nov 20, 2012 at 1:57 PM, Mark Brown

> > +       spins = 3;
> > +       do {
> > +               cpu_relax();
> > +               iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> > +       } while ((iicstat & S3C2410_IICSTAT_START) && --spins);

> Can you avoid one cpu_relax() by reading IICSTAT first, and switch to
> while { } instead of do { } while ()?

Of course.  The CPUs that care about this are single core so the
cpu_relax() has no effect on them anyway.

--i6U+WTAJHBcf3BHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQq1GvAAoJELSic+t+oim9aBEP/Ao8or10zK9EIm1m+VMs7Icq
bGBzs9pvG8z1t51tFI8oDjxze4qwKa7VHb6hKntAR3a1ir8nfUV1PBSQ0ioyEJkg
LSfLmSsPdyYPnitcn+VnFvuXNqK5WtpMC7iggALLR0gXG8EM7YdBRk862fRvVItN
01N6AVk9NTlhobGYmDfgpdwkPdjyxFTwZK+XkMVhaVxnTMhAujz6+PW+uTil+zQv
TttFkn/3aWC28HcfM0wzFlqaR9KfQhf42vsSbuwbph0FgQbFNFnGg/uBY+luGBHf
bnKqZ7ZokHSpBih05LNiEe4TCFi1Yr/bp2AihBHLhH2tUg6lPHKPY6nn/Gfn9zuT
wk/aw8gYyJOIsbz5gRXf2c+Yb6JZnGJN/Ny4dICDlgOML59EHqmnCiTaVmpr2+OG
FVL3ATWqZZhA1Crogy72wRWUkvMdu3q4MuZRG0qptVYm2YZsHuxpJ6f8s322d7lg
dQIqcpI/7jAadjWqSCcHvysUQ1e3hkQPo+3Hechy6Jgm7LuaXULfb1O0Gymc3YFN
oWQjWAaDjtMEip6zG/MuCPY7Y/FbZNzrBnb/QN0fABLxR4xR4yAtzhogc/HFWQlx
8OmyUtFbCMGHE8rB9wL+X/MPQlDwaZgQMuRgarn0juPf98Bc7RUQYYT4V6u2KmQq
mk/1A9UgtvlRk4JUrjGu
=2dm7
-----END PGP SIGNATURE-----

--i6U+WTAJHBcf3BHs--

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c: i2c-st: Update i2c timings
Date: Tue, 3 Jun 2014 09:59:22 +0200
Message-ID: <20140603075922.GB2653@katana>
References: <1400254330-2547-1-git-send-email-maxime.coquelin@st.com>
 <20140602163103.GJ2654@katana>
 <538D7A1C.5040409@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <538D7A1C.5040409-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >Can you give names here? Would be interesting to know since a few
> >drivers implement the minimum timings.
>=20
> I don't have the name actually.
> The request to implement this change came from hw guys.

Can you ask? It feels better to have changes based on facts.

> >>This patch adds a 10% margin on all the timings.
> >
> >Is there a safety margin or do the devices start to work exactly at 10%?
>=20
> 10% is a safety margin, I don't know what is the limit.

Which also came from the HW guys? Please ask for details why 10%, too.

Thanks,

   Wolfram


--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjYBaAAoJEBQN5MwUoCm2Cb8P/2AtAJPoxu19keSL/rBew3/d
D4FoYT+qUkfxfHW+WBEcR+Y+AaMnvJcLUBV0Vj2ek6RZSs1xQkTX2VYR3R8RK3K7
NesQzwz4oI9gvbUcj3+RnoiDFol+vCGCIQr/04BnI+Usj6Ryyu44A5tFNdwH3sH+
/6jQDaaxfCkxuBMZIYJkL/XRt06H/e4OAhaPtcT2zTR7LhgCP7QprZC+0Akb4ce/
e6YyaS854p/gr/e625C4k3Y6UcvXVW8JK9TAyWbT/kNfg3HQSK7tjLiTCdaoPocy
jPvYX40VKrY5PvLzr7KTBAKiCYEQDewEqkbHKu4rMMgBZgJxvV/XXPasu1Kqfl1L
nAjBX4JEQLVnGClRWdzGuRrYEqGAEhqonWi8UTcoOxblkpDL6+ZpXYPbPtFRv65z
RxiTGY27Mla/lfYR0W5ZHZAnApWLvMApMWm3syRar2NNfICBo8+jJtBxDFXrLkQD
aRNdcwXTQ1MZqGhSCB6x1VJPYw6HZddheUJXOOpUPrlaNvz6j/qay7td93QuYr7g
kaHbN6KAJjYccSNpZDKNAQ74Z5U4jK3eDNJJ2zn2o7twYl+5czTFvFV2DgfZvtrz
CA7fU91isnLpC2duyxiZu9XuxwpdnPLj+IXfw0jzD5/e8Il+RiJtdoYyH7xw1E5Q
NLk/z3dt2tq90n8xs1xq
=LKpl
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

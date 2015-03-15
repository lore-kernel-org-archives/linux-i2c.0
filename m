From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: match wait_for_completion_timeout return type
Date: Sun, 15 Mar 2015 10:14:56 +0100
Message-ID: <20150315091456.GA3393@katana>
References: <1426010893-8921-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426010893-8921-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 02:08:13PM -0400, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int.=20
> An appropriately named unsigned long is added and the assignment fixed up.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Applied to for-next, thanks!


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBU2PAAoJEBQN5MwUoCm2UpcQAIdOAgJZwWs4+WAtsLHCv+fV
A9jnJs4eWXviD73rkazUu1OBQ4rAzM/esSSEaE7LNChmpYo0y8QdZHxG28JmoTzp
DRszI1TA9QENds+07+c0b+7PrOn7SMK+zcKF4K2FLNhWkXXr9He4SGhtTFpLb/+z
mk2behV7u+cKPGYRu1tHpLHiSjLSXUthUv+amK+Z6wUNi/62RtUfMH+BsTcusiZ5
yWOTsdB1hu13xsLs5uc+qYRBtl+kkuIpukyRWZOY9mVIqVocCneHwXvVD0wG5DKm
rZ0zhQl4VFJUX/6e2nWr17dImzBxZbWAzvFEPV5uAzgTbC6jkdLfPWi6o1e0cAFs
xFI03a2NeuyySykkVoKAcWdK1m5nT5WVyuNFE9xkcH1oMHTdJKkc6CGoUU+SwagV
5QG6u/b7UnCSKhR8fOvbXyxWSHl1XkTO7+GSP+hPb4+tuzReUCsyn5AJ2JK/Sdh+
PtlfZOzUGl3jZskA17282Oxd0QjcIrgIfsZJ+qidHf9dk3sXPfuIZkFMmfMmiRhK
G6pSOyvVdpPbI4bDNvWgN4g3PDi+SHSUDGZu9YbTviFm4C2dwSQfdbA8GVDHObA+
Sc/6p3Vx678S/ferYtldYZjN7ZlXWPW8cW6WHwkzu0PFw0M8Hr8VnE6ljxlcs3r/
eNxDY+bq1paeoNDkjzcd
=koHs
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

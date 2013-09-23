From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix some build warnings
Date: Mon, 23 Sep 2013 08:59:22 +0200
Message-ID: <20130923065922.GB3051@katana>
References: <1379508652-30348-1-git-send-email-treding@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379508652-30348-1-git-send-email-treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2013 at 02:50:52PM +0200, Thierry Reding wrote:
> Some functions and variables are only used if the configuration selects
> HAVE_CLK. Protect them with a corresponding #ifdef CONFIG_HAVE_CLK block
> to avoid compiler warnings.
>=20
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Added marker to #endif and applied to for-current, thanks!


--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSP+bKAAoJEBQN5MwUoCm2rrIP/0/mRceblc3ey/BupYlirqEN
WdpeRmJw9tp+QHDNsh0QvPNkeVMSiyOgo1XBitPrxBg4Hs4Ldd9jnFtW89JHJvqg
Y09zw3390nzlr0dQ4juwydcl61VQg6bH8PUtaQSsv8gFQdwIhv4XPKECy8oSIVjr
45xbSu6JHTZ9H1EQkX730GFM7LzW0FI/FIY5QoV81S/TNqLh/GWNAFYtud9dF+z5
x8vOuNX7zpreY6/gZERy0PtlWlREQqUp1eBOJ+DpC/TCQLfggD2l7SrNsOLEoG6W
lYP005l+wURKY+UK2oSvsD7XFkJ7yKnfOAS9yYYcBeZgsnkxM+qKQMiScIP0oRIC
XdUFGGR1xw5tTG26wFDw++wOO9RKOvNzUQqFRQnc/KJiMUezuS6xA6nM1TGIQWf4
KQbquQBnNqjzkas0uV0BzOUymADQj8dPqHNo5Rh0H7F0erd1XeLZL6f1W5HELFbo
e9ZXIwZCoNbQGjCSMqr4KLXaCGjoh8pWPcKI702CjVdjVPfhyIQxuiVhk2JftFit
yu+Rjkzd1MMrTN+R+WUwniLKdnxmTtfWWJVwpqR1WKiThZJbHGychulVMj5s9Kgd
hlIDSkjiwwUI8yPs5CUO0arzNfXOOeYahYgu8BqWSR/M+jlUZm3GvcbLIknbntls
NmKt/5FvqUy2LZEcWViU
=ZJMT
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

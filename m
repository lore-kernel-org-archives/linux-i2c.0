From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Tue, 11 Jun 2013 09:48:27 +0100
Message-ID: <20130611084827.GS1403@sirena.org.uk>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
 <20130527121658.GA3660@sirena.org.uk>
 <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w@mail.gmail.com>
 <20130610134535.GB2987@katana>
 <CAGsJ_4y4svi0TbUKK1aAW1McM5rFoo5Vb9rGPweq-sHJ2NN5cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctZH5Gqgrl5HoVnD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4y4svi0TbUKK1aAW1McM5rFoo5Vb9rGPweq-sHJ2NN5cQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ctZH5Gqgrl5HoVnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 09:14:41AM +0800, Barry Song wrote:

> the mainline idea you mentioned is that you don't care about any early
> device, which means some devices want to start earlier than others in
> some real automative user scenerioes.
> but i think another important idea is that mainline codes come from
> branches of different vendors and serve final users of those drivers,
> but not only make source codes no difference to all environments. the
> auto users i2c-sirf serves, here, actually means some differences with
> PC/tablet/mobilephone. we don't make codes good-looking by losing
> functionality and not close to final users.

It's not that people don't care about these users, it's that people
don't care too much about out of tree users.  Part of the goal here is
to convince people working on such applications that they should make
mainline better for everyone so that you don't need external code to
make the kernel useful.

--ctZH5Gqgrl5HoVnD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtuRYAAoJELSic+t+oim97VkP/AjcROJ2GxWBgZTWmv6TkHne
/bXfLmsveh/8ZMj8KwdLwGCGm+53wMD0LdsVNY7w3OubnYams4+rUKeqE93Lzcs/
3jd3V3GINwMoPsJ9qmvFdt+H44hGzr2RpRYFnrMtqr03gtuX5Sgn2abdlArNuIqa
cOE0gZayU1YFr4IcgutJLEIap0K7bdrW226XlBUK/mQqQmNx5k+DUosXwTJZeICk
Y696QDnUy7qHxYda65gEps9LSjXo9suibNY466Wln3rlEoshUdFB+BVM8Vj2Dws7
6QbDC4+doZ3zvw8gWZlB9NdUUoJp3pIHtHvMzZEWyvJOypGtiSxtsmrpe34wgAmq
vbEGhkOpHZGSjz1k/ccDbRRUPxJKZrjVPJngHzRKuz8A+oNqr4i5GvPbNa+bqIjs
T5gsgHHi/ES+uy/cERYKq3vHiel8Ez3wxO0QdX2hfUy8MVBaNyMHvqlLHdQ8c7Jm
nqrijT2USJpL3uPVKvzJAGkL1K2nP4CW2nt9+dusbrkXS9c/oe2F7pq/3Ow+jr1j
YlrkI9I0wnNTCrER0oejqyAKFdLHDT7ZsVXtA5rEmbI2aIsdANfvJb7MIWpN/aTT
uiziOIWNjxNJb62piYsXCt/iMuV1crF9ugb9g2pHBWZe5pgz3J1D7QnLi65yAIsD
uZl++40QDV5o+jOCsHWM
=GsoD
-----END PGP SIGNATURE-----

--ctZH5Gqgrl5HoVnD--

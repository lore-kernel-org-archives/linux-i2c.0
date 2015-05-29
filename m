From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [alsa-devel] [RFC] sound: ppc: keywest: check if DEQ was already
 instantiated
Date: Fri, 29 May 2015 20:06:09 +0900
Message-ID: <20150529110559.GB4282@katana>
References: <1432397711-3186-1-git-send-email-wsa@the-dreams.de>
 <1432631974.85649.YahooMailBasic@web141501.mail.bf1.yahoo.com>
 <s5htwuxb1h4.wl-tiwai@suse.de>
 <20150529105020.GB3168@katana>
 <s5hsiaf6489.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hsiaf6489.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Elliott <txlitebeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Do you think from which stable kernel version can this be applied?

The offending commit is 3a3dd0186f619b74e61e6f29dddcaf59af7d3cac
("i2c/powermac: Improve detection of devices from device-tree") which
came in with v3.6 if I read correctly.


--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaEgXAAoJEBQN5MwUoCm29EwQAJlAm6rwP7/KulvtQ6DbnSkY
hOhSvuFzZDfkYE/j+oBsgvflqs9WeySZmCctqTABJbEe9HcbZXk6O28oZ7olo8PZ
OG+vDxcf5jl4e7ilsbhAh4rLGY2qV6NGM4FSVhrsDN8mwB8SMV4ibgAc58q+pL4z
Yu5JqjBV88TQqS5CDEfK4p+X6Pu90DxBfBJdaW9Pr1oPsX7PRCViNt5e9s3PtETS
WExeU7PeRrWofYdrowtiz+XDrvRae0gY1A5J7XQueJCdNsy/pwiX3mUW5fvrSoUc
5ReA/PoFIuVud/QDGIeWckwfRSze+3s7lhumOmEBUKwXPbe77hXrftFsURVQxnz0
wHwt0Uu+sbNJgDFFnJNnuQCCS9cPPPzZRl6V2yC1yY+KTHUYzCZuHMpA7viATmMC
Uu2+nL/1ucESdJa3DN6fmi5hGHdHL7wQlv7/fA4zuOW0LFWGzEfJ9oijOatfck4V
kXN+ftAVp7PfLhsFvCqZZAUgx1xwlLncBY23fJUiLUG30zbBgc2ib0kgfBpiESGo
FNYsOAlJhQnmSuHsbC9Zj3ceiscgNamHW3duCi9khBGjYNEaoWkrgWR2/m2bsZnJ
qH4tne14DJ7fohkyIJB43CIoESLJYbq9b7yU70vshOSN+wO007/NZX8avLWq32oX
nLb3LQ02giOrUxnvgllE
=+uBG
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

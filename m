From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: i2c-pxa.c: Fix for possible null pointer
 dereferenc
Date: Sun, 29 Jun 2014 12:47:22 +0200
Message-ID: <20140629104721.GA2681@katana>
References: <1401831034-30255-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20140627122147.GF2641@katana>
 <CAFo99gZD7GvY+moHbvRZxG_M_n91=2DGvdEaNBMoYBgomAN6BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFo99gZD7GvY+moHbvRZxG_M_n91=2DGvdEaNBMoYBgomAN6BA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

please *always* reply to the list.

> So how do you want me to change it, or maybe it's not even meant for
> me to do that?

If you want, I'd be happy if you do it. Tests on real hardware would be
needed, though. Do you have one? Maybe somebody here can help you?

An example is commit 9b2b98a3b4de. More details, including a list of
available functions, can be found here: Documentation/driver-model/devres.txt

Good luck!

   Wolfram


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTr+65AAoJEBQN5MwUoCm2joYP/0dml3zEJJqROj742ZzoRGKo
Tlo6XyXWfGOOqy2Go+qHpwd4lLo9Q37aL/6ih3AmNU7t/xyMcrlLmJvtGLDCeJFG
hDmpf8g+fwil6cgduCJFxyhJjJclefB8jG4N53CcSSWQ8CqC3NvcQ+HHgN+9caNq
qwZsg172UZC6gOwsVn/SQGhwB+EQzC6QOlTUlju2TAKwXCb8wc2DnC0wxPZBlP2s
WRY0Yv986VkDCIOhHmK8/cBkVczjyGv1e8CAYdHZbJAScY7WUGsG/Z4QzTlxP5xj
gCAQRsctZpGzubm0gQvlu2HWxDjGCOKJt0rhFQwulfDTvpX6ejrRjOXsz6UPhpOa
0W2/bXHjHpcfrhz9bq7ayzMz03LJ0Ppm1OcTsaOfFi2YzKbv8K1HLajswh1ljpzy
kTeg/QgUN3HgMKMQPB3S4MYejaE6j2Q/TrZpN2+jjX+qj/S80eK/dZzK5N3/WN7v
vd1g1i9ujIXc0D1sc2HlGLgaU9i0H54QPIakPo3Ff9ofk/Odiz0BMz6a7U82OMnD
M7RrSuiRbEP8/Emzl68cvERFkWYjyL7ubRT2EUpv3V0Suxswzs1+RBiQP7ePdU56
v45PI22ZeXRrwJdAh/fkgDcO1JcADi86Z+Svs26ld3A7qQivwz5xLQvT36+tevUW
DUhQtS7L3rhIoQBUZD8M
=sqkm
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

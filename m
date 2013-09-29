From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/8] ASoC: imx-wm8962: Don't use i2c_client->driver
Date: Sun, 29 Sep 2013 13:23:06 +0100
Message-ID: <20130929122306.GS19304@sirena.org.uk>
References: <1380444666-12019-1-git-send-email-lars@metafoo.de>
 <1380444666-12019-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kjwfQs4m3ZHLWJuw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380444666-12019-8-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--kjwfQs4m3ZHLWJuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 29, 2013 at 10:51:05AM +0200, Lars-Peter Clausen wrote:
> The 'driver' field of the i2c_client struct is redundant and is going to be
> removed. Check i2c_client->dev.driver instead to see if a driver is bound to the
> device.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--kjwfQs4m3ZHLWJuw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSBunAAoJELSic+t+oim9y34P/1yaB9IoWszQ9FUOORxR9cEz
VZnOE0uyMzkplrp4tNhWpKb6iplOP5HyHSSBxjvHRmXfaxmxMpxy+TYUVEE1CkP8
fil17lthI8NqQLrG5eWzteSbu16d8ulmb2VS+epR5/ExlPmsH3bzfV6P41kyYs8Q
nZXkaRm0RIN8GeaEtNM5O9BVAUOmHTGT/9ZiR+70qKpC3bN8gXaabPa92O6spauP
aIS9UT4539CkiwjGPzm4SkOwrjlHo5keLw5JN7cnroDNGEXRwNHto/pcnuel+/PB
0BvBSRw+ObwSytvjyANWto04B3JJxx+Ie07G9/lglcDspJQI1k1+KMcxfZXRIF/9
7fovtHBOGoIcgvmCc8ITPAhEhY9cYjYNp3YUUcn9UItTkfzYWmYIUt7wKyIOhRmy
hBvazKeWwU/K+SOnK63cznlr15KSEO7krIJMkNGmSG6Q19XKE0UMDXakQpR/0WRA
++q3RwQCcuBdtvHC4w+zhAAeqco0vAmqEiva3PWRuWzfDh5E2UNLr39VwF22jV3C
PS31QZBr/yWcooEMvKHWlmfvv2ZFCzG5XcmRq2Co0QINjdgTFjL+EtaJ6DHJkQCH
d7uQ0x2NAHdbSdHVq5qCHcVXWf7MgKwGoWkkjWd2Gh3xxsUvgjERLwILRyXcLZGe
zZ+FCSo8f9I48RBcDQCx
=ZBQD
-----END PGP SIGNATURE-----

--kjwfQs4m3ZHLWJuw--

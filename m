From: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH] misc: eeprom: implement compatible DT probing
Date: Fri, 9 Dec 2016 09:18:46 +0100
Message-ID: <20161209081846.GA1446@katana>
References: <1481219279-6982-1-git-send-email-linus.walleij@linaro.org>
 <95d9c739-8a69-b990-2840-b5381d54a99d@axentia.se>
 <CACRpkda+_0+y6U-gjt2ym45gi=KZ69hixMw6T=tAQGTGy5J37Q@mail.gmail.com>
 <806f55f3-3fed-572d-4859-7c7dc76c5e08@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <806f55f3-3fed-572d-4859-7c7dc76c5e08-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Many on the patterns at,24c256 and at24,24c256 (should be probably
> be atmel,24c256)

I remember patches fixing that. Since I usually don't take DTS patches,
I can't recall what happened to them. It might well be that those were
accepted and meanwhile new bad bindings got in.

> but also a few atmel,at24c16 and atmel,at24c128b.
> I don't understand how those last ones ever worked, if it is not
> working for you? Especially those with the trailing "b". WTF?

I'd simply assume it was never tested. EEPROMs are often convenience
storage and not essential for a working board. Also, for historic
reasons, they are often used via the i2c-dev interface directly, so a
wrong binding with the kernel driver might simply go unnoticed.


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYSmjmAAoJEBQN5MwUoCm2z/UP/1sUNQT34QvDguQjOWpI55Vi
RUxC9cLLh6ybP1p9HDY69Il2PDlIyCyCVtGE0pbNeq5iGq+hmKYh0dIMFmgFg7Xi
8ZzqjXR/vPYwDv1Tspb8yhfY0CX1FIWmCRbm0tfLU6HMqw3ATddw/sON+mU5qC0d
a4k+pjxIE84m60Nab5R14lUV+0Vk7vyb6ikPvj53t56hw6rggCC8QXKm1eVQw7lA
7F+dNR4Lk5/jGbePmoUNlzimYTVIOLsTZxy8LAMd85W8ITLZ7eGS8b0NG0uy7Z8+
dqOzfUGjGGvLHKDEfDCZfBQ/U7++wKCKgo3XFwR7MZiiECyAwiBIBOOEdr8liRih
M3IL0DsH221/ZuroGGoTqJtto8Jowh98IpEalpI95d0r00hF0y/COBcypTCt+uB4
elYKjtsNTKv+pbuMFusomIOxNcTTe7hzruyP8Bt3LqmoUetjtg09xycIKMe7FrjZ
bz0oLuOO4RNC4HuWENiDzA1yd4xWem+Oh+PFRgP/g46Ls3wL/Sx2NznVgbRGoXIF
la7SfAU+9RQcJU7n3CiXKu7zIXam8irtFeLv2mneSDV899tBNsaAnXc8dXHkl50k
4U/seOoj+nGk3YqJVITC3cmPrt++G9gg6rG5SVgu8A9s+Te/BjwnmOhTFaCVKgJ4
4nMUGyZpmLRLk0jggmfl
=/IDQ
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

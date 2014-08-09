From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c: removal of s6000 driver
Date: Sat, 9 Aug 2014 16:07:48 +0200
Message-ID: <20140809140748.GA2733@katana>
References: <20140521113029.GT2708@katana>
 <20140523131722.GA28143@curry>
 <537F8652.1090807@zankel.net>
 <20140524154727.GA20634@curry>
 <20140527223557.GA9594@minime.bse>
 <20140609220635.GA3329@katana>
 <20140728144330.GA31207@emlix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140728144330.GA31207-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel =?utf-8?B?R2zDtmNrbmVy?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Cc: Marc Gauthier <marc-66fqrpuXKgGB+jHODAdFcQ@public.gmane.org>, Daniel =?utf-8?B?R2zDtmNrbmVy?= <daniel-gl-hi6Y0CQ0nG0@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

> After exchanging some mails with Stretch (now Exar), it is still uncertain
> if the Linux port ever made it into a product.

Thanks for keeping at it!

> The good news is that Exar doesn't mind me sharing the overlay.
> You can download it from this page: http://www.emlix.com/download/

That is nice.

> Trying to build CONFIG_XTENSA_PLATFORM_S6105 in mainline will fail.
> Mainline never accepted all of our patches and this apparently led to
> two arrays being mixed when 759c67e87bce was merged.

That not ;) Anyhow, my latest pull-request includes the removal of the
s6000 I2C driver. There is the designware driver if anyone feels like
it. It doesn't really look like there will be one, though. Sounds like
this platform is a good candidate for removal, but I will leave this up
to you guys...

Regards,

   Wolfram


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT5is0AAoJEBQN5MwUoCm2a24P/36aH6G/aq509GHR3QXPGbqT
090hrCXbOKPrcaYa/kD5l0CTwB1Q2KfFTkBOWUSSTzyET82cp71znPf/TtLnBoVa
TovfAaorfUu3STWNC4oHuiFI1Hyshv+7LM4w7uYdUG/SQAK+6K2Pjl7tcGk8H984
ZYFOxzoUyeHYYUSa7kkfippFfCHi0cTNIf5JRGq/mEqbmg15twgpW6Lw9CpomSX+
qV8GVX6tRUaeZrOtxOaQnGaUMM7BtVzzamEGU82eIXDvok4mkdidrzYOqZzE/C8K
ba0EYOXDjLP7qJVQTGxDX5Iw3aaGHWUmvfju4YuXFzuDYLHJXKVR/UD5p7Xt3aj/
qA8QgA3aK3RroF+HXm7fOT4amjN6f6FcOK5Rf45LEQfpxmWkB5sEZm2yTYkIIF/k
cwDVk6mHNmAeVusjLjh9bP7vWRfZKVrWhqdVLvYhgQyQhOeAAfS9w74wA2WTXY/S
oo4qlWQQmwx+QcMD2VKRVJOz2Os3nDlJwVDqlDpH8yyDP0YLIBRHkZKafV5rmbd+
fsbWsRfzg7Gx3a0yzt7k6mIxKuS4rVD5KhHhd7loqAd6L66J9liGvzJIS1+c3XJD
S8QAszpvZZEhbNmdBFj/byTu3jjDrotxRH4VtoIf6/v8VIVb1yvWFiszsryFfDz4
eq74vkR6DrTOUQ0NXFrw
=K/Zh
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

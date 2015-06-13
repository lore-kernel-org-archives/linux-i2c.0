From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C slave support on Xilinx Zybo
Date: Sat, 13 Jun 2015 21:06:05 +0900
Message-ID: <20150613120604.GA3521@katana>
References: <CAMQCnXF47Kr3x3yeqba-me+N8rQ-vDJ6ziho5107qcckDbT0mQ@mail.gmail.com>
 <20150610143801.GB21540@katana>
 <CAMQCnXHfcgWpAS4HT=8sCt7RHA29xMK9KzAU6H0rP3RR7DLMuw@mail.gmail.com>
 <20150613094905.GA1682@katana>
 <CAMQCnXGQTQdXaOL5vT0ZbV-F_0P5qJ7kSQSHrMv49fMbAy2UrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMQCnXGQTQdXaOL5vT0ZbV-F_0P5qJ7kSQSHrMv49fMbAy2UrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Bakker <bakkert-Lqq7FYbpbC48+Wv5JVE8qw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry to hackle you more but I am still getting the continuous message
> (when the console log level has changed to 8):
>=20
> i2c-slave-eerpom 1-0028: uevent

I will check that next week when I am back. I didn't use udev or
something similar when developing this framework, so I didn't notice.

> Should I just ignore this for now and see if I can get the slave
> support to work or do you think this might be in an issue in my
> implementation of the slave support in the xilinx driver.

Since I don't know and can't test anything at the moment, I'd say just
keep going :)


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVfBysAAoJEBQN5MwUoCm2En8P/1s4TTjHIuJ3YfPhqs5nTm9g
uxlde2zzqWPXKkEEQguHsqq93B9SV2auUPHQbzwZUbHyiSM153P80wFvYXdFKnAL
Sh0KDvtv8UG//FhOdqezWr7uAMZnWX7BlYZgaOYlGwyNXGhq8Kxbkzw/J9uEbgrg
BVH8nzW4gBUBZSPqpnIMSF1PFHPsa4ACmQyyhPhLYQGkTjENuV3gBtqa1CGkmMXW
ToMNlod2DvwwtBtR/UYBsDRmbH9EQVwoAt7Xoc2laK/8UlCwDBEP/wME926emR9Q
pGntelAPta7DqGcHvh7aLDyDxnBKdCdlqyA6RAh1dK07njsGvBKPQHhiRNcW3iLh
l4QJqbRIJ7jbP/K2is9Gwkf8n7DD1AhGgMliivmZejXeQI4q9DQDdfy/96KE2pVQ
KyHGv/AKRyGfNEPHD5lNAIt/umvN6zbjUbyiKMkTVWOIrLghhtEimGdxmaKQlDrt
HOXVkCFKNRWLybaR762qZ2dAkvVXFvs62xDfKUWSofgaDbat6/MKvZ83kVooxB/W
3SUvdXT/ljWk//cIeGcnodZFRle7bvkofdRAJcuqDPOIFY6grfO2O8UG2WEVoHUo
7XLpICNSl8Pq4UVqyD7UcRO00slK+TWqk2s7Ye/diFSn7DIyZP/vGIMY0AKqll4G
pJXpQFop9myrLZiDT+x7
=tIgX
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

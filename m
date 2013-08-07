From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: pxa: enable high speed mode for i2c bus
Date: Wed, 7 Aug 2013 15:55:39 +0200
Message-ID: <20130807135538.GA2978@katana>
References: <1370587097-21006-1-git-send-email-shangll@marvell.com>
 <20130615144812.GD2923@katana>
 <CAOng1WTa0c2Jb9yPeynKXQ0K4-bPhrcGPsKd-AP-MuxQPH80Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOng1WTa0c2Jb9yPeynKXQ0K4-bPhrcGPsKd-AP-MuxQPH80Jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Lebron <leileishangchina-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 10:10:29AM +0800, James Lebron wrote:
> Hi Wolfram
>=20
>     Have you finished reading datasheet?

Sadly not. I couldn't find the reference manual freely available. That
was a problem when reviewing this patch.

> 1. High speed mode is hardware feature, you can't read it from
> software. It's similar to fast mode, and fast mode is set in platform
> data.

Yes, setting fast mode in platform_data is troublesome, too. Better
would be to introduce a new platform_id (say, pxa910-i2c) and to deduce
=66rom that id that only this version has high speed mode. I am accepting
the current solution since it is consistent with fast mode, but all this
needs to be fixed if pxa is going devicetree.

Thanks,

   Wolfram


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAlHaAAoJEBQN5MwUoCm2maEP/21Gpr61nax+5HZUxDfNRTkm
QmUQXl1P3QA89QLmAqRhGKLRr67emi/dMDp8ZTPQhYDYjaEggQt78GqHS19LMeS1
CfDZ0AxptgiqqSo+0SO6EQFWuBwDM0Nivy0m4E+O+5ESICZBbiRSuoLu7VtGB7Xd
c43LxnaKzbva6Xifsior9mt1qu45J1Igd+nb58R3jLlExTwyJ12JllCg+SvucHcQ
YfPaerfhUcBEA6p8y3TNTgErKhUB77YK5SUeQcvy+YgZ9t61VP0wCCeMEVR33BCj
tID6Sy0l/Rg75n96LyYiXgYSOpuVleGCr43dxJZdLnMf8gasLos6L8ub9PH9Oygp
qKMlBVis8etJC4e7fxGMlbD/V8qcjlYI2Vgllj4EN3Lw4q/QPMarnT0/4c6D22Qz
0Xcy0p7hRv+K0yaWWQ7MQuTFOdYUkH93JRp+aDPFzIxhmxMzCKWYkUIjamvyBLAn
14KPOa1qjluBGeZZfPBqUgPoJliP1jQ2w/Rh8zSAMnTaXGbEyiG9UxBzEbFjgg+p
BL4tQ4Tob2FvUQOLgb5cYsdRBlaijbVY8EQ7lGuN2Tf/rfMDrviyHVJCMqBlptUU
XTNc1/VYcaYIBWV6O/zHnJ9NRu062a/dqIMiOcok7OtLki8apXOnFvyuijFgpVZY
UoZ84VeeyLLoY3gZ/L54
=EwqL
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

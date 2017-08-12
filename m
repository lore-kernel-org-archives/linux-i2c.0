From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 02/13] i2c: rk3x: add support for rv1108
Date: Sat, 12 Aug 2017 16:38:37 +0200
Message-ID: <20170812143837.u76nb7ielcc6rtah@ninjato>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
 <1502422753-30725-1-git-send-email-andy.yan@rock-chips.com>
 <20170812140116.pjcswhe5mylns7x4@ninjato>
 <CANbgqATBQ3-V=Z8MLmw2jtQwiF0LMgoakGe+wLypzwF3EJF++A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pm4yco4wwzddltpq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43305 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751254AbdHLOij (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 10:38:39 -0400
Content-Disposition: inline
In-Reply-To: <CANbgqATBQ3-V=Z8MLmw2jtQwiF0LMgoakGe+wLypzwF3EJF++A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Yan <andyshrk@gmail.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--pm4yco4wwzddltpq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Actually, there is one I2C controller(I2C2) has a different feature with
> all the other rockchip soc.The I2C2 is not used on my current board. But I
> plan to add this feature later=E3=80=82 So I give RV1108 a new compatible=
 string
> here=E3=80=82

Makes sense. Thanks!


--pm4yco4wwzddltpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPEu0ACgkQFA3kzBSg
KbZJ+A//bxCtxG7wo44elAMVeFt6RnpSpwsvil0XmelUypceaSzYDekQ5hyi/wyA
285RnYSJsugsr66Lq7ON7jePxp4lYnoATPMUj6x4wwTynKkbHmEw3eAuKK+5gt0O
rUyAV99UWE+RL34edHgm+hHmpPnGWZFS2Pwq5HVOKNbT24qSBhPCLWak1QkmkYI/
Umsk/INYLzF81Zvrrq7gxPE0CpT6vgZSsckEnv5699KW4qsld6IUztxN3ajYaGa9
9vcJ7MsyFNop+sE+S8wCamHv3g7GV/1wT/3gouMVqktqs/tccLXkpwx0Fz9WX4Zi
cr9B6iPtrCvxnJdl5wjYY4AhNKiiGpfmXq7QgNCTVLfHGU24HhKN/j6dgEjjvNhj
//pB5CkiBBBzrft+AgrIHmHZQz2nsWXAZvmAfDvv7mwVLE75AF3Q/HJ0WcBX5B0L
BX4nVygPrQy73/grO1+BG3sES+uwuna/pw/COZNIb+zQHYKBZrJe3llxXt2lS9Y3
+jH8eVdFqJsfYMPXz1817xAay+yjp9AxChgGcp2NVr+DkNOBCMwCwgZZYTzib46O
VW8NyMshrF9cC4Z0QxDb8LMv73RGPupZd4vy55e1qVwmZ+NxKpCV4sLQy+Z7pfz6
6nq4hPhASQTO4iA3pIgu/wUJPqEzI08E55G0ynoZl+3TQFahw0s=
=j/FS
-----END PGP SIGNATURE-----

--pm4yco4wwzddltpq--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 05/14] eeprom: at24: hide the read/write loop
 behind a macro
Date: Sat, 16 Jul 2016 00:03:52 +0900
Message-ID: <20160715150352.GB5136@tetsubishi>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-6-git-send-email-bgolaszewski@baylibre.com>
 <20160715122429.GA2620@tetsubishi>
 <CAMpxmJU+HDvUb__Q6UvuaVC70+GdSU312uVuXuicqsn6_v2uKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38513 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbcGOPEF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 11:04:05 -0400
Content-Disposition: inline
In-Reply-To: <CAMpxmJU+HDvUb__Q6UvuaVC70+GdSU312uVuXuicqsn6_v2uKQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> +#define loop_until_timeout(tout, op_time)                            \
> >> +     for (tout =3D jiffies + msecs_to_jiffies(write_timeout),        =
  \
> >> +             op_time =3D jiffies;                                    =
  \
> >> +          time_before(op_time, tout);                                \
> >> +          usleep_range(1000, 1500), op_time =3D jiffies)
> >
> > There is one subtle change coming with this change: the do-while loop is
> > guaranteed to run at least once while the for-loop doesn't.
> >
>=20
> While it's technically possible, it will never happen as long as
> write_timeout is set to some sensible value.

I know that. I prefer Linux to be rock-stable, though, even when
slightly misconfigured (or under extreme load for that matter). An
incremental patch would be enough, no need to resend.


--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiPtXAAoJEBQN5MwUoCm2UeEP/1FJLZTO47reCXmOEmp/H3/f
zM91vkfZ7ns49vQ4UlDR37shPl3mqw7c1kb9yHVhDqg/OFkrv/4u5PEnhUgnBsvO
o/Rt0mqxtFnKdK7fxeNq0IQgiUee/ysPlfpKgl6OFFOsX7f86brGd0KdDwn3ikDj
G6lSPG24v4jBGe5RC5IzodYucIi5+Jp5w15KHML5lg1LSk3ndcaPjA1rM3FQx8Rb
u29Pex+kfG3SKBYJjuL3SgprJrXZZWI8QblQb4wz64Q8HEtkKWmp9C8UH0i3Dtkj
YeW/PcHZoBGA/h+Y9SluYboG6sOlZ4n/UYIDTVPKO93XVlkUqPYPNlkHrGcj6OUx
SN1lD/FnYt4DG/bW4VckF5nbx7cN01hLgHiCSQrI+56kqnCxPfy3aM1TbgMf8LzX
MWrLJsKR54l1qzkosHo03Gup8dFahvG11K0W4RHzz7O9aThRl7oMVEOSXZ4Lm6iA
u1S5Fwu6C3TZlheQ3qLvhDDM+uqs7/ulSHp1LBhqXwDpBlwitTyqR/6CBf0SX0Fx
airo+yEq7ILVsEXeJ+ihIWcYJ9toUDla1gsZv7ugd4ZWK1mPl7Uavp9jb6OQsUq8
130+RiwBUr9GGPkvTp71lCvaOoQo9Tn373aoYnCpN0heCwLHHWV2emU2QXiFTnGJ
TwqQZllCcobbXTL2EYQb
=U1fx
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

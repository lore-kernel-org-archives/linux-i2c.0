From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C
 master bridge; Feature request: introduce I2C_FUNC_STOP
Date: Thu, 14 Jul 2016 18:58:14 +0900
Message-ID: <20160714095812.GA1563@tetsubishi>
References: <578612EB.1060709@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60252 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbcGNJ6Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 05:58:25 -0400
Content-Disposition: inline
In-Reply-To: <578612EB.1060709@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: linux-i2c@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> It's available here:
>=20
> 	https://github.com/ianka/w1_ds28e17

You need to send patches to get anything reviewed.

> I've already sent a mail to Evgeniy Polyakov, maintainer of the W1
> subsystem and Wolfram Sang, maintainer of the I2C subsystem but got no
> reply. Maybe due to holiday season.

For my case, I am just extremly busy. Have a look for the pending
patches for I2C here:

http://patchwork.ozlabs.org/project/linux-i2c/list/

Please also note, that a maintainer is not the only reviewer for a
subsystem, the whole list is. You can try there to get people attracted
to your patch. If you count on me, expect a delay of weeks.

> I also have a question/feature request for the i2c subsystem. The
> DS28E17 can support I2C_M_STOP, which allows to combine write/read into
> a single transaction for slaves which need the intermediate stop
> condition =E2=80=93 as the DS7505 from the evaluation board. Using I2C_M_=
STOP

It cannot do repeated start?

> instead of splitting the transaction into two would save some overhead
> on the Onewire bus (8 bytes at 15kBaud =3D=3D 4ms, of busy-looping when
> Onewire is bitbanged.)

> What's the right way to handle this on the I2C driver side? Could we
> have a I2C_FUNC_STOP as we have a I2C_FUNC_NOSTART?

We can factor it out like I2C_FUNC_NOSTART when it is proven that it
really is needed.

Thanks,

   Wolfram


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh2I0AAoJEBQN5MwUoCm27sUP/2E0yG2ECHS+N8rSPvLsVVEw
x2tjxk0i3S5kt7V6Sbz5z7YPgtoeD5lkJ/1kUlIidL69hxWGSgDhPvIyU8QlJ4Ci
F2xoyvtUjFZzkSTF1DWEvfPvL+9zG+26CCBQyCa4CgY2LHxj5nMqbulwiXT8rUuu
EkcuN3d8qyv+aP+bM/L1s/u0mJjWi7P9619wTNhAFqjpyEL8D1ic4tQXMr7m682e
EZ1aZ/ELx8JKwfZ1vddDWeXvC7xAD2htP9Emf7nopM0YvENV7y3+pnU4vATqQA08
wE39UU4DqwCq6AHo1uC+tpZuWETWMzL/g++g6aXsyfQl9s/eakocAJCWD3DUBNS7
zLC3tkdDfj5U7IMk6o88JHPSEfkS4IxCyeqHMGwOD72AbJpYXsl+h3VrbKrHrUEY
jd0TldfsOT3reld1Gg2ULz3BZ023Tv4HaMjFIPb0QHeLl62yjnvLE+vvTzR4Mwli
2N4xS1VSfDw3+BFhjLzRBxEZ5GdZ7n/FvNduIY+rAcsSV+RBvfeIU6Dh2DeOF3ty
G7HTdi5C9zFd1L1H7p2s3roNYWXTk7mnV9eVP/agKXdlZqpzkhSm6NcosYMmItQP
MEqUCKxLNFjGjAwE4U0fOMDgUcmzuNK/rJoI3rHJTw49Sgi/oaCBw2rFBt9shbnS
M84o3BcNZgBO+zY/5yuQ
=k5Sg
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

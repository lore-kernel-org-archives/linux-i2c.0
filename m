From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 0/4] i2c: Fix module autoload for OF platform
 drivers
Date: Tue, 20 Oct 2015 18:18:04 +0200
Message-ID: <20151020161802.GP5379@katana>
References: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmVHo2jXx4bdYlgS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43734 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbbJTQSK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 12:18:10 -0400
Content-Disposition: inline
In-Reply-To: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, heiko@sntech.de, b.galvani@gmail.com


--cmVHo2jXx4bdYlgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 03:16:26PM +0100, Luis de Bethencourt wrote:
> Hello,
>=20
> This is a resend of this patch series. It was posted on September 17. [0]
>=20
> These patches add the missing MODULE_DEVICE_TABLE() for OF to export
> the information so modules have the correct aliases built-in and
> autoloading works correctly.
>=20
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519
>=20
> The 4th patch of the series is Acked-by Linus Walleij.

Applied to for-next, thanks!


--cmVHo2jXx4bdYlgS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmk6AAoJEBQN5MwUoCm2dp8P/jFpEok9p+gblmtTfRKd+NsA
zWmr8kQPxRY0fKljYdUPumkf04Q7rrM7wLhqUSCPqKTIjTqNlHKgvzy35Y5HNaGB
BeJ9Xbz89WkzSTQq/FKGvEUHc0r7EcYbUxkxmxUO9mz9nXZzzsQ0SBps9NiTIzAr
1VGU/Wzdr2U5HxpzFrv4arQbfcqlkuOGEHZtbM1ajQ9QQhnBfXKWqqW6YtsJgnLh
zVQmzqsKydBSapOfGPKwy3vMOpH2+q+02RfucY/6ceoxWSL6P2sEMH8+2q7QKc+S
wRlkhuLIWlYZcRrc0pNwgtee3fe5dSe6TCBvuu4nzhZV1XyNw67yzySBBWx//NJw
vywBZJZi1OL99VsTTo+V4ZQwSJMr39OyrcAJw4RBxHTt9g4YDG+GE3bfkoYT5L90
nJDLahhkCbRwiabHobV8KMAOxO0drRysusEyr0/mY0M6IDer0cS36IbFU42N9b56
V0gX5DX+5a+EisOtIY6Sw8YP8MR5EbNE9ABnzT0UWBZ0CHJqBCTSQrFDjUaXc2GU
tSVFblkr1F9qzqR8PzAno0wIX+AR4U0CUahGxuagnzSmJWpJMq+QWLWZDKUa2OEO
zVeDnAwpGdPUtt8uZavBiv6WYPTY3M9JO49S4UGZb2W8U/pw0mB5uP5fNWn5JuIg
iBgLxW9vtviQafrZncPJ
=Z2Ds
-----END PGP SIGNATURE-----

--cmVHo2jXx4bdYlgS--

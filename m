From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: pnx: remove superfluous assignment
Date: Fri, 30 Oct 2015 12:36:21 +0100
Message-ID: <20151030113621.GC25117@katana>
References: <1445786459-22690-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57908 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030377AbbJ3Lg0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 30 Oct 2015 07:36:26 -0400
Content-Disposition: inline
In-Reply-To: <1445786459-22690-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Vladimir Zapolskiy <vz@mleia.com>, Muhammad Falak R Wani <falakreyaz@gmail.com>, Vitaly Wool <vitalywool@gmail.com>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2015 at 04:20:59PM +0100, Wolfram Sang wrote:
> smatch rightfully says:
>=20
> drivers/i2c/busses/i2c-pnx.c:499 i2c_pnx_xfer warn: unused return: stat =
=3D ioread32()
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Muhammad Falak R Wani <falakreyaz@gmail.com>
> Cc: Vitaly Wool <vitalywool@gmail.com>

Applied to for-next, thanks!


--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWM1Y1AAoJEBQN5MwUoCm2c8cP/1E5M627R64zMc/M/xpx3EWr
pQG6b73ExNCl8TFqwauL1vvH/UcsqbmUfjtq+f8eQKSXHCWCj0fbU5KSV/RJsZ1u
JyIGgtaovZIAd775jkrxMIDSfjCMzmMFQRMZF3gjTlnEvD8J4T7c4KP3MSR+UfNn
3qAvIGgaDYYxP99lHkqJVhWch+7/MWEgBe9bzCiO7nb/eW170O7pXLJHmMo9B6yS
QJOrPQ1DmgmVk2uieWkpHQHrWnErxev4QC3pQq7zZC1h5QNjqRC+GSVLgUhXGNLo
JbCzvg7rICIOVF5aFv6sWgNjGRAgx9XDW7zEHcBU+arebw4LaQdJQXGf4qv6b7rZ
wJ4rV+3CP4riZYo8kG7q4O5JuOv+ADXwXRdx90jvyqVSu7iNKe9fNg4DEMdSDQSd
UY5g4dItJWpVqTqvvoaX1I5WoonwXmlLiXUSdF3pr8A+BSYs2YhNXX/XaPEYpVhd
dvZ1WpXvP7KR63BOq8X4H3j1g6RjvZ1U8wNDiB1AsMYcwoFhE9S1pQL/ITC0dyfv
aNFTh7yUMk4DmJkDimPteuwNFL7vi7yGhvGOz7I2IByVxVqOH9YNNBbbfSwV5K72
OtirWB5lhGTaERkX4gY9dThxSpCLnr06xKXyploH0vc41R+CJs33TsUnbgobFX/g
z42BoSc1TnDzuCAvKjIn
=BL0W
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

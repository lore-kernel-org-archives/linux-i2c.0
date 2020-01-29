From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] docs: i2c: dev-interface: document the actual
 implementation
Date: Wed, 29 Jan 2020 22:13:37 +0100
Message-ID: <20200129211337.GG7586@ninjato>
References: <20200123105246.67732e33@endymion>
 <20200123111137.5899fa5a@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41820 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbgA2VNj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Jan 2020 16:13:39 -0500
Content-Disposition: inline
In-Reply-To: <20200123111137.5899fa5a@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Lei YU <mine260309@gmail.com>, Luca Ceresoli <luca@lucaceresoli.net>


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>  So let's say you want to access an I2C adapter from a C program.
> -First, you need to include these two headers::
> +First, you need to include these three header files::

Just stumbled over it: maybe just drop the 'three'? No number makes
maintenance easier and it is not important for the user, I'd think.

> =20
> +  #include <linux/i2c.h>
>    #include <linux/i2c-dev.h>
> -  #include <i2c/smbus.h>
> +  #include <sys/ioctl.h>

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4x9YEACgkQFA3kzBSg
KbbKfA/+LENepLJ0mwErl5fnqPWA/lmxTAsK2JoYsbFSLRTi12i/kgUMQGxooX/1
xJaeVnG5NOoBrBWTQwCfaQQbeNiF/sZ7pO7BNOTu+zOqck0EywSTB1u0yGPdAERE
GEX/xVFV3us252yZ9hCcZKpC1YAdGe3NBtA+OO3wqmiYNqI+F5y72Zu4ib4Inoqa
RfmmLp6RacspClE9GX4FzKsqLz8pgnb75v+8QED5YgE6d3NDHUvke6JocI3V/kiP
Z3FvNkO5TaYesjiJKGDVRHVW1C1xTkcdMnElef2BiwICLyKEtxZBJlO7tjtgo2Bk
Ec76CBlqCrx8Z0tNzhXlOujpjX0B6Rny1FZU81g7CuVcTZU1LcNomEohwcXrFa44
z9/JtLKUv5r7Ys3PNZFP/2gWSdfnkBWpWa8NW2JCDkoStJtq6Y1fC9yXOnQiV7DP
gT65psN5YmPFmn5frIP4pDkYsKilq86dPQ4KUG1eT+M33/4AAbmYiIYrJdQIgxk8
GgHVLHEOpJG7ZtUJRLSRSKS5S/UhSY1+KGHSq5Js9FZrd4u1h+ZZMIhHMgNkGTae
9c3wjhAEYQF35CNZLwudh9NiHQ41Zh3VXnsCTYYqMQZPcd4VhmcX20ldBR0sydwU
5uN0VEQbiG/E5ZHuSfOQkTyKF1yt5iKqxGxwbhVpePiUc92l0no=
=TNX0
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--

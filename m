From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: factor platform data into state
 container
Date: Fri, 3 Jan 2014 16:35:54 +0100
Message-ID: <20140103153553.GD7132@katana>
References: <1385676737-15127-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385676737-15127-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (!np) {
> +		dev_err(&adev->dev, "no device node\n");
> +		return -ENODEV;

Can this really happen? How should driver and device match otherwise?

Rest is looking good.


--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxtjZAAoJEBQN5MwUoCm2bogP/ROkIyXHZjPiVw9SaDOsXBDL
2fWdJ8kR2vN1Kt8Xa/K0dtlwfSp/yIPsxIxaCu896H9gGhAJLjKhkmStBt2obzhv
HKPMAu2lvNF1g+pOKxC8/rd3PWIueJVPZhVk7Z/UrI0s5wR4PDg5aUyGpcz5c4Ad
NxsMdI7tY3RTMN62owhWaL+kK+C0EQ3O/6689xDSj0Wg1HwnKC4/kmO/PwkGrqge
io4rlXb5O52CeMejqn1gUNBj41QgNMP7HfKQk9mlv7qaSavofa1p3OVD9eY6ZobZ
bfm7DX38NXRkKCWt+xVoK7u1sMUhVybAYuoZNMhITxH2OI/CBL4yZynRj1jODHbD
iq938SX1vqv44flieMVm9yjhiyBJvhI94kq9qP8flSRpQ2k+5FcpXINb/8BOmV0m
kQvIGnh9Am79kI9q0jhvS6xkylrGL1D/Mi+rasJbOzuJD8uj9uMOroyzEqUpdqrf
IhwiwCwNFf3fBKn/Yze/WLVoJCQ18GgyzJXxxpr2e7u09+8E8eV4Cm9soAXiWNZ3
7wWBvM6pdEbw47pnw2R7+D69+xq8O8Sn+RQLKOrRzX4GAB2wCHkTVwVNQqVuUJsr
kWO2YNFOURiern2uvo7ddpNttmzqHxeBxqYebXOPiaht0QLAyVVCBlJFb6pgYNNj
9bytOJF2xA5pzTcDvhAf
=+nOa
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--

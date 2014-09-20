From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: fixed error message in pio transfer
Date: Sat, 20 Sep 2014 14:39:53 +0200
Message-ID: <20140920123953.GE3850@katana>
References: <1410279571-4552-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410279571-4552-1-git-send-email-j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2014 at 06:19:30PM +0200, Janusz Uzycki wrote:
> If I2C_M_RD flag is set SELECT command is sent
> and afterward READ command.
> The patch fixes READ command to return READ failure error message
> instead of SELECT failure error message.
>=20
> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>

Applied to for-next with minor updates to the commit message, thanks!

Marek, I added your ack since you said you are fine with the change
itself. Thanks for reviewing the Freescale drivers BTW, much
appreciated!


--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXWZAAoJEBQN5MwUoCm2Ld0P/Au6e4EFSTJ5dgybAzXjhPU1
GJgz8PTk4FtehKG6e3cQoNbx3XzfyeNdkNuErD93Hw1H7YRjakutY34uqPzqjIMR
zycQA1wwuBUqvd6Mql0xWgfSnc1mtmA2FB87iLNh2NS3zJIZcSrbp8TD4n6V3mjz
lbYR8HgMnGNkT04uPx+TUuk9zmCaHE9GrmWRG4G+s1Mf/hyw+apiryuMNip4QNhn
9M6lcUHVo2U9Tfuw6INTN2QP36Sm5d1Wxpw8R5XCjFh1Dl/YliGN04IBf98a8qls
gAexFbU6VbEdUWGduybrpjJexyzo/+7+082YuRUdlBeLsIXJJU2kTUYkb7pVmhnh
uz85JlcWmJZ7zRixVH96mBULm4upM+Ooj4Q9GUoWYdM9/MvLrpeZuoMxITuQ+0Hj
Fudv5x02FIuKscSFjqkC7CQJM4AF7mtkBuNl4FVxOswRuqSVjshlUvkTbujEl3Zu
Qi1aOcVd8YBnNjvEEu6a4R0TiZVRwEcefQlA4slBMp/y646yJPB9CVYmUNpZI8H0
11Ud9NZIy6VLFlQ25MnFqHu5cdTztK292FdJqOUYy+s2LPZjM+QvGCFUoixcM66Q
aJZ0X0YJeVlmW1F7wYDRqrDLd/5jsheKbHyGn5Djmay2qxNsD6ZhBFLJdhYT0+NQ
+YtpbpAHZcrfTZOT+6r2
=Pc+s
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--

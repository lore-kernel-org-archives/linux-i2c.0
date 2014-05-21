From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Wed, 21 May 2014 11:04:24 +0200
Message-ID: <20140521090424.GQ27329@lukather>
References: <1396270498-30703-1-git-send-email-maxime.ripard@free-electrons.com>
 <1396270498-30703-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140521075415.GB2708@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YzdYn+D7cUqe+VA3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140521075415.GB2708@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YzdYn+D7cUqe+VA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2014 at 09:54:15AM +0200, Wolfram Sang wrote:
> On Mon, Mar 31, 2014 at 02:54:58PM +0200, Maxime Ripard wrote:
> > Switch the device tree to the new compatibles introduced in the i2c dri=
vers
> > to have a common pattern accross all Allwinner SoCs.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>=20
> I usually don't take dts updates, but I guess it makes sense this time,
> because we dropped the old binding?
>=20

Either way is fine for me. It would be better to have the two patches
in the same tree, but I don't have any issue with merging it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--YzdYn+D7cUqe+VA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfGwYAAoJEBx+YmzsjxAgWMoP/RwSEHW/UQBTd6H8IqTNTW6E
ZrpaQUaA3m+yK3AIUtgXloYLw/ppF+YP/sZJUaEAuIIIf3wKNL0jqAOLZYUwt5kr
zgZ/a9FVkdCzeHfkKFyTk89q92VCekTsZ+HTAxU7umvQcUJyGOdTiNoMBB9mLULI
zXDAHFUvB8aeD8oqdY6Q1j1S01f0IM7ntmiEA/hmPY6nsiCeJ/kOLw2Qg4H782KP
ahv4iUco6k2L1/l6ic/IOc+UfcQGKKI2Hwvlr7d6sjqUN9hf5gtGFAJq8uacadp/
XeDrl2sz44Bk3IKInBCS4lo8xMXjEzFUBnAVEctyuaML/8Haq+qCil4ffM3AzVW4
0dOCeox7phJH8uAh4hVk+HeuLcsv7DfNyIYf9Xl5+m/5QTfj8mTqzmEH7Q7WacbH
Xq1gpveSYfWXo9koneljE8XJ/fA29jEluGiuh88fNOJfn7BQXzsLCGk9RMhaxxjt
cbB7RrxSj6uqXQxsrKyLX59uG+Wu5rLefhBQ5mobanlZ/ykkijJPJxKqBL2gAm4K
70KV1eXvqTZ+fMP1X029oLoo2+6cqHF8RT6t1+gm0NLaI9xaGWF+uPQmB3VkCVL9
ruXKYX5MxYtkSkGCvNWPoZPO1RzwTFuhzxaP7tIWXlhGta6iYG6Y9b8G3F7Cn5aV
Fd2x0LKaRY/7KqqEekA4
=QkWP
-----END PGP SIGNATURE-----

--YzdYn+D7cUqe+VA3--

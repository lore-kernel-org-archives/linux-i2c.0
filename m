From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c-tools 1/2] i2ctransfer: replace broken "force"
 handling
Date: Fri, 7 Apr 2017 14:13:25 +0200
Message-ID: <20170407121325.7icxzkagsguv3gpd@ninjato>
References: <20170403173613.2238-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yfrkrra6hhwfgghr"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170403173613.2238-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org


--yfrkrra6hhwfgghr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 07:36:12PM +0200, Wolfram Sang wrote:
> Probably because of a bad rebase, the old and bogus handling (v1) of "for=
ce"
> slipped into the latest version of the patch (v3). Apply the better
> version from v2 which does the error handling correct and makes the code
> a lot easier to understand.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Pushed out to i2c-tools/master.


--yfrkrra6hhwfgghr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljngmUACgkQFA3kzBSg
KbYJXA//UZtIh8nzxkQLe2dmQfr7Lv3Vgf6JgoSmIntefeLyP3Pkneh1U2Vi249s
lTsonGiFr8HwcFePoKmVdhkQM9RgKxTERKRtLc1Ry0xJom6OL728Mr1i9g+GRrMa
ud7ncKHMlzQWvNn2f2EuG2mKLdkGBqdhzkneuIYbo9qK2rFPp+Q7b8ZeldVfr4GO
wwSNwHpye7vg+W4zHhxox12uGTnWPuV9MdaKO1zFL+gW26kvYmTliggq7GzzZP4e
1SOyKj6H0ykRF3eaQvQwrybG5zNLXBOGjBLagx9iu5uQjgFDaBfyYMV9YVaDeZih
ZGvU5BtS+Rc1qDaHUkk4hfY9EMv8VS0reTRL1MhsQHQFHQCzxNubS+b7bn6WwTpZ
Uhovcgaaif5KijOeVRcYNMk2UqKdKfZt+mp1zJenN+CzHRigjSFytbGV60GIETen
oDi/kZUe3O11sfv0M7wbWLzSzRJnbDty+NzNqKcUOcQBaU/NKeBzeFJakO7uC9D1
p7y2Rg3yB571GxXJU1VdexN5daUX443uuMoJKzwP8jGHY2gGmS8It12+Wfw42Dwi
ooDU5glXfc6IacTtITNfNtYOAjTV/JUL82sPeTX4/4Tz6S16xpJtZ/gG0A+ywGg8
Yp1w7fG68V70PWM3PAtu2xa5rvtNymYKdvlj18kNR1dHZt8GZfs=
=86ss
-----END PGP SIGNATURE-----

--yfrkrra6hhwfgghr--

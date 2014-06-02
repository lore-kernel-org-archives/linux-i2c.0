From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nuc900: remove driver
Date: Mon, 2 Jun 2014 18:05:21 +0200
Message-ID: <20140602160521.GF2654@katana>
References: <1401654925-20791-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401654925-20791-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wan ZongShun <mcuos.com-wSZih8+RwX/YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2014 at 10:35:25PM +0200, Wolfram Sang wrote:
> Arnd said in another patch:
>=20
> "As far as I can tell, this driver must have produced this
> error for as long as it has been merged into the mainline kernel, but
> it was never part of the normal build tests:
>=20
> drivers/i2c/busses/i2c-nuc900.c: In function 'nuc900_i2c_probe':
> drivers/i2c/busses/i2c-nuc900.c:601:17: error: request for member
> 'apbfreq' in something not a structure or union
>   ret =3D (i2c->clk.apbfreq)/(pdata->bus_freq * 5) - 1;
>                  ^
> This is an attempt to get the driver to build and possibly
> work correctly, although I do wonder whether we should just
> remove it, as it has clearly never worked."
>=20
> I agree with removing it since nobody showed interest in Arnd's fixup
> patch.
>=20
> Reported-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Wan ZongShun <mcuos.com-wSZih8+RwX/YtjvyW6yDsg@public.gmane.org>

Applied to for-next, thanks!


--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjKDBAAoJEBQN5MwUoCm2bHkP/A5t1KhW3rVzG9mMVuuDJwb0
axLhUP6sWavimH/OoV1T7cPq4JkhmLRFLhoNOSgTPYTiAfpON/JrCAMah4YTGfJo
XLx/atktw2Du0vQjCzu9tROApayORjwt4wDaEvNOd1h40iUX2lm4Mk0gy5yntXuY
sWEUzXVSpAF0MSppUg1alSKol8UqkGPYavQjCcqEii6XsliojMC8P4nWFpCzqryx
Cx362D/1+NMcHzYgGZ4zehpGwMtJcXcsocSE6+gBJ2mZHKzrTXEAdePIG9S6SbVa
qpYhH25plY2f2SrMGMiA9B7lKdMiwlOL/D6iJeLP6EtrW5xG+VQEmUrT6CWpKYsH
y0InvPyjLPyL0FmUjGuwWgi3Nk/a32KIfyLNWKdMqAB6jSilqiNLmnAlRWrjcdWu
Nf5YUZtcG4m33u58k9CP8q/sLFS0n9uPZ/kA7WUeEf7VRiV4t74I5y0vK0riAb5/
wqY/HPu3jHLoMnUdBlD3tt9f/nZlbVbEmNbfa8g8GgU/GyqE2O9bPxS0qIybn4In
ZWMj9ofR7i8EmKyaZr1yb68TzGiAzE0OaW34p2RNIUsAH+ZsK4oLYvpeh+oP2GbZ
BoturMOkud2TUh7a5zm5OLhbkkVmMHz0S39zcqCkq5SgtEjEmPXBfdCc5kWXBx3e
GyZQa57csylWtEwLNR5g
=UZIB
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--

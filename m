From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: cht-wc: drop check because i2c_unregister_device()
 is NULL safe
Date: Tue, 3 Sep 2019 19:52:18 +0200
Message-ID: <20190903175218.GE2171@ninjato>
References: <20190820153441.7693-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190820153441.7693-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 05:34:40PM +0200, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Hans, are you OK with this change?

> Build tested only, buildbot is happy, too.
>=20
> Please apply to your tree.
>=20
>  drivers/i2c/busses/i2c-cht-wc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht=
-wc.c
> index 66af44bfa67d..3e2608a65c06 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -363,8 +363,7 @@ static int cht_wc_i2c_adap_i2c_remove(struct platform=
_device *pdev)
>  {
>  	struct cht_wc_i2c_adap *adap =3D platform_get_drvdata(pdev);
> =20
> -	if (adap->client)
> -		i2c_unregister_device(adap->client);
> +	i2c_unregister_device(adap->client);
>  	i2c_del_adapter(&adap->adapter);
>  	irq_domain_remove(adap->irq_domain);
> =20
> --=20
> 2.20.1
>=20

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1uqFIACgkQFA3kzBSg
KbYEShAAn8nHT+tj4NkyfQNhwUjViQWeCDdZadCW/I2GsqpDBmOx7e4StF2KhDD6
Qz1G1zUAiV+wLVgnfengL0a2RZrt/7bMEqA5dDOtzHbV4K5CCziGLGdlS5r3YuLm
pkkRiET8q2ArMmfFoyWtmRrmIjzFKmBrDO+hwxmurkqWZm7vrjAbSvL7R7GJ2HCR
gx1NdXCLfRRTEaLZoJlLS3JRIRthWgTUvIbkgcbF+DxUzjcHqHe7EMiWIOEQlOAs
dlk5p14R+fiNL4K8i8Y2JLS/8iAcmTJHjvMu+BjX2fSUQZB3yAnhwOT7iWqUaYdH
fgK1s8Me6+/BRjmA3sjOg+0I37aw33C0etNJ5+SxlUiosWRQrMU8aipo4MLgTFfN
waGi/4KWZkxI3lheqS7rq3FyBPrdkwfURNG03GC4FeKZ7W1IMQLUm+8L0h04u72z
s8Tf7YusuEvboTnegieKtj2yU3lVGpHW6mvjM5c+76TKQQOw9AxtvpadpF+DXVYg
Pzbz9pRH2mnQ2nd6VQKSBW3W9aYsjOWUeVbcXiJOFb59KQm5BniyuUY5sgsK/9V5
aIQb7ElFsFKfxjDIVQg9w0N85bMv3KFebqy44M0htvN68A2653aQjXKk4lO5WO8G
zMsOoib97DRmWzpqi/3zGiQI/yiXdES+yrT7Uyu0YdxqGO/59vA=
=dUSq
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--

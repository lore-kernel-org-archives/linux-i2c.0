From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: rcar: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 08:44:47 +0100
Message-ID: <20151112074447.GA24008@pengutronix.de>
References: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43232 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbbKLHou (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 02:44:50 -0500
Content-Disposition: inline
In-Reply-To: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 12, 2015 at 08:25:09AM +0100, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
>=20
> Reported-by: coverity (CID 1130036)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-r=
car.c
> index b0ae560..d2bdbda 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -639,6 +639,7 @@ static int rcar_i2c_probe(struct platform_device =
*pdev)
>  	struct device *dev =3D &pdev->dev;
>  	u32 bus_speed;
>  	int irq, ret;
> +	const struct of_device_id *of_id;
> =20
>  	priv =3D devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL=
);
>  	if (!priv)
> @@ -653,7 +654,10 @@ static int rcar_i2c_probe(struct platform_device=
 *pdev)
>  	bus_speed =3D 100000; /* default 100 kHz */
>  	of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
> =20
> -	priv->devtype =3D (enum rcar_i2c_type)of_match_device(rcar_i2c_dt_i=
ds, dev)->data;
> +	of_id =3D of_match_device(rcar_i2c_dt_ids, dev);
> +	if (!of_id)
> +		return -ENODEV;
> +	priv->devtype =3D (enum rcar_i2c_type)of_id->data;

This is nearly an open coding of of_device_get_match_data. Maybe using

	priv->devtype =3D (enum rcar_i2c_type)of_device_get_match_data(dev)

if good enough?=20

Other than that, the NULL pointer dereference should only happen if the
device was bound using the driver name. That might be worth to point ou=
t
in the commit log. So maybe make (in a separate patch) the probe
function fail when probed by name?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

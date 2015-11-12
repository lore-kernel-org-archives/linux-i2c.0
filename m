From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Thu, 12 Nov 2015 08:46:43 +0100
Message-ID: <20151112074643.GB24008@pengutronix.de>
References: <1447313194-23931-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36172 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbbKLHqr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 02:46:47 -0500
Content-Disposition: inline
In-Reply-To: <1447313194-23931-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 12, 2015 at 08:26:33AM +0100, LABBE Corentin wrote:
> The simple_strtoul function is marked as obsolete.
> This patch replace it by kstrtou8.
>=20
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/i2c/busses/i2c-taos-evm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i=
2c-taos-evm.c
> index 4c7fc2d..fe2b705 100644
> --- a/drivers/i2c/busses/i2c-taos-evm.c
> +++ b/drivers/i2c/busses/i2c-taos-evm.c
> @@ -70,6 +70,7 @@ static int taos_smbus_xfer(struct i2c_adapter *adap=
ter, u16 addr,
>  	struct serio *serio =3D adapter->algo_data;
>  	struct taos_data *taos =3D serio_get_drvdata(serio);
>  	char *p;
> +	int err;
> =20
>  	/* Encode our transaction. "@" is for the device address, "$" for t=
he
>  	   SMBus command and "#" for the data. */
> @@ -130,7 +131,9 @@ static int taos_smbus_xfer(struct i2c_adapter *ad=
apter, u16 addr,
>  			return 0;
>  	} else {
>  		if (p[0] =3D=3D 'x') {
> -			data->byte =3D simple_strtol(p + 1, NULL, 16);
> +			err =3D kstrtou8(p + 1, 16, &data->byte);
> +			if (err)
> +				return -EPROTO;
>  			return 0;

This is nearly equivalent to the probably more correct:

	return kstrtou8(p + 1, 16, &data->byte);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

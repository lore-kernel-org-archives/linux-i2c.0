From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: cros_ec: Remove EC_I2C_FLAG_10BIT
Date: Tue, 24 Jun 2014 09:59:25 +0100
Message-ID: <20140624085925.GC13803@lee--X1>
References: <1403558406-14519-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403558406-14519-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 23 Jun 2014, Doug Anderson wrote:

> In <https://lkml.org/lkml/2014/6/10/265> pointed out that the 10-bit
> flag in the cros_ec_tunnel was useless.  It went into a 16-bit flags
> field but was defined at (1 << 16).
>=20
> Since we have no 10-bit i2c devices on the other side of the tunnel o=
n
> any known devices this was never a problem.  Until we do it makes
> sense to remove this code.  On the EC side the code to handle this
> flag was removed in <https://chromium-review.googlesource.com/204162>=
=2E
>=20
> Reported-by: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Note that this patch is based atop my current series of posts to
> cleanup cros_ec.  It wouldn't be hard to apply it to the current ToT
> if someone wants to land this before the others.
>=20
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 6 ++++--
>  include/linux/mfd/cros_ec_commands.h    | 3 ---

=46or the MFD part:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/bu=
sses/i2c-cros-ec-tunnel.c
> index 05e033c..6d7d009 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -94,7 +94,7 @@ static int ec_i2c_construct_message(u8 *buf, const =
struct i2c_msg i2c_msgs[],
>  		msg->addr_flags =3D i2c_msg->addr;
> =20
>  		if (i2c_msg->flags & I2C_M_TEN)
> -			msg->addr_flags |=3D EC_I2C_FLAG_10BIT;
> +			return -EINVAL;
> =20
>  		if (i2c_msg->flags & I2C_M_RD) {
>  			msg->addr_flags |=3D EC_I2C_FLAG_READ;
> @@ -218,7 +218,9 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, =
struct i2c_msg i2c_msgs[],
>  		}
>  	}
> =20
> -	ec_i2c_construct_message(request, i2c_msgs, num, bus_num);
> +	result =3D ec_i2c_construct_message(request, i2c_msgs, num, bus_num=
);
> +	if (result)
> +		goto exit;
> =20
>  	msg.version =3D 0;
>  	msg.command =3D EC_CMD_I2C_PASSTHRU;
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd=
/cros_ec_commands.h
> index 7853a64..a49cd41 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1928,9 +1928,6 @@ struct ec_response_power_info {
> =20
>  #define EC_CMD_I2C_PASSTHRU 0x9e
> =20
> -/* Slave address is 10 (not 7) bit */
> -#define EC_I2C_FLAG_10BIT	(1 << 16)
> -
>  /* Read data; if not present, message is a write */
>  #define EC_I2C_FLAG_READ	(1 << 15)
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

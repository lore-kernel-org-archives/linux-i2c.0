From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC PATCH 9/9] iio: imu: inv_mpu6050: Fix deadlock between i2c
 adapter lock and mpu lock
Date: Thu, 18 Feb 2016 10:17:10 -0800
Message-ID: <1455819430.7375.192.camel@linux.intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
	 <1455810794-3188-10-git-send-email-daniel.baluta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26424 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030327AbcBRSSh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 18 Feb 2016 13:18:37 -0500
In-Reply-To: <1455810794-3188-10-git-send-email-daniel.baluta@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, lucas.demarchi@intel.com, ggao@invensense.com, adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org

On Thu, 2016-02-18 at 17:53 +0200, Daniel Baluta wrote:
> From: Adriana Reus <adriana.reus@intel.com>
>=20
> This deadlock occurs if the accel/gyro and the sensor on the
> auxiliary
> I2C (in my setup it's an ak8975) are working at the same time.
>=20
> Scenario:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T1					T2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D				=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D
> inv_mpu6050_read_fifo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aux sensor =
op (eg.
> ak8975_read_raw)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> mutex_lock(&indio_dev->mlock)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0i2c_transfer
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> i2c transaction=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0i2c adapter lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> i2c adapter lock=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0i2c_mux_master_xfer
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0inv_mpu6050_select_bypass
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&indio_dev->mlock)
>=20
> When we operate on an mpu sensor the order of locking is mpu lock
> followed by the i2c adapter lock. However, when we operate the
> auxiliary
> sensor the order of locking is the other way around.
>=20
> In order to avoid this enable the bypass mux bit once in the
> beginning
> and remove the select/deselect_bypass functions.
>=20
> This patch moves the bypass enabling in a separate function
> that is called once at probe and removes the functionality from
> inv_mpu_select/deselect_bypass.
>=20
> Another advantage of this approach is that power-wise the mpu chip
> isn't
> powered up at each auxiliary sensor i2c transaction so if only the
> compass is used this would be more power efficient.
There was one comment before that power off will cause the the bypass
i2c lines to disable for some MPU chips which this driver can support.
So get some confirmation from Invensense folks that this is OK for all
MPU chips.

Thanks,
Srinivas

>=20
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 88 ++++++----------=
-----
> ----------
> =C2=A01 file changed, 15 insertions(+), 73 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 71bdaa3..8065355 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -25,82 +25,25 @@ static const struct regmap_config
> inv_mpu_regmap_config =3D {
> =C2=A0	.val_bits =3D 8,
> =C2=A0};
> =C2=A0
> -/*
> - * The i2c read/write needs to happen in unlocked mode. As the
> parent
> - * adapter is common. If we use locked versions, it will fail as
> - * the mux adapter will lock the parent i2c adapter, while calling
> - * select/deselect functions.
> - */
> -static int inv_mpu6050_write_reg_unlocked(struct i2c_client *client,
> -					=C2=A0=C2=A0u8 reg, u8 d)
> +static int inv_mpu6050_bypass_en(struct iio_dev *indio_dev)
> =C2=A0{
> -	int ret;
> -	u8 buf[2] =3D {reg, d};
> -	struct i2c_msg msg[1] =3D {
> -		{
> -			.addr =3D client->addr,
> -			.flags =3D 0,
> -			.len =3D sizeof(buf),
> -			.buf =3D buf,
> -		}
> -	};
> -
> -	ret =3D __i2c_transfer(client->adapter, msg, 1);
> -	if (ret !=3D 1)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void
> *mux_priv,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 chan_id)
> -{
> -	struct i2c_client *client =3D mux_priv;
> -	struct iio_dev *indio_dev =3D dev_get_drvdata(&client->dev);
> =C2=A0	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret =3D 0;
> =C2=A0
> -	/* Use the same mutex which was used everywhere to protect
> power-op */
> -	mutex_lock(&indio_dev->mlock);
> -	if (!st->powerup_count) {
> -		ret =3D inv_mpu6050_write_reg_unlocked(client,
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->reg-
> >pwr_mgmt_1, 0);
> -		if (ret)
> -			goto write_error;
> +	ret =3D inv_mpu6050_set_power_itg(st, true);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		msleep(INV_MPU6050_REG_UP_TIME);
> -	}
> -	if (!ret) {
> -		st->powerup_count++;
> -		ret =3D inv_mpu6050_write_reg_unlocked(client,
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->reg-
> >int_pin_cfg,
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INV_MPU6050_INT
> _PIN_CFG |
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INV_MPU6050_BIT
> _BYPASS_EN);
> +	ret =3D regmap_write(st->map,
> +			=C2=A0=C2=A0=C2=A0st->reg->int_pin_cfg,
> +			=C2=A0=C2=A0=C2=A0INV_MPU6050_INT_PIN_CFG |
> +			=C2=A0=C2=A0=C2=A0INV_MPU6050_BIT_BYPASS_EN);
> +	if (ret) {
> +		inv_mpu6050_set_power_itg(st, false);
> +		return ret;
> =C2=A0	}
> -write_error:
> -	mutex_unlock(&indio_dev->mlock);
> =C2=A0
> -	return ret;
> -}
> -
> -static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *mux_priv, u32 ch=
an_id)
> -{
> -	struct i2c_client *client =3D mux_priv;
> -	struct iio_dev *indio_dev =3D dev_get_drvdata(&client->dev);
> -	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> -
> -	mutex_lock(&indio_dev->mlock);
> -	/* It doesn't really mattter, if any of the calls fails */
> -	inv_mpu6050_write_reg_unlocked(client, st->reg->int_pin_cfg,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INV_MPU6050_INT_PIN_CF=
G);
> -	st->powerup_count--;
> -	if (!st->powerup_count)
> -		inv_mpu6050_write_reg_unlocked(client, st->reg-
> >pwr_mgmt_1,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INV_MPU6050_BIT_SLEEP
> );
> -	mutex_unlock(&indio_dev->mlock);
> -
> -	return 0;
> +	return inv_mpu6050_set_power_itg(st, false);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -129,7 +72,8 @@ static int inv_mpu_probe(struct i2c_client
> *client,
> =C2=A0		return PTR_ERR(regmap);
> =C2=A0	}
> =C2=A0
> -	result =3D inv_mpu_core_probe(regmap, client->irq, name,
> NULL);
> +	result =3D inv_mpu_core_probe(regmap, client->irq, name,
> +				=C2=A0=C2=A0=C2=A0=C2=A0inv_mpu6050_bypass_en);
> =C2=A0	if (result < 0)
> =C2=A0		return result;
> =C2=A0
> @@ -137,9 +81,7 @@ static int inv_mpu_probe(struct i2c_client
> *client,
> =C2=A0	st->mux_adapter =3D i2c_add_mux_adapter(client->adapter,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&client->dev,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0client,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00, 0, 0,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inv_mpu6050_select_byp
> ass,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inv_mpu6050_deselect_b
> ypass);
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00, 0, 0, NULL, NULL);
> =C2=A0	if (!st->mux_adapter) {
> =C2=A0		result =3D -ENODEV;
> =C2=A0		goto out_unreg_device;

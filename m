From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6] Add ov772x driver
Date: Mon, 20 Oct 2008 11:34:17 +0200
Message-ID: <20081020113417.4e4c61b8@hyperion.delvare>
References: <uk5c3my0c.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <uk5c3my0c.wl%morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Kuninori Morimoto <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: V4L <video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Kuninori,

On Mon, 20 Oct 2008 18:06:29 +0900, Kuninori Morimoto wrote:
> This patch adds ov772x driver that use soc_camera framework.
> It was tested on SH Migo-r board.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> PATCH v5 -> PATCH v6
> fix i2c smbus byte/word order miss
> fix checking reg->val from > 0xff to < 0
> fix i2c adapter on i2c_check_functionality

A couple more things...

> +#ifdef CONFIG_VIDEO_ADV_DEBUG
> +static int ov772x_get_register(struct soc_camera_device *icd,
> +			       struct v4l2_register *reg)
> +{
> +	struct ov772x_priv *priv = container_of(icd, struct ov772x_priv, icd);
> +
> +	if (reg->reg > 0xff)
> +		return -EINVAL;
> +
> +	reg->val = i2c_smbus_read_byte_data(priv->client, reg->reg);
> +
> +	if (reg->val < 0)

Nitpicking: traditional coding style says no blank line between
function call and its error checking.

Also, I just noticed that reg->val is an __u64 so it can't be < 0.
You'll have to use a local int to store the result of
i2c_smbus_read_byte_data(). I'm surprised the compiler didn't warn
you... Maybe you didn't test with CONFIG_VIDEO_ADV_DEBUG=y?

> +		return -EIO;

You might as well return the error value you got from
i2c_smbus_read_byte_data(), it may be more detailed.

> +
> +	return 0;
> +}
> +
> +static int ov772x_set_register(struct soc_camera_device *icd,
> +			       struct v4l2_register *reg)
> +{
> +	struct ov772x_priv *priv = container_of(icd, struct ov772x_priv, icd);
> +
> +	if (reg->reg > 0xff ||
> +	    reg->val > 0xff)
> +		return -EINVAL;
> +
> +	if (i2c_smbus_write_byte_data(priv->client, reg->reg, reg->val) < 0)
> +		return -EIO;

Here again it would be preferable to return the error value you got
from i2c_smbus_write_byte_data() instead of hard-coding one.

> +
> +	return 0;
> +}
> +#endif
> (...)
> +static int ov772x_probe(struct i2c_client          *client,
> +			const struct i2c_device_id *did)
> +
> +{
> +	struct ov772x_priv        *priv;
> +	struct ov772x_camera_info *info;
> +	struct soc_camera_device  *icd;
> +	struct i2c_adapter        *adapter = to_i2c_adapter(client->dev.parent);
> +	int                        ret;
> +
> +	info = client->dev.platform_data;
> +	if (!info)
> +		return -EINVAL;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_warn(&adapter->dev,
> +			 "I2C-Adapter doesn't support I2C_FUNC_SMBUS_BYTE\n");

The warning message still doesn't match the failed check
(I2C_FUNC_SMBUS_BYTE_DATA != I2C_FUNC_SMBUS_BYTE). Also, I believe you
should use dev_err(), not dev_warn(), as this is a fatal error.

> +		return -EIO;
> +	}

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

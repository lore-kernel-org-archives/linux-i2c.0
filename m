From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [patch v4 1/1] i2c: add master driver for mellanox systems
Date: Mon, 7 Nov 2016 02:47:07 +0200
Message-ID: <fe5f890f-6be1-130f-3978-2d73b4a24e7a@mleia.com>
References: <1478250907-147450-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:43761 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbcKGArK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 6 Nov 2016 19:47:10 -0500
In-Reply-To: <1478250907-147450-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>

Hi Vadim,

please find below some more nitpickings.

On 11/04/2016 11:15 AM, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
>

[snip]

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d252276..b9e1c4c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1150,6 +1150,18 @@ config I2C_ELEKTOR
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-elektor.
>
> +config I2C_MLXCPLD
> +	tristate "Mellanox I2C driver"
> +	depends on X86_64
> +	default n

Please just remove 'default n' line, unset default value in Kconfig
is the same as 'default n'.

[snip]

> +/* General defines */
> +#define MLXPLAT_CPLD_LPC_I2C_BASE_ADDR	0x2000
> +#define MLXCPLD_I2C_DEVICE_NAME		"i2c_mlxcpld"
> +#define MLXCPLD_I2C_VALID_FLAG		(I2C_M_RECV_LEN | I2C_M_RD)
> +#define MLXCPLD_I2C_BUS_NUM		1
> +#define MLXCPLD_I2C_DATA_REG_SZ		36
> +#define MLXCPLD_I2C_MAX_ADDR_LEN	4
> +#define MLXCPLD_I2C_RETR_NUM		2
> +#define MLXCPLD_I2C_XFER_TO		500000 /* msec */
> +#define MLXCPLD_I2C_POLL_TIME		2000   /* msec */

Two lines above define macro values with the microsecond unit, its
short form is denoted as "usec" and "msec" or "ms" is used to
denote milliseconds. Please correct it, transfer timeout of "500
seconds" is confusing.

[snip]

> +
> +static int mlxcpld_i2c_probe(struct platform_device *pdev)
> +{
> +	struct mlxcpld_i2c_priv *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(struct mlxcpld_i2c_priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->lock);
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->dev = &pdev->dev;
> +
> +	/* Register with i2c layer */
> +	mlxcpld_i2c_adapter.timeout = usecs_to_jiffies(MLXCPLD_I2C_XFER_TO);
> +	priv->adap = mlxcpld_i2c_adapter;
> +	priv->adap.dev.parent = &pdev->dev;
> +	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
> +	i2c_set_adapdata(&priv->adap, priv);
> +
> +	err = i2c_add_numbered_adapter(&priv->adap);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to add %s adapter (%d)\n",
> +			MLXCPLD_I2C_DEVICE_NAME, err);
> +		goto fail_adapter;
> +	}
> +
> +	return 0;
> +
> +fail_adapter:
> +	mutex_destroy(&priv->lock);
> +	return err;

Here you can save some more lines of code by changing it to

	err = i2c_add_numbered_adapter(&priv->adap);
	if (err)
		mutex_destroy(&priv->lock);

	return err;

Note, dev_err() is not needed here, because printing of the error
message is delegated to the I2C core.

> +}
> +

Please feel free to add a tag to the next version:

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir

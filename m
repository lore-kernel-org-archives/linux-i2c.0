From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [patch v5 repost 1/1] i2c: add master driver for mellanox systems
Date: Thu, 17 Nov 2016 02:20:11 +0200
Message-ID: <00091077-7fa6-6913-e2a4-81b7e805350c@mleia.com>
References: <1479280122-109711-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:45710 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754098AbcKQAUP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 16 Nov 2016 19:20:15 -0500
In-Reply-To: <1479280122-109711-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>

Hi Vadim,

I've noticed two more minor issues, please consider to fix them.

On 11/16/2016 09:08 AM, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
>
> Device driver for Mellanox I2C controller logic, implemented in Lattice
> CPLD device.
> Device supports:
>  - Master mode
>  - One physical bus
>  - Polling mode
>
> The Kconfig currently controlling compilation of this code is:
> drivers/i2c/busses/Kconfig:config I2C_MLXCPLD
>
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Still valid.

[snip]

> diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
> new file mode 100644
> index 0000000..f7a6f3a
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mlxcpld.c
> @@ -0,0 +1,551 @@
> +/*
> + * drivers/i2c/busses/i2c-mlxcpld.c

You can drop this line with the path above.

> + * Copyright (c) 2016 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2016 Michael Shych <michaels@mellanox.com>
> + *

[snip]

> +
> +/**
> + * struct mlxcpld_i2c_priv - private controller data:
> + * @lpc_gen_dec_reg: register space;

This field is gone, right?

> + * @adap: i2c adapter;
> + * @dev_id: device id;
> + * @base_addr: base IO address;
> + * @lock: bus access lock;
> + * @xfer: current i2c transfer block;
> + * @dev: device handle;
> + */
> +
> +struct mlxcpld_i2c_priv {
> +	struct i2c_adapter adap;
> +	u16 dev_id;

This field is unused, right?

> +	u16 base_addr;

For in[bwl]/out[bwl] IO addr has u32 type, it might be better to have
it u32 here as well.

> +	struct mutex lock;
> +	struct mlxcpld_i2c_curr_transf xfer;
> +	struct device *dev;
> +};
> +

[snip]

> +
> +/* Check validity of current i2c message and all transfer.
> + * Calculate also coomon length of all i2c messages in transfer.

Typo, s/coomon/common/

> + */
> +static int mlxcpld_i2c_invalid_len(struct mlxcpld_i2c_priv *priv,
> +				   const struct i2c_msg *msg, u8 *comm_len)

[snip]

> +
> +/* Make sure the CPLD is ready to start transmitting.
> + * Return 0 if it is, -EBUSY if it is not.
> + */

While it has no runtime effect, the function returns -EIO if bus is
busy. If you add a comment (by the way you may consider to remove it),
please make it aligned with the function.

> +static int mlxcpld_i2c_check_busy(struct mlxcpld_i2c_priv *priv)
> +{
> +	u8 val;
> +
> +	mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_STATUS_REG, &val, 1);
> +
> +	if (val & MLXCPLD_LPCI2C_TRANS_END)
> +		return 0;
> +
> +	return -EIO;
> +}
> +

[snip]

> +
> +static int mlxcpld_i2c_probe(struct platform_device *pdev)
> +{
> +	struct mlxcpld_i2c_priv *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(struct mlxcpld_i2c_priv),
> +			    GFP_KERNEL);

Common practice to avoid hypothetical problems in future after struct
renamings etc. is to get sizeof() of the target storage, here it
should be changed to:

	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);

There is no dereferencing, so it is a safe expression.

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
> +	if (err)
> +		mutex_destroy(&priv->lock);
> +
> +	return err;
> +}

--
With best wishes,
Vladimir

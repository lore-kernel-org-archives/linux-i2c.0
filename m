From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [patch v3 1/1] i2c: add master driver for mellanox systems
Date: Fri, 4 Nov 2016 00:34:15 +0200
Message-ID: <4708bff8-db23-e9c3-197d-ab337affa080@mleia.com>
References: <1478199036-188306-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:37968 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752984AbcKCWeS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 3 Nov 2016 18:34:18 -0400
In-Reply-To: <1478199036-188306-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>

Hi Vadim,

please find some more review comments below.

On 03.11.2016 20:50, vadimp@mellanox.com wrote:
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
> ---

[snip]

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d252276..be885d2 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1150,6 +1150,18 @@ config I2C_ELEKTOR
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-elektor.
>  
> +config I2C_MLXCPLD
> +	tristate "Mellanox I2C driver"
> +	depends on X86_64
> +	default y

I believe the controller is not a widely used piece of hardware found
on every second laptop.

Please remove 'default y' line from the Kconfig record.

> +	help
> +	  This exposes the Mellanox platform I2C busses to the linux I2C layer
> +	  for X86 based systems.
> +	  Controller is implemented as CPLD logic.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called as i2c-mlxcpld.
> +
>  config I2C_PCA_ISA
>  	tristate "PCA9564/PCA9665 on an ISA bus"
>  	depends on ISA

[snip]

> +
> +struct mlxcpld_i2c_priv {
> +	struct i2c_adapter adap;
> +	u16 dev_id;
> +	u16 base_addr;
> +	struct mutex lock;
> +	struct mlxcpld_i2c_curr_transf xfer;
> +	struct device *dev;
> +};
> +struct platform_device *mlxcpld_i2c_plat_dev;

This global variable is unused.

And it emits several static check warnings:

checkpatch --strict:

CHECK: Please use a blank line after function/struct/union/enum declarations
#324: FILE: drivers/i2c/busses/i2c-mlxcpld.c:110:
+};
+struct platform_device *mlxcpld_i2c_plat_dev;

smatch:

  i2c-mlxcpld.c:110:24: warning: symbol 'mlxcpld_i2c_plat_dev' was not declared. Should it be static?

Please remove it as unused.

[snip]

> +
> +/* Check validity of current i2c message and all transfer.
> + * Calculate also coomon length of all i2c messages in transfer.
> + */
> +static int mlxcpld_i2c_invalid_len(struct mlxcpld_i2c_priv *priv,
> +				   const struct i2c_msg *msg, u8 *comm_len)
> +{
> +	u8 max_len = msg->flags == I2C_M_RD ? MLXCPLD_I2C_DATA_REG_SZ -
> +		     MLXCPLD_I2C_MAX_ADDR_LEN : MLXCPLD_I2C_DATA_REG_SZ;
> +
> +	if (msg->len < 0 || msg->len > max_len)

Compiler W=1 level warning:

i2c-mlxcpld.c: In function 'mlxcpld_i2c_invalid_len':
i2c-mlxcpld.c:201:15: warning: comparison is always false due to limited range of data type [-Wtype-limits]
  if (msg->len < 0 || msg->len > max_len)
               ^

msg->len is unsigned.

> +		return -EINVAL;
> +
> +	*comm_len += msg->len;
> +	if (*comm_len > MLXCPLD_I2C_DATA_REG_SZ)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Check validity of received i2c messages parameters.
> + *  Returns 0 if OK, other - in case of invalid parameters
> + *  or common length of data that should be passed to CPLD

Sorry for nitpicking, you may consider to remove one of two spaces
after asterisks above.

[snip]

> +
> +static void mlxcpld_i2c_set_transf_data(struct mlxcpld_i2c_priv *priv,
> +					struct i2c_msg *msgs, int num,
> +					u8 comm_len)
> +{
> +	priv->xfer.msg = msgs;
> +	priv->xfer.msg_num = num;
> +
> +	/*
> +	 * All upper layers currently are never use transfer with more than
> +	 * 2 messages. Actually, it's also not so relevant in Mellanox systems
> +	 * because of HW limitation. Max size of transfer is o more than 20B
> +	 * in current x86 LPCI2C bridge.
> +	 */
> +	priv->xfer.cmd = (msgs[num - 1].flags & I2C_M_RD);

Round brackets are not needed above.

> +
> +	if (priv->xfer.cmd == I2C_M_RD && comm_len != msgs[0].len) {
> +		priv->xfer.addr_width = msgs[0].len;
> +		priv->xfer.data_len = comm_len - priv->xfer.addr_width;
> +	} else {
> +		priv->xfer.addr_width = 0;
> +		priv->xfer.data_len = comm_len;
> +	}
> +}
> +

[snip]

> +/*
> + * Wait for master transfer to complete.
> + * It puts current process to sleep until we get interrupt or timeout expires.
> + * Returns the number of transferred or read bytes or error (<0).
> + */
> +static int mlxcpld_i2c_wait_for_tc(struct mlxcpld_i2c_priv *priv)
> +{
> +	int status, i = 1, timeout = 0;

Please remove the assignment of 'i' variable, after update it is
not needed anymore.

> +	u8 datalen;
> +
> +	do {
> +		usleep_range(MLXCPLD_I2C_POLL_TIME / 2, MLXCPLD_I2C_POLL_TIME);
> +		if (!mlxcpld_i2c_check_status(priv, &status))
> +			break;
> +		timeout += MLXCPLD_I2C_POLL_TIME;
> +	} while (status == 0 && timeout < MLXCPLD_I2C_XFER_TO);
> +
> +	switch (status) {
> +	case MLXCPLD_LPCI2C_NO_IND:
> +		return -ETIMEDOUT;
> +
> +	case MLXCPLD_LPCI2C_ACK_IND:
> +		if (priv->xfer.cmd != I2C_M_RD)
> +			return (priv->xfer.addr_width + priv->xfer.data_len);
> +
> +		if (priv->xfer.msg_num == 1)
> +			i = 0;
> +		else
> +			i = 1;
> +
> +		if (!priv->xfer.msg[i].buf)
> +			return -EINVAL;
> +
> +		/*
> +		 * Actual read data len will be always the same as
> +		 * requested len. 0xff (line pull-up) will be returned
> +		 * if slave has no data to return. Thus don't read
> +		 * MLXCPLD_LPCI2C_NUM_DAT_REG reg from CPLD.
> +		 */
> +		datalen = priv->xfer.data_len;
> +
> +		mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_DATA_REG,
> +				      priv->xfer.msg[i].buf, datalen);
> +
> +		return datalen;
> +
> +	case MLXCPLD_LPCI2C_NACK_IND:
> +		return -EAGAIN;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

[snip]

> +
> +/* Generic lpc-i2c transfer.

Just for my information, how do you unwrap 'lpc' acronym found in the code?

> + * Returns the number of processed messages or error (<0).
> + */
> +static int mlxcpld_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			    int num)
> +{
> +	struct mlxcpld_i2c_priv *priv = i2c_get_adapdata(adap);
> +	u8 comm_len = 0;
> +	int err;
> +
> +	err = mlxcpld_i2c_check_msg_params(priv, msgs, num, &comm_len);
> +	if (err) {
> +		dev_err(priv->dev, "Incorrect message\n");
> +		return err;
> +	}
> +
> +	/* Check bus state */
> +	if (mlxcpld_i2c_wait_for_free(priv)) {
> +		dev_err(priv->dev, "LPCI2C bridge is busy\n");
> +
> +		/*
> +		 * Usually it means something serious has happened.
> +		 * We can not have unfinished previous transfer
> +		 * so it doesn't make any sense to try to stop it.
> +		 * Probably we were not able to recover from the
> +		 * previous error.
> +		 * The only reasonable thing - is soft reset.
> +		 */
> +		mlxcpld_i2c_reset(priv);
> +		if (mlxcpld_i2c_check_busy(priv)) {
> +			dev_err(priv->dev, "LPCI2C bridge is busy after reset\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	mlxcpld_i2c_set_transf_data(priv, msgs, num, comm_len);
> +
> +	mutex_lock(&priv->lock);
> +
> +	/* Do real transfer. Can't fail */
> +	mlxcpld_i2c_xfer_msg(priv);

Please add an empty line here to improve readability.

> +	/* Wait for transaction complete */
> +	err = mlxcpld_i2c_wait_for_tc(priv);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return err < 0 ? err : num;
> +}
> +
> +static u32 mlxcpld_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +static const struct i2c_algorithm mlxcpld_i2c_algo = {
> +	.master_xfer	= mlxcpld_i2c_xfer,
> +	.functionality	= mlxcpld_i2c_func
> +};
> +
> +static struct i2c_adapter mlxcpld_i2c_adapter = {
> +	.owner          = THIS_MODULE,
> +	.name           = "i2c-mlxcpld",
> +	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
> +	.algo           = &mlxcpld_i2c_algo,
> +};
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
> +	priv->adap = mlxcpld_i2c_adapter;
> +	priv->adap.dev.parent = &pdev->dev;
> +	priv->adap.retries = MLXCPLD_I2C_RETR_NUM;
> +	priv->adap.nr = MLXCPLD_I2C_BUS_NUM;

So since you want to allow the registration of only one such controller
on a board (by the way in the opposite case it is also expected that
"struct i2c_adapter" is allocated dynamically to avoid rewriting of
data), you probably know the good reason behind it.

But in that case you may consider to move .retries and .nr
instantiation to the "static struct i2c_adapter" declaration above.

> +	priv->adap.timeout = usecs_to_jiffies(MLXCPLD_I2C_XFER_TO);
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
> +}
> +
> +static int mlxcpld_i2c_remove(struct platform_device *pdev)
> +{
> +	struct mlxcpld_i2c_priv *priv = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&priv->adap);
> +	mutex_destroy(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mlxcpld_i2c_driver = {
> +	.probe		= mlxcpld_i2c_probe,
> +	.remove		= mlxcpld_i2c_remove,
> +	.driver = {
> +		.name = MLXCPLD_I2C_DEVICE_NAME,
> +	},
> +};
> +
> +module_platform_driver(mlxcpld_i2c_driver);
> +
> +MODULE_AUTHOR("Michael Shych <michaels@mellanox.com>");
> +MODULE_DESCRIPTION("Mellanox I2C-CPLD controller driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_ALIAS("platform:i2c-mlxcpld");
> 

Generally the driver looks good and simple.

--
With best wishes,
Vladimir

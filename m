From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/4] mfd: menf21bmc: Remove auto exiting of production
 mode and add sysfs interface
Date: Mon, 25 Jan 2016 16:08:34 +0000
Message-ID: <20160125160834.GW3368@x1>
References: <cover.1452514293.git.andreas.werner@men.de>
 <8bc6f00ae04ace01910030641fb9918d4bda4065.1452514293.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8bc6f00ae04ace01910030641fb9918d4bda4065.1452514293.git.andreas.werner@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 11 Jan 2016, Andreas Werner wrote:

> Changed "exit production mode" from automatic exiting to
> manually using the sysfs interface.
>=20
> If the driver exit the production mode automatically, the board will
> not start anymore if the bootloader does not already have the "BIOS l=
ife sign"
> feature.
>=20
> This patch remove the auto mechanism and add a sysfs interface to man=
ually
> exiting the production e.g. during the EOL test of the board.
>=20
> Signed-off-by: Andreas Werner <andreas.werner@men.de>
> ---
>  drivers/mfd/menf21bmc.c | 65 +++++++++++++++++++++++++++++++++------=
----------
>  1 file changed, 44 insertions(+), 21 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
> index 1c27434..b11bd6b 100644
> --- a/drivers/mfd/menf21bmc.c
> +++ b/drivers/mfd/menf21bmc.c
> @@ -27,31 +27,57 @@ static struct mfd_cell menf21bmc_cell[] =3D {
>  	{ .name =3D "menf21bmc_hwmon", }
>  };
> =20
> -static int menf21bmc_wdt_exit_prod_mode(struct i2c_client *client)
> +static ssize_t menf21bmc_mode_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
>  {
> -	int val, ret;
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	int val;
> =20
>  	val =3D i2c_smbus_read_byte_data(client, BMC_CMD_WDT_PROD_STAT);
>  	if (val < 0)
>  		return val;
> =20
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t menf21bmc_mode_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t size)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	unsigned long mode_val;
> +	int ret;
> +
> +	if (kstrtoul(buf, 0, &mode_val))
> +		return -EINVAL;
> +
>  	/*
> -	 * Production mode should be not active after delivery of the Board=
=2E
> -	 * To be sure we check it, inform the user and exit the mode
> -	 * if active.
> +	 * We cannot set the production mode (0).
> +	 * This is the default mode. If exited once,
> +	 * it cannot be set anymore.
>  	 */
> -	if (val =3D=3D 0x00) {
> -		dev_info(&client->dev,
> -			"BMC in production mode. Exit production mode\n");
> +	if (!mode_val)
> +		return -EINVAL;
> =20
> -		ret =3D i2c_smbus_write_byte(client, BMC_CMD_WDT_EXIT_PROD);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret =3D i2c_smbus_write_byte(client, BMC_CMD_WDT_EXIT_PROD);
> +	if (ret < 0)
> +		return ret;
> =20
> -	return 0;
> +	return size;
>  }
> =20
> +static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, menf21bmc_mode_show,
> +		   menf21bmc_mode_store);
> +
> +static struct attribute *menf21bmc_attributes[] =3D {
> +	&dev_attr_mode.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group menf21bmc_attr_group =3D {
> +	.attrs =3D menf21bmc_attributes,
> +};
> +
>  static int
>  menf21bmc_probe(struct i2c_client *client, const struct i2c_device_i=
d *ids)
>  {
> @@ -86,20 +112,15 @@ menf21bmc_probe(struct i2c_client *client, const=
 struct i2c_device_id *ids)
>  	dev_info(&client->dev, "FW Revision: %02d.%02d.%02d\n",
>  		 rev_major, rev_minor, rev_main);
> =20
> -	/*
> -	 * We have to exit the Production Mode of the BMC to activate the
> -	 * Watchdog functionality and the BIOS life sign monitoring.
> -	 */
> -	ret =3D menf21bmc_wdt_exit_prod_mode(client);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "failed to leave production mode\n");
> +	ret =3D sysfs_create_group(&client->dev.kobj, &menf21bmc_attr_group=
);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	ret =3D mfd_add_devices(&client->dev, 0, menf21bmc_cell,
>  			      ARRAY_SIZE(menf21bmc_cell), NULL, 0, NULL);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "failed to add BMC sub-devices\n");
> +		sysfs_remove_group(&client->dev.kobj, &menf21bmc_attr_group);
>  		return ret;
>  	}
> =20
> @@ -108,7 +129,9 @@ menf21bmc_probe(struct i2c_client *client, const =
struct i2c_device_id *ids)
> =20
>  static int menf21bmc_remove(struct i2c_client *client)
>  {
> +	sysfs_remove_group(&client->dev.kobj, &menf21bmc_attr_group);
>  	mfd_remove_devices(&client->dev);
> +
>  	return 0;
>  }
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

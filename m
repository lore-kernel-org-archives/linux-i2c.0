From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RESEND] [PATCH] i2c: Support for Netlogic XLR/XLS on-chip I2C
	controller.
Date: Sat, 9 Jul 2011 10:37:42 +0100
Message-ID: <20110709093742.GA9247@sirena.org.uk>
References: <20110623135057.GA26772@jayachandranc.netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110623135057.GA26772-l4W0uAg2RDvWG0bvociYJ/An/qbn1+6FOui0OUZsNXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 08, 2011 at 03:42:04PM +0530, Jayachandran C. wrote:

>  arch/mips/configs/nlm_xlr_defconfig |    4 +
>  arch/mips/netlogic/xlr/platform.c   |   29 +++
>  drivers/i2c/busses/Kconfig          |   11 ++
>  drivers/i2c/busses/Makefile         |    1 +
>  drivers/i2c/busses/i2c-xlr.c        |  335 +++++++++++++++++++++++++++++++++++

Normally the arch/mips code would be split out from the driver patch.

> +config I2C_XLR
> +	tristate "XLR I2C support"
> +	depends on I2C && CPU_XLR

No need to depend on I2C in the I2C drivers directory.

> +struct xlr_i2c_private {
> +	struct i2c_adapter adap;
> +	u32 *iobase_i2c_regs;
> +};

Should there be an __iomem in there?

> +static struct xlr_i2c_private  xlr_i2c_priv;

This shouldn't be static data, it should be allocated per device.

> +u32 *get_i2c_base(unsigned short bus)
> +{
> +	nlm_reg_t *mmio = 0;
> +
> +	if (bus == 0)
> +		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_0_OFFSET);
> +	else
> +		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_1_OFFSET);
> +
> +	return (u32 *)mmio;

Functions like this should be static, though in this case the memory
region should be passed in as a resource rather than being embedded in
the driver.

> +	while (1) {
> +		i2c_status = xlr_i2c_read(priv->iobase_i2c_regs,
> +				XLR_I2C_STATUS);
> +
> +		if (i2c_status & XLR_I2C_SDOEMPTY) {
> +			pos++;
> +			nb = (pos < len) ? buf[pos] : 0;
> +			xlr_i2c_write(priv->iobase_i2c_regs, XLR_I2C_DATAOUT,
> +					nb);
> +		}
> +
> +		if (i2c_status & XLR_I2C_ARB_STARTERR)
> +			goto retry;
> +
> +		if (i2c_status & XLR_I2C_ACK_ERR) {
> +			dev_err(&priv->adap.dev, "ACK ERR\n");
> +			return -1;

Return a proper error code, not -1.

> +		}
> +
> +		if (i2c_status & XLR_I2C_BUS_BUSY)
> +			continue;

This is going to loop infinitely if the bus locks up for some reason.
There should be some limit on how long we try for.  It also looks like
we're busy waiting here which isn't terribly good.

> +static int __devinit xlr_i2c_probe(struct platform_device *pd)
> +{
> +	xlr_i2c_priv.iobase_i2c_regs = get_i2c_base(pd->id);
> +
> +	xlr_i2c_priv.adap.dev.parent = &pd->dev;
> +	if (xlr_i2c_add_bus(&xlr_i2c_priv) < 0) {
> +		dev_err(&xlr_i2c_priv.adap.dev, "Failed to add i2c bus\n");

You should return the error you get.

> +	} else
> +		dev_info(&xlr_i2c_priv.adap.dev, "Added I2C Bus.\n");

This seems needlessly chatty.

> +MODULE_AUTHOR("Netlogic Microsystems Inc.");

This should generally be a person.

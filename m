From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date: Tue, 17 Jan 2012 23:23:18 +0000
Message-ID: <20120117232318.GB7774@freya.fluff.org>
References: <1326808100-22540-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1326808100-22540-2-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326808100-22540-2-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, inux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 17, 2012 at 07:18:20PM +0530, Jayachandran C. wrote:
> From: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> 
> Add support for the intergrated I2C controller on Netlogic
> XLR/XLS MIPS SoC.
> 
> The changes are to add a new file i2c/buses/i2c-xlr.c, containing the
> i2c bus implementation, and to update i2c/buses/{Kconfig,Makefile} to
> add the CONFIG_I2C_XLR option.
> 
> Signed-off-by: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig   |   14 ++
>  drivers/i2c/busses/Makefile  |    1 +
>  drivers/i2c/busses/i2c-xlr.c |  307 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 322 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-xlr.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index cbe7a2f..7052628 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -308,6 +308,20 @@ config I2C_AU1550
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-au1550.
>  
> +config I2C_XLR
> +	tristate "XLR I2C support"
> +	depends on CPU_XLR
> +	help
> +	  This driver enables support for the on-chip I2C interface of
> +	  the Netlogic XLR/XLS MIPS processors.
> +
> +	  Say yes to this option if you have a Netlogic XLR/XLS based
> +	  board and you need to access the I2C devices (typically the
> +	  RTC, sensors, EEPROM) connected to this interface.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-au1550.
> +
>  config I2C_BLACKFIN_TWI
>  	tristate "Blackfin TWI I2C support"
>  	depends on BLACKFIN
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index fba6da6..4372dee 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
>  obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
>  obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
>  obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
> +obj-$(CONFIG_I2C_XLR)           += i2c-xlr.o
>  obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
>  
>  # External I2C/SMBus adapter drivers
> diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
> new file mode 100644
> index 0000000..6da0fa9
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-xlr.c
> @@ -0,0 +1,307 @@
> +/*
> + * Copyright 2011, Netlogic Microsystems Inc.
> + * Copyright 2004, Matt Porter <mporter-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +/* XLR I2C REGISTERS */
> +#define XLR_I2C_CFG		0x00
> +#define XLR_I2C_CLKDIV		0x01
> +#define XLR_I2C_DEVADDR		0x02
> +#define XLR_I2C_ADDR		0x03
> +#define XLR_I2C_DATAOUT		0x04
> +#define XLR_I2C_DATAIN		0x05
> +#define XLR_I2C_STATUS		0x06
> +#define XLR_I2C_STARTXFR	0x07
> +#define XLR_I2C_BYTECNT		0x08
> +#define XLR_I2C_HDSTATIM	0x09
> +
> +/* XLR I2C REGISTERS FLAGS */
> +#define XLR_I2C_BUS_BUSY	0x01
> +#define XLR_I2C_SDOEMPTY	0x02
> +#define XLR_I2C_RXRDY		0x04
> +#define XLR_I2C_ACK_ERR		0x08
> +#define XLR_I2C_ARB_STARTERR	0x30
> +
> +/* Register Values */
> +#define XLR_I2C_CFG_ADDR	0xF8
> +#define XLR_I2C_CFG_NOADDR	0xFA
> +#define XLR_I2C_STARTXFR_ND	0x02    /* No Data */
> +#define XLR_I2C_STARTXFR_RD	0x01    /* Read */
> +#define XLR_I2C_STARTXFR_WR	0x00    /* Write */
> +
> +#define XLR_I2C_IO_SIZE		0x1000
> +
> +#define MAX_RETRIES		10000 /* max retries per byte */
> +/*
> + * Need un-swapped IO for the SoC I2C registers, use __raw_ IO
> + */
> +static inline void xlr_i2c_wreg(u32 __iomem *base, unsigned int reg, u32 val)
> +{
> +	__raw_writel(val, base + reg);
> +}
> +
> +static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
> +{
> +	return __raw_readl(base + reg);
> +}

Here, there's the use of __raw accessors with memory returned from
ioremap(). Please use readl/writel here, or provide a _good_ reason
for not using them.

> +struct xlr_i2c_private {
> +	struct i2c_adapter adap;
> +	u32 __iomem *iobase;
> +};
> +
> +static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
> +		u8 *buf, u16 addr)
> +{
> +	struct i2c_adapter *adap = &priv->adap;
> +	u32 i2c_status;
> +	int pos, retries;
> +	u8 offset, nb;
> +
> +	offset = buf[0];
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
> +
> +	retries = 0;
> +retry:
> +	pos = 1;
> +	if (len == 1) {
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +				XLR_I2C_STARTXFR_ND);
> +	} else {
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +				XLR_I2C_STARTXFR_WR);
> +	}
> +
> +	while (1) {
> +		if (retries++ > MAX_RETRIES) {
> +			dev_err(&adap->dev, "I2C transmit timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
> +
> +		if (i2c_status & XLR_I2C_SDOEMPTY) {
> +			pos++;
> +			retries = 0;
> +			nb = (pos < len) ? buf[pos] : 0;
> +			xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, nb);
> +		}
> +
> +		if (i2c_status & XLR_I2C_ARB_STARTERR)
> +			goto retry;
> +
> +		if (i2c_status & XLR_I2C_ACK_ERR)
> +			return -EIO;
> +
> +		if (i2c_status & XLR_I2C_BUS_BUSY)
> +			continue;
> +
> +		if (pos >= len)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
> +{
> +	struct i2c_adapter *adap = &priv->adap;
> +	u32 i2c_status;
> +	int pos, retries;
> +
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
> +
> +	retries = 0;
> +	pos = 0;
> +retry:
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR, XLR_I2C_STARTXFR_RD);
> +
> +	while (1) {
> +		if (retries++ > MAX_RETRIES) {
> +			dev_err(&adap->dev, "I2C receive timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
> +		if (i2c_status & XLR_I2C_RXRDY) {
> +			buf[pos++] = (u8)xlr_i2c_rdreg(priv->iobase,
> +					XLR_I2C_DATAIN);
> +			retries = 0;
> +		}
> +
> +		if (i2c_status & XLR_I2C_ARB_STARTERR)
> +			goto retry;
> +
> +		if (i2c_status & XLR_I2C_ACK_ERR) {
> +			dev_err(&adap->dev, "I2C receive ACK error\n");
> +			return -EIO;
> +		}
> +
> +		if ((i2c_status & XLR_I2C_BUS_BUSY) == 0)
> +			break;
> +	}
> +	return 0;
> +}
> +
> +static int xlr_i2c_xfer(struct i2c_adapter *adap,
> +		struct i2c_msg *msgs, int num)
> +{
> +	struct i2c_msg *msg;
> +	int i;
> +	int ret = 0;
> +	struct xlr_i2c_private *priv = i2c_get_adapdata(adap);
> +
> +	for (i = 0; ret == 0 && i < num; i++) {
> +		msg = &msgs[i];
> +		if (msg->flags & I2C_M_RD)
> +			ret = xlr_i2c_rx(priv, msg->len, &msg->buf[0],
> +					msg->addr);
> +		else
> +			ret = xlr_i2c_tx(priv, msg->len, &msg->buf[0],
> +					msg->addr);
> +	}
> +
> +	return (ret != 0) ? ret : num;
> +}
> +
> +static u32 xlr_func(struct i2c_adapter *adap)
> +{
> +	/* Emulate SMBUS over I2C */
> +	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
> +}
> +
> +static struct i2c_algorithm xlr_i2c_algo = {
> +	.master_xfer	= xlr_i2c_xfer,
> +	.functionality	= xlr_func,
> +};
> +
> +static int xlr_i2c_add_bus(struct xlr_i2c_private *priv)
> +{
> +	priv->adap.owner	= THIS_MODULE;
> +	priv->adap.algo_data	= priv;
> +	priv->adap.nr		= 1;
> +	priv->adap.algo		= &xlr_i2c_algo;
> +	priv->adap.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +	snprintf(priv->adap.name, sizeof(priv->adap.name),
> +			"SMBus XLR I2C Adapter");
> +	i2c_set_adapdata(&priv->adap, priv);
> +	/* register new adapter to i2c module... */
> +	if (i2c_add_numbered_adapter(&priv->adap))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int __devinit xlr_i2c_probe(struct platform_device *pdev)
> +{
> +	struct xlr_i2c_private  *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!res) {
> +		ret = -ENXIO;
> +		goto err1;
> +	}
> +
> +	if (!request_mem_region(res->start, XLR_I2C_IO_SIZE, pdev->name)) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		ret = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	priv->adap.dev.parent = &pdev->dev;
> +	priv->iobase = ioremap(res->start, XLR_I2C_IO_SIZE);
> +	if (!priv->iobase) {
> +		ret = -ENOMEM;
> +		goto err3;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +	ret = xlr_i2c_add_bus(priv);
> +
> +	if (ret < 0) {
> +		dev_err(&priv->adap.dev, "Failed to add i2c bus.\n");
> +		ret = -ENXIO;

Hmm, not sure if -ENXIO is the best return code form here. I would probably
leave the 'ret' alone, and pass it to the upper layer.

> +		goto err4;
> +	} else
> +		dev_info(&priv->adap.dev, "Added I2C Bus.\n");
> +
> +	return 0;
> +err4:
> +	iounmap(priv->iobase);
> +	platform_set_drvdata(pdev, NULL);
> +err3:
> +	kfree(priv);
> +err2:
> +	release_mem_region(res->start, IORESOURCE_MEM);
> +err1:
> +	return ret;
> +}
> +
> +static int __devexit xlr_i2c_remove(struct platform_device *pdev)
> +{
> +	struct xlr_i2c_private *priv = platform_get_drvdata(pdev);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	i2c_del_adapter(&priv->adap);
> +	iounmap(priv->iobase);
> +	kfree(priv);
> +	release_mem_region(res->start, IORESOURCE_MEM);
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +static struct platform_driver xlr_i2c_driver = {
> +	.probe  = xlr_i2c_probe,
> +	.remove = __devexit_p(xlr_i2c_remove),
> +	.driver = {
> +		.owner  = THIS_MODULE,
> +		.name   = "xlr-i2cbus",
> +	},
> +};
> +
> +static int __init xlr_i2c_init(void)
> +{
> +	return platform_driver_register(&xlr_i2c_driver);
> +}
> +
> +static void __exit xlr_i2c_exit(void)
> +{
> +	platform_driver_unregister(&xlr_i2c_driver);
> +}
> +
> +MODULE_AUTHOR("Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>");
> +MODULE_DESCRIPTION("XLR I2C SMBus driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:xlr-i2cbus");
> +
> +module_init(xlr_i2c_init);
> +module_exit(xlr_i2c_exit);
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

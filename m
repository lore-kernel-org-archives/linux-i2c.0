From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: convert to platform driver
Date: Fri, 18 Jan 2008 19:55:46 +0100
Message-ID: <20080118195546.1d3818a9@hyperion.delvare>
References: <20071006161606.GB9270@roarinelk.homelinux.net>
	<20071027200521.3d800147@hyperion.delvare>
	<20080118095320.GA20550@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080118095320.GA20550-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

On Fri, 18 Jan 2008 10:53:20 +0100, Manuel Lauss wrote:
> To make my humiliation complete, here's the third iteration
> of this patch. The original authors put a lot of 'volatile's
> in there for good reason; without them the driver hangs very
> early. The previous iteration removed them because of checkpatch
> complaining.
> (...)
> Convert the i2c-au1550 bus driver to platform driver, and
> register a platform device for the Alchemy Db/Pb series of
> boards.
> 
> Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> ---
>  arch/mips/au1000/common/platform.c |   24 +++++
>  drivers/i2c/busses/i2c-au1550.c    |  166 ++++++++++++++++++++++--------------
>  drivers/i2c/busses/i2c-au1550.h    |   32 -------
>  3 files changed, 126 insertions(+), 96 deletions(-)
>  delete mode 100644 drivers/i2c/busses/i2c-au1550.h

Thanks for the updated patch. Review:

> 
> diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
> index d51e18f..5f47674 100644
> --- a/arch/mips/au1000/common/platform.c
> +++ b/arch/mips/au1000/common/platform.c
> @@ -270,6 +270,27 @@ static struct platform_device smc91x_device = {
>  
>  #endif
>  
> +/* All Alchemy demoboards with I2C have this #define in their headers */
> +#ifdef SMBUS_PSC_BASE
> +static struct resource pbdb_smbus_resources[] = {
> +	{
> +		.start  = SMBUS_PSC_BASE,
> +		.end    = SMBUS_PSC_BASE + 0x24 - 1,
> +		.flags  = IORESOURCE_MEM,

You are supposed to achieve the alignment with tabs, not spaces. Your
original patch was correct, not sure why you changed it.

> +	},
> +};
> +
> +static struct platform_device pbdb_smbus_device = {
> +	.dev = {
> +		.platform_data = (void *)0,	/* bus number */
> +	},

I don't much like pointers abused to carry integers, and it doesn't
seem very helpful in this case: you can simply use .id below as the bus
number, as many other similar drivers do.

> +	.name           = "au1xpsc_smbus",
> +	.id             = 0,
> +	.num_resources  = ARRAY_SIZE(pbdb_smbus_resources),
> +	.resource       = pbdb_smbus_resources,

Here again the alignment should be achieved with tabs.

> +};
> +#endif
> +
>  static struct platform_device *au1xxx_platform_devices[] __initdata = {
>  	&au1xxx_usb_ohci_device,
>  	&au1x00_pcmcia_device,
> @@ -287,6 +308,9 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
>  #ifdef CONFIG_MIPS_DB1200
>  	&smc91x_device,
>  #endif
> +#ifdef SMBUS_PSC_BASE
> +	&pbdb_smbus_device,
> +#endif
>  };
>  
>  int __init au1xxx_platform_init(void)
> diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
> index 7d51a43..a03c2d1 100644
> --- a/drivers/i2c/busses/i2c-au1550.c
> +++ b/drivers/i2c/busses/i2c-au1550.c
> @@ -30,14 +30,22 @@
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/init.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> +#include <linux/slab.h>
>  
>  #include <asm/mach-au1x00/au1xxx.h>
>  #include <asm/mach-au1x00/au1xxx_psc.h>
>  
> -#include "i2c-au1550.h"
> +struct i2c_au1550_data {
> +	u32	psc_base;
> +	int	xfer_timeout;
> +	int	ack_timeout;
> +	struct i2c_adapter adap;
> +	struct resource *ioarea;
> +};
>  
>  static int
>  wait_xfer_done(struct i2c_au1550_data *adap)
> @@ -299,18 +307,48 @@ static const struct i2c_algorithm au1550_algo = {
>   * Prior to calling us, the 50MHz clock frequency and routing
>   * must have been set up for the PSC indicated by the adapter.
>   */
> -int
> -i2c_au1550_add_bus(struct i2c_adapter *i2c_adap)
> +static int __devinit
> +i2c_au1550_probe(struct platform_device *pdev)
>  {
> -	struct i2c_au1550_data *adap = i2c_adap->algo_data;
> -	volatile psc_smb_t	*sp;
> -	u32	stat;
> +	struct i2c_au1550_data *priv;
> +	volatile psc_smb_t *sp;
> +	struct resource *r;
> +	u32 stat;
> +	int ret;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
>  
> -	i2c_adap->algo = &au1550_algo;
> +	priv = kzalloc(sizeof(struct i2c_au1550_data), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	priv->ioarea = request_mem_region(r->start, r->end - r->start + 1,
> +					  pdev->name);
> +	if (!priv->ioarea) {
> +		ret = -EBUSY;
> +		goto out_mem;
> +	}
> +
> +	priv->psc_base = r->start;
> +	priv->xfer_timeout = 200;
> +	priv->ack_timeout = 200;
> +
> +	priv->adap.id = I2C_HW_AU1550_PSC;
> +	priv->adap.nr = (int)pdev->dev.platform_data;
> +	priv->adap.algo = &au1550_algo;
> +	priv->adap.algo_data = priv;
> +	priv->adap.dev.parent = &pdev->dev;
> +	strlcpy(priv->adap.name, "Au1xxx PSC I2C", 14);

The "size" argument is supposed to be the buffer size (i.e.
sizeof(priv->adap.name)), not the length of the string!

>  
>  	/* Now, set up the PSC for SMBus PIO mode.
>  	*/
> -	sp = (volatile psc_smb_t *)(adap->psc_base);
> +	sp = (volatile psc_smb_t *)priv->psc_base;
>  	sp->psc_ctrl = PSC_CTRL_DISABLE;
>  	au_sync();
>  	sp->psc_sel = PSC_SEL_PS_SMBUSMODE;
> @@ -348,87 +386,87 @@ i2c_au1550_add_bus(struct i2c_adapter *i2c_adap)
>  		au_sync();
>  	} while ((stat & PSC_SMBSTAT_DR) == 0);
>  
> -	return i2c_add_adapter(i2c_adap);
> -}
> +	ret = i2c_add_numbered_adapter(&priv->adap);
> +	if (ret == 0) {
> +		platform_set_drvdata(pdev, priv);
> +		return 0;
> +	}
> +
> +	/* disable the PSC */
> +	sp->psc_smbcfg = 0;
> +	sp->psc_ctrl = PSC_CTRL_DISABLE;
> +	au_sync();
>  
> +	release_resource(priv->ioarea);
> +	kfree(priv->ioarea);

I expected a call to release_mem_region() instead... but maybe that
works as well.

> +out_mem:
> +	kfree(priv);
> +out:
> +	return ret;
> +}
>  
> -int
> -i2c_au1550_del_bus(struct i2c_adapter *adap)
> +static int __devexit
> +i2c_au1550_remove(struct platform_device *pdev)
>  {
> -	return i2c_del_adapter(adap);
> +	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
> +	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
> +
> +	platform_set_drvdata(pdev, NULL);
> +	i2c_del_adapter(&priv->adap);
> +	sp->psc_smbcfg = 0;
> +	sp->psc_ctrl = PSC_CTRL_DISABLE;
> +	au_sync();
> +	release_resource(priv->ioarea);
> +	kfree(priv->ioarea);
> +	kfree(priv);
> +	return 0;
>  }
>  
>  static int
> -pb1550_reg(struct i2c_client *client)
> +i2c_au1550_suspend(struct platform_device *pdev, pm_message_t state)
>  {
> +	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
> +	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
> +
> +	sp->psc_ctrl = PSC_CTRL_SUSPEND;
> +	au_sync();
>  	return 0;
>  }
>  
>  static int
> -pb1550_unreg(struct i2c_client *client)
> +i2c_au1550_resume(struct platform_device *pdev)
>  {
> +	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
> +	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
> +
> +	sp->psc_ctrl = PSC_CTRL_ENABLE;
> +	au_sync();
> +	while (!(sp->psc_smbstat & PSC_SMBSTAT_SR))
> +		au_sync();
>  	return 0;
>  }
>  
> -static struct i2c_au1550_data pb1550_i2c_info = {
> -	SMBUS_PSC_BASE, 200, 200
> -};
> -
> -static struct i2c_adapter pb1550_board_adapter = {
> -	name:              "pb1550 adapter",
> -	id:                I2C_HW_AU1550_PSC,
> -	algo:              NULL,
> -	algo_data:         &pb1550_i2c_info,
> -	client_register:   pb1550_reg,
> -	client_unregister: pb1550_unreg,
> +static struct platform_driver au1xpsc_smbus_driver = {
> +	.driver = {
> +		.name	= "au1xpsc_smbus",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= i2c_au1550_probe,
> +	.remove		= __devexit_p(i2c_au1550_remove),
> +	.suspend	= i2c_au1550_suspend,
> +	.resume		= i2c_au1550_resume,
>  };
>  
> -/* BIG hack to support the control interface on the Wolfson WM8731
> - * audio codec on the Pb1550 board.  We get an address and two data
> - * bytes to write, create an i2c message, and send it across the
> - * i2c transfer function.  We do this here because we have access to
> - * the i2c adapter structure.
> - */
> -static struct i2c_msg wm_i2c_msg;  /* We don't want this stuff on the stack */
> -static	u8 i2cbuf[2];
> -
> -int
> -pb1550_wm_codec_write(u8 addr, u8 reg, u8 val)
> -{
> -	wm_i2c_msg.addr = addr;
> -	wm_i2c_msg.flags = 0;
> -	wm_i2c_msg.buf = i2cbuf;
> -	wm_i2c_msg.len = 2;
> -	i2cbuf[0] = reg;
> -	i2cbuf[1] = val;
> -
> -	return pb1550_board_adapter.algo->master_xfer(&pb1550_board_adapter, &wm_i2c_msg, 1);
> -}
> -
>  static int __init
>  i2c_au1550_init(void)
>  {
> -	printk(KERN_INFO "Au1550 I2C: ");
> -
> -	/* This is where we would set up a 50MHz clock source
> -	 * and routing.  On the Pb1550, the SMBus is PSC2, which
> -	 * uses a shared clock with USB.  This has been already
> -	 * configured by Yamon as a 48MHz clock, close enough
> -	 * for our work.
> -	 */
> -        if (i2c_au1550_add_bus(&pb1550_board_adapter) < 0) {
> -		printk("failed to initialize.\n");
> -                return -ENODEV;
> -	}
> -
> -	printk("initialized.\n");
> -	return 0;
> +	return platform_driver_register(&au1xpsc_smbus_driver);
>  }
>  
>  static void __exit
>  i2c_au1550_exit(void)
>  {
> -	i2c_au1550_del_bus(&pb1550_board_adapter);
> +	platform_driver_unregister(&au1xpsc_smbus_driver);
>  }
>  
>  MODULE_AUTHOR("Dan Malek, Embedded Edge, LLC.");
> diff --git a/drivers/i2c/busses/i2c-au1550.h b/drivers/i2c/busses/i2c-au1550.h
> deleted file mode 100644
> index fce15d1..0000000
> --- a/drivers/i2c/busses/i2c-au1550.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/*
> - * Copyright (C) 2004 Embedded Edge, LLC <dan-L1vi/lXTdtu4JprhXtzr+Q@public.gmane.org>
> - * 2.6 port by Matt Porter <mporter-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#ifndef I2C_AU1550_H
> -#define I2C_AU1550_H
> -
> -struct i2c_au1550_data {
> -	u32	psc_base;
> -	int	xfer_timeout;
> -	int	ack_timeout;
> -};
> -
> -int i2c_au1550_add_bus(struct i2c_adapter *);
> -int i2c_au1550_del_bus(struct i2c_adapter *);
> -
> -#endif /* I2C_AU1550_H */

The rest looks just fine. Please address the few remaining comments,
retest and resubmit, and I'll add this patch to my i2c tree for 2.6.25.

Thanks for doing this BTW, it's nice to see this old driver finally
converted to fit in the device driver model :)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 3/5] i2c: designware: Add slave definitions
Date: Wed, 07 Dec 2016 21:11:23 +0200
Message-ID: <1481137883.30772.13.camel@linux.intel.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
         <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2016-12-07 at 17:55 +0000, Luis Oliveira wrote:
> - Add slave definitions to i2c-designware-core
> - Changes in Kconfig to auto-enable I2C_SLAVE when compiling the
> modules
> - Add mode property to designware-core.txt that enable the "slave"
> selection:
>   - "mode" is an optional property that could be "slave" or "master"
>   - if "mode" is not set the block is considered master by default
> 
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>

I'm okay with the DT portion (still needs Ack from DT people), but the
problem with the patch that you break bisectability, i.e. you introduce
pieces of code that are not present ATM. So, this should go *after*
actual slave patch.

> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,6 +20,9 @@ Optional properties :
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in
> nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH
> period.
>  
> + - mode : should be either:
> +           - "master" to setup the hardware block as a I2C master
> +           - "slave" to setup the hardware block as a I2C slave
>  Example :
>  
>  	i2c@f0000 {
> @@ -42,4 +45,5 @@ Example :
>  		i2c-sda-hold-time-ns = <300>;
>  		i2c-sda-falling-time-ns = <300>;
>  		i2c-scl-falling-time-ns = <300>;
> +		mode = "slave";

I would suggest to use "master" here, since most common use is master.

>  	};

So, the above can go to the patch
"... Add new property to describe mode"

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -469,6 +469,7 @@ config I2C_DESIGNWARE_CORE
>  
>  config I2C_DESIGNWARE_PLATFORM
>  	tristate "Synopsys DesignWare Platform"
> +	select I2C_SLAVE
> 

> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -55,6 +55,12 @@ static char *abort_sources[] = {
>  		"trying to use disabled adapter",
>  	[ARB_LOST] =
>  		"lost arbitration",
> +	[ABRT_SLAVE_FLUSH_TXFIFO] =
> +		"read command so flush old data in the TX FIFO",
> +	[ABRT_SLAVE_ARBLOST] =
> +		"slave lost the bus while transmitting data to a
> remote master",
> +	[ABRT_SLAVE_RD_INTX] =
> +		"slave request for data to be transmitted and",

These are part of slave patch.

> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -36,15 +36,20 @@
>  #define DW_IC_CON_SPEED_FAST		0x4
>  #define DW_IC_CON_SPEED_HIGH		0x6
>  #define DW_IC_CON_SPEED_MASK		0x6
> +#define DW_IC_CON_10BITADDR_SLAVE		0x8

All definitions would be split to a patch like
"... Introduce definitions for i2c slave mode"

> @@ -206,6 +225,7 @@ struct dw_i2c_dev {
>  	void __iomem		*base;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
> +	struct i2c_client		*slave;
> 

> @@ -225,6 +245,7 @@ struct dw_i2c_dev {
>  	struct i2c_adapter	adapter;
>  	u32			functionality;
>  	u32			master_cfg;
> +	u32			slave_cfg;
> 

> +extern int i2c_dw_init_slave(struct dw_i2c_dev *dev);
> +extern void i2c_dw_disable_slave(struct dw_i2c_dev *dev);
> +extern void i2c_dw_disable_int_slave(struct dw_i2c_dev *dev);
> +extern u32 i2c_dw_read_comp_param_slave(struct dw_i2c_dev *dev);
> +extern int i2c_dw_probe_slave(struct dw_i2c_dev *dev);

The above is a part of slave patch.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

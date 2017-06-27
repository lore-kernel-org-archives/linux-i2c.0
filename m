From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v12 1/2] i2c: designware: add SLAVE mode functions
Date: Tue, 27 Jun 2017 17:22:57 +0300
Message-ID: <6adde83e-8980-43cd-1cbf-07986b3d648a@linux.intel.com>
References: <cover.1498126241.git.lolivei@synopsys.com>
 <8da0ec338fd4b634b01ecded0117f7bd423c6aaf.1498126241.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8da0ec338fd4b634b01ecded0117f7bd423c6aaf.1498126241.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/22/2017 01:17 PM, Luis Oliveira wrote:
> - Changes in Kconfig to enable I2C_DESIGNWARE_SLAVE support
> - Slave functions added to core library file
> - Slave abort sources added to common source file
> - New driver: i2c-designware-slave added
> - Changes in the Makefile to compile the I2C_DESIGNWARE_SLAVE module
>   when supported by the architecture.
>
> All the SLAVE flow is added but it is not enabled via platform
> driver.
>
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> ---
> V11-v12
> - Changed ifdef condition in the Makefile fixed Kbuild error
>
>  drivers/i2c/busses/Kconfig                 |  14 +-
>  drivers/i2c/busses/Makefile                |   3 +
>  drivers/i2c/busses/i2c-designware-common.c |   6 +
>  drivers/i2c/busses/i2c-designware-core.h   |   2 +
>  drivers/i2c/busses/i2c-designware-slave.c  | 395 +++++++++++++++++++++++++++++
>  5 files changed, 419 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
>
...
> +static int i2c_dw_irq_handler_slave(struct dw_i2c_dev *dev)
> +{
> +	u32 raw_stat, stat, enabled;
> +	u8 val, slave_activity;
> +
> +	stat = dw_readl(dev, DW_IC_INTR_STAT);
> +	enabled = dw_readl(dev, DW_IC_ENABLE);
> +	raw_stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
> +	slave_activity = ((dw_readl(dev, DW_IC_STATUS) &
> +		DW_IC_STATUS_SLAVE_ACTIVITY) >> 6);
> +
> +	if (!enabled || !(raw_stat & ~DW_IC_INTR_ACTIVITY))
> +		return 0;
> +
> +	dev_dbg(dev->dev,
> +		"%#x STAUTS SLAVE_ACTTVITY=%#x : RAW_INTR_STAT=%#x"
> +		" : INTR_STAT=%#x\n",
> +		enabled, slave_activity, raw_stat, stat);
> +

Minor notes:
- Strings that are printed should fit in single line for making easier 
to grep them from sources. Maybe not all of those variables are not 
necessary in this debug print (e.g. are we interested other than bit 0 
in DW_IC_ENABLE and line above already returns if it reads zero).
- Typos "STAUTS SLAVE_ACTTVITY".

You may add my acked by if you want to send another version or I'm fine 
with incremental patch also.

Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

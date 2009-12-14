From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v2] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Mon, 14 Dec 2009 13:41:38 +0000
Message-ID: <20091214134137.GC1250@sirena.org.uk>
References: <1260653372-29299-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260653372-29299-1-git-send-email-darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 12, 2009 at 01:29:32PM -0800, Cory Maccarrone wrote:

> +static irqreturn_t htcpld_handler(int irq, void *dev)
> +{
> +	struct htcpld_data *htcpld = dev;

...

> +	/* To properly dispatch IRQ events, we need to read from the
> +	 * chip.  This is an I2C action that could possibly sleep
> +	 * (which is bad here, since we're in interrupt context).
> +	 * As such, the rest of this is implemented in a process-context
> +	 * workload that will take care of the actual dispatch.
> +	 */
> +	schedule_delayed_work(&(htcpld->interrupt_work), 0);

request_threaded_irq() probably does what you want here and is more
friendly to things like lockdep.  There's an example of handling this
sort of chip with the genirq infrastructure in the WM831x driver.

> +static int __devinit htcpld_core_probe(struct platform_device *pdev)
> +{
> +	struct htcpld_data *htcpld;
> +	struct device *dev = &pdev->dev;
> +	struct htcpld_core_platform_data *pdata;
> +	struct resource *res;
> +	int i, ret = 0;
> +	unsigned int irq, irq_end;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	pdata = (struct htcpld_core_platform_data *)dev->platform_data;

You don't need to cast awat from void.

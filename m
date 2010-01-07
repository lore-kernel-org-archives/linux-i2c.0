From: "Linus Walleij" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: RE: [PATCH 1/2] i2c: Add support for Ux500/Nomadik I2C controller
Date: Thu, 7 Jan 2010 21:37:04 +0100
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E30CDB5@eseldmw101.eemea.ericsson.se>
References: <27f8aa32bf40c690930a76ce5e1ee82cec86b248.1262870858.git.srinidhi.kasagar@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <27f8aa32bf40c690930a76ce5e1ee82cec86b248.1262870858.git.srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, sachin.verma-qxv4g6HH51o@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Srinidhi, great work!

Just a few quickies, if you fix these it's
Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> 

> diff --git a/arch/arm/plat-nomadik/include/plat/i2c.h 
> b/arch/arm/plat-nomadik/include/plat/i2c.h
> +enum i2c_freq_mode {
> +	I2C_FREQ_MODE_STANDARD,		/* up to 100 Kb/s */
> +	I2C_FREQ_MODE_FAST,		/* up to 400 Kb/s */
> +	I2C_FREQ_MODE_FAST_PLUS,	/* up to 1 Mb/s */
> +	I2C_FREQ_MODE_HIGH_SPEED	/* up to 3.4 Mb/s */
> +};
> +
> +enum i2c_addr_mode {
> +	I2C_7_BIT_ADDRESS = 0x1,
> +	I2C_10_BIT_ADDRESS = 0x2
> +};

Which field in the struct will use this? Can't
I2C_FUNC_10BIT_ADDR and I2C_M_TEN from include/linux/i2c.h (and
siblings) be used for this instead? Leftover?

You have this later:

(...)
+		if (unlikely(msgs[i].flags & I2C_M_TEN)) {
+			dev_err(&dev->pdev->dev, "10 bit addressing"
+					"not supported\n");
+			return -EINVAL;
(...)

Hmmmm?

> +
> +struct nmk_i2c_controller {

Please use kerneldoc for these comments.
(see Documentation/kernel-doc-nano-HOWTO.txt)

> +	unsigned long	clk_freq;
> +	unsigned short	slsu;	/* slave data set up time */

Comment which unit this is in. (Nanosecs I think?)

> +	unsigned char 	tft;	/* Tx FIFO Threshold */
> +	unsigned char 	rft;	/* Rx FIFO Threshold */

In bytes?

> +	unsigned short	sm;	/* speed mode */

Shouldn't this last element be 
enum i2c_freq_mode sm
then?

> +++ b/drivers/i2c/busses/i2c-nmk.c
(...)
> +	dev->irq = platform_get_irq(pdev, 0);
> +	ret = request_irq(dev->irq, i2c_irq_handler, IRQF_DISABLED,
> +				DRIVER_NAME, dev);

Since I2C IRQs can be a bit tedious, could this be converted
to a request_threaded_irq()? OK I know that is probably a bit
intrusive and can very well be done later (so no blocker) but
think about it.

Linus Walleij

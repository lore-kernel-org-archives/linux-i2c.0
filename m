From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: i2c-pnx driver issues
Date: Wed, 11 Nov 2009 21:21:52 +0000
Message-ID: <20091111212152.GK13398@fluff.org.uk>
References: <083DF309106F364B939360100EC290F804F5343706@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <083DF309106F364B939360100EC290F804F5343706-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Cc: "vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 11, 2009 at 01:21:45AM +0100, Kevin Wells wrote:
> Sorry - I've resent with a more meaningful subject (than 'welcome')!
> 
> Hi, 

gah, please word-wrap your lines to less than 77 characters per line,
it makes it awfully difficult to read them on mailers in terminals.
 
> We use the i2c-pnx.c driver on our device (NXP LPC3xxx devices), but have had some
> issues with compilation and general use. I hope these changes can be of use and can
> get back into the mainline. I'm happy to test any changes for the driver here on
> our boards.
> 
> The i2c-pnx.c file doesn't seem to compile (even with the pnx4008 platform selected).
> It looks like several important header files are not included in the driver
> (mach/i2c.h and asm/io.h). We have another board that uses this same IP, but with a
> slight reordering of the registers, so the i2c.h file in the mach area (which defines
> register offsets) is important where it is now.

asm/io.h should not be included directly, <linux/io.h> is the proper
include file.
 
> For systems with a tick rate of 100Hz, the I2C_PNX_TIMEOUT value of 10mS give only
> 1 jiffie before the transfer times out. We've noticed on some transfers that the
> jiffie may tick immediately after the expire count is set, causing the transfer in
> progress to timeout before 10mS is up. A small test to make sure jiffies was at
> least 2 fixed this.
> 
> We have multiple I2C busses on our system. The bus id value in the platform definition
> area (in the arm/mach- area) wasn't being correctly matched to the specific I2C
> bus. This would cause some devices to not match to the correct I2C bus.

That should be a ok to do as long as you are the primary i2c block
on the systtem.
 
> The 'buf' field in the I2C transfer descriptor was typed as a char. In the I2C
> driver, data values in the buffer pointer to by buf were being sign extended into
> the stop and start bit positions (8 and 9). For I2C transfers where a data byte had
> bit 7 set, both the start and stop bits were also getting set in the hardware.
> 
> The complete patch is listed below:

any chance of having this patch in a form that could be easily
merged? If you need more information on this, read the kernel
documentation on the subject in Documentation/SubmittingPatches on how
to format patches.

even better, split the changes into individual bugfixes.
 
> diff -Naur -X linux-2.6.32-rc6-ref/Documentation/dontdiff linux-2.6.32-rc6-ref/drivers/i2c/busses/i2c-pnx.c linux-2.6.32-rc6/drivers/i2c/busses/i2c-pnx.c
> --- linux-2.6.32-rc6-ref/drivers/i2c/busses/i2c-pnx.c	2009-11-03 11:37:49.000000000 -0800
> +++ linux-2.6.32-rc6/drivers/i2c/busses/i2c-pnx.c	2009-11-10 14:09:11.000000000 -0800
> @@ -20,8 +20,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c-pnx.h>
>  #include <mach/hardware.h>
> +#include <mach/i2c.h>
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> +#include <asm/io.h>
>  
>  #define I2C_PNX_TIMEOUT		10 /* msec */
>  #define I2C_PNX_SPEED_KHZ	100
> @@ -54,6 +56,9 @@
>  	struct timer_list *timer = &data->mif.timer;
>  	int expires = I2C_PNX_TIMEOUT / (1000 / HZ);
>  
> +	if (expires <= 1)
> +		expires = 2;
> +
>  	del_timer_sync(timer);
>  
>  	dev_dbg(&adap->dev, "Timer armed at %lu plus %u jiffies.\n",

adding -p to the diff options makes life easier to work out what
is being changed.

> @@ -633,7 +638,8 @@
>  
>  	/* Register this adapter with the I2C subsystem */
>  	i2c_pnx->adapter->dev.parent = &pdev->dev;
> -	ret = i2c_add_adapter(i2c_pnx->adapter);
> +	i2c_pnx->adapter->nr = pdev->id;
> +	ret = i2c_add_numbered_adapter(i2c_pnx->adapter);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "I2C: Failed to add bus\n");
>  		goto out_irq;
> diff -Naur -X linux-2.6.32-rc6-ref/Documentation/dontdiff linux-2.6.32-rc6-ref/include/linux/i2c-pnx.h linux-2.6.32-rc6/include/linux/i2c-pnx.h
> --- linux-2.6.32-rc6-ref/include/linux/i2c-pnx.h	2009-11-03 11:37:49.000000000 -0800
> +++ linux-2.6.32-rc6/include/linux/i2c-pnx.h	2009-11-10 14:16:55.000000000 -0800
> @@ -21,7 +21,7 @@
>  	int			mode;		/* Interface mode */
>  	struct completion	complete;	/* I/O completion */
>  	struct timer_list	timer;		/* Timeout */
> -	char *			buf;		/* Data buffer */
> +	u8 *			buf;		/* Data buffer */
>  	int			len;		/* Length of data buffer */
>  };
> 
> thanks,
> Kevin Wells
> NXP Semiconductors

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

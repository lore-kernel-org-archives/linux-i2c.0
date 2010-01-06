From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v1] i2c: Davinci i2c bus recovery procedure to come out
 of time out conditions
Date: Wed, 06 Jan 2010 17:00:26 +0530
Message-ID: <1262777426.3581.15.camel@localhost.localdomain>
References: <1258989756.20007.227.camel@localhost.localdomain>
	 <87r5q4nkex.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r5q4nkex.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Kevin,

On Tue, 2010-01-05 at 16:31 -0800, Kevin Hilman wrote:
> Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org> writes:
> 
> >>From 062cfba8b86ccd932eaa498980e703295d86a6cb Mon Sep 17 00:00:00 2001
> > From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> > Date: Mon, 23 Nov 2009 18:08:33 +0530
> > Subject: [PATCH] Davinci i2c bus recovery procedure to come out of time out conditions
> >
> > Get out of i2c time out condition by following the
> > bus recovery procedure outlined in the i2c protocol v3 spec.
> > The kernel must be robust enough to gracefully recover
> > from i2c bus failure without having to reset the machine.
> > This is done by first NACKing the slave, pulsing the SCL
> > line 9 times and then sending the stop command.
> >
> > This patch has been tested on a DM6446 and DM355
> 
> How are you testing this?  this should also be tested on da8xx by someone.

This patch is redundant but patch v2 did not make it to the list because
of reverse-dns issues. Resending it now. But then again I guess there
will be a v3 because of removal of macro MOD_REG_BIT.

Thank you for your comments.

Regards,
Philby


> 
> > Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> >
> > ---
> >  drivers/i2c/busses/i2c-davinci.c |   54 +++++++++++++++++++++++++++++++++----
> >  1 files changed, 48 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> > index 67d88cc..6b4a550 100644
> > --- a/drivers/i2c/busses/i2c-davinci.c
> > +++ b/drivers/i2c/busses/i2c-davinci.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> > +#include <linux/gpio.h>
> >  
> >  #include <mach/hardware.h>
> >  
> > @@ -43,6 +44,7 @@
> >  /* ----- global defines ----------------------------------------------- */
> >  
> >  #define DAVINCI_I2C_TIMEOUT	(1*HZ)
> > +#define DAVINCI_I2C_MAX_TRIES	2
> >  #define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
> >  				 DAVINCI_I2C_IMR_SCD | \
> >  				 DAVINCI_I2C_IMR_ARDY | \
> > @@ -134,6 +136,38 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
> >  	return __raw_readw(i2c_dev->base + reg);
> >  }
> >  
> > +/* Generate a pulse on the i2c clock pin. */
> > +static void pulse_i2c_clock(void)
> > +{
> > +	gpio_set_value(14, 0);
> > +	udelay(20);
> > +	gpio_set_value(14, 1);
> > +	udelay(20);
> > +}
> > +
> > +/* This routine does i2c bus recovery as specified in the
> > + * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
> > + */
> > +static void i2c_recover_bus(struct davinci_i2c_dev *dev)
> > +{
> > +	u16 i;
> > +	u32 flag = 0;
> > +
> > +	dev_err(dev->dev, "initiating i2c bus recovery\n");
> 
> This looks like a debug leftover.  I doubt you want this since
> you're calling this function on every xfer.
> 
> > +	/* Send NACK to the slave */
> > +	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> > +	flag |=  DAVINCI_I2C_MDR_NACK;
> > +	/* write the data into mode register */
> > +	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> > +	/* Send high and low on the SCL line */
> > +	for (i = 0; i < 9; i++)
> > +		pulse_i2c_clock();
> > +	/* Send STOP */
> > +	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> > +	MOD_REG_BIT(flag, DAVINCI_I2C_MDR_STP, 1);
> 
> This patch will need some updates as this macro is now gone.
> 
> Kevin
> 
> > +	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> > +}
> > +
> >  /*
> >   * This functions configures I2C and brings I2C out of reset.
> >   * This function is called during I2C init function. This function
> > @@ -221,19 +255,26 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
> >  					 char allow_sleep)
> >  {
> >  	unsigned long timeout;
> > +	static u16 to_cnt = 0;
> >  
> >  	timeout = jiffies + dev->adapter.timeout;
> >  	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
> > -	       & DAVINCI_I2C_STR_BB) {
> > -		if (time_after(jiffies, timeout)) {
> > -			dev_warn(dev->dev,
> > -				 "timeout waiting for bus ready\n");
> > -			return -ETIMEDOUT;
> > +			& DAVINCI_I2C_STR_BB) {
> > +		if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
> > +			if (time_after(jiffies, timeout)) {
> > +				dev_warn(dev->dev,
> > +					"timeout waiting for bus ready\n");
> > +				to_cnt++;
> > +				return -ETIMEDOUT;
> > +			} else {
> > +				to_cnt = 0;
> > +				i2c_recover_bus(dev);
> > +				i2c_davinci_init(dev);
> > +			}
> >  		}
> >  		if (allow_sleep)
> >  			schedule_timeout(1);
> >  	}
> > -
> >  	return 0;
> >  }
> >  
> > @@ -310,6 +351,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
> >  						      dev->adapter.timeout);
> >  	if (r == 0) {
> >  		dev_err(dev->dev, "controller timed out\n");
> > +		i2c_recover_bus(dev);
> >  		i2c_davinci_init(dev);
> >  		dev->buf_len = 0;
> >  		return -ETIMEDOUT;
> > -- 
> > 1.6.3.3.MVISTA
> >
> >
> >
> >
> > _______________________________________________
> > Davinci-linux-open-source mailing list
> > Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> > http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source

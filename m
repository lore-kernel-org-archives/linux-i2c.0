From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Mon, 23 Nov 2009 20:53:06 +0530
Message-ID: <1258989786.20007.232.camel@localhost.localdomain>
References: <1247643267.5981.82.camel@localhost.localdomain>
	 <4A5DCCBD.909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5DCCBD.909-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Sergei,

On Wed, 2009-07-15 at 16:34 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Philby John wrote:
> 
> >>From dbe7e824d576636bb15b82a20fd2557fddc9a8f7 Mon Sep 17 00:00:00 2001
> > From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> > Date: Tue, 14 Jul 2009 21:46:47 +0530
> > Subject: [PATCH] Reset i2c bus to come out of time out conditions
> 
> > Get out of i2c time out condition by resetting
> > the i2c bus. The kernel must be robust enough to
> > gracefully recover from i2c bus failure without having
> > to reset the machine. This is done by first NACKing the slave
> > and then resetting the i2c bus after a certain timeout.
> 
> > Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> 
> > diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> > index 17f2ee7..4ed1a4c 100755
> > --- a/drivers/i2c/busses/i2c-davinci.c
> > +++ b/drivers/i2c/busses/i2c-davinci.c
> > @@ -35,14 +35,18 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> > +#include <linux/gpio.h>
> >  
> >  #include <mach/hardware.h>
> >  
> >  #include <mach/i2c.h>
> > +#include <mach/mux.h>
> > +#include <mach/cputype.h>
> >  
> >  /* ----- global defines ----------------------------------------------- */
> >  
> >  #define DAVINCI_I2C_TIMEOUT	(1*HZ)
> > +#define DAVINCI_I2C_MAX_TRIES	2
> >  #define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
> >  				 DAVINCI_I2C_IMR_SCD | \
> >  				 DAVINCI_I2C_IMR_ARDY | \
> > @@ -135,6 +139,50 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
> >  }
> >  
> >  /*
> > + * Configure the i2c data pin as a GPIO input and the i2c clock pin as a
> > + * high GPIO output.
> > + */
> > +static void disable_i2c_pins(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	if (cpu_is_davinci_dm355()) {
> > +		gpio_direction_input(15);
> > +		gpio_direction_output(14, 0);
> > +		gpio_set_value(14, 1);
> 
>     Why not just:
> 
> 		gpio_direction_output(14, 1);
> 
> > +		davinci_cfg_reg(DM355_I2C_SDA);
> > +		davinci_cfg_reg(DM355_I2C_SCL);
> 
>     Why enable the pins here?

Corrected.

> 
> > +	}
> > +	local_irq_restore(flags);
> > +}
> > +
> > +/* Connect the i2c pins to the i2c controller. */
> > +static void enable_i2c_pins(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	if (cpu_is_davinci_dm355()) {
> > +		davinci_cfg_reg(DM355_I2C_SDA);
> > +		davinci_cfg_reg(DM355_I2C_SCL);
> > +	}
> > +	local_irq_restore(flags);
> > +}
> > +
> > +
> > +/* Generate a pulse on the i2c clock pin. */
> > +static void pulse_i2c_clock(void)
> > +{
> > +	if (cpu_is_davinci_dm355()) {
> > +		gpio_set_value(14, 0);
> > +		udelay(20);
> > +		gpio_set_value(14, 1);
> > +		udelay(20);
> > +	}
> > +}
> > +
> > +/*
> >   * This functions configures I2C and brings I2C out of reset.
> >   * This function is called during I2C init function. This function
> >   * also gets called if I2C encounters any errors.
> > @@ -221,14 +269,36 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
> >  					 char allow_sleep)
> >  {
> >  	unsigned long timeout;
> > +	u16 i;
> > +	static u16 to_cnt = 0;
> > +	u32 flag = 0;
> >  
> >  	timeout = jiffies + dev->adapter.timeout;
> >  	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
> > -	       & DAVINCI_I2C_STR_BB) {
> > -		if (time_after(jiffies, timeout)) {
> > -			dev_warn(dev->dev,
> > -				 "timeout waiting for bus ready\n");
> > -			return -ETIMEDOUT;
> > +			& DAVINCI_I2C_STR_BB) {
> > +
> > +		if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
> > +			if (time_after(jiffies, timeout)) {
> > +				dev_warn(dev->dev,
> > +					"timeout waiting for bus ready\n");
> > +				to_cnt++;
> > +				return -ETIMEDOUT;
> > +			}
> > +		} else if (cpu_is_davinci_dm644x() || cpu_is_davinci_dm355()) {
> > +			to_cnt = 0;
> > +			dev_err(dev->dev, "initiating i2c bus recovery\n");
> > +			/* Send the NACK to the slave */
> > +			flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> > +			flag |=  DAVINCI_I2C_MDR_NACK;
> 
>     Superflous space here...

Corrected!!

> 
> > +			/* write the data into mode register */
> > +			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> 
>     How come you're reading from the interrupt mask register but writing 
> into the mode register which has different layout? :-O
> 
> > +			/* Disable i2c */
> > +			disable_i2c_pins();
> > +			for (i = 0; i < 10; i++)
> > +				pulse_i2c_clock();
> > +			/* Re-enable i2c */
> > +			enable_i2c_pins();
> > +			i2c_davinci_init(dev);
> >  		}
> >  		if (allow_sleep)
> >  			schedule_timeout(1);
> > @@ -309,7 +379,23 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
> >  	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
> >  						      dev->adapter.timeout);
> >  	if (r == 0) {
> > -		dev_err(dev->dev, "controller timed out\n");
> > +		u16 i;
> > +		u32 flag = 0;
> > +		if (cpu_is_davinci_dm644x() || cpu_is_davinci_dm355()) {
> > +			dev_err(dev->dev, "initiating i2c bus recovery\n");
> > +			/* Send the NACK to the slave */
> > +			flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
> > +			flag |=  DAVINCI_I2C_MDR_NACK;
> 
>     ... and here.

Corrected!

> 
> > +			/* write the data into mode register */
> > +			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> > +			/* Disable i2c */
> > +			disable_i2c_pins();
> > +			/* Send high and low on the SCL line */
> > +			for (i = 0; i < 10; i++)
> > +				pulse_i2c_clock();
> > +			/* Re-enable i2c */
> > +			enable_i2c_pins();
> 
>     Please factor out the completely identical recovery procedures into the

Understood what you meant to say, now corrected.

Thank you for your valuable comments.
Regards,
Philby

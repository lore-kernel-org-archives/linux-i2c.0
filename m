From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Mon, 23 Nov 2009 20:54:50 +0530
Message-ID: <1258989890.20007.238.camel@localhost.localdomain>
References: <1247643267.5981.82.camel@localhost.localdomain>
	 <4A5E0E98.2030108@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5E0E98.2030108-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Troy,

On Wed, 2009-07-15 at 10:15 -0700, Troy Kisky wrote:
> Philby John wrote:
> >>From dbe7e824d576636bb15b82a20fd2557fddc9a8f7 Mon Sep 17 00:00:00 2001
> > From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> > Date: Tue, 14 Jul 2009 21:46:47 +0530
> > Subject: [PATCH] Reset i2c bus to come out of time out conditions
> > 
> > Get out of i2c time out condition by resetting
> > the i2c bus. The kernel must be robust enough to
> > gracefully recover from i2c bus failure without having
> > to reset the machine. This is done by first NACKing the slave
> > and then resetting the i2c bus after a certain timeout.
> > 
> > Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> > ---
> 
> I personally like the idea behind this patch. But I have
> heard others argue against it. But it is not related to the
> ^C issue others have mentioned. That should not happen in
> the GIT kernel.
> 
> >  drivers/i2c/busses/i2c-davinci.c |   98 +++++++++++++++++++++++++++++++++++--
> >  1 files changed, 92 insertions(+), 6 deletions(-)
> > 
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
> > +		davinci_cfg_reg(DM355_I2C_SDA);
> > +		davinci_cfg_reg(DM355_I2C_SCL);
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
> 
> I would not initiate recovery until a timeout occurs.
> This can be a multi master bus, so a busy condition
> may be valid. Then, after multiple timeouts and recovery attempts,
> return -ETIMEDOUT

Yes, I agree. I wait for a maximum of 2 tries when a timeout occurs
before initiating bus recovery.


Regards,
Philby

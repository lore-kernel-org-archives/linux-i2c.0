From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c,algo: cleanup i2c-algo-pcf.c
Date: Thu, 5 Feb 2009 21:38:58 +0100
Message-ID: <20090205213858.4948305e@hyperion.delvare>
References: <4984688B.2090805@gmail.com>
	<20090201114121.6448a3c9@hyperion.delvare>
	<498760F7.6020005@gmail.com>
	<20090202225309.359e77d6@hyperion.delvare>
	<49883938.9010104@gmail.com>
	<20090204093402.08ddb2e8@hyperion.delvare>
	<25e057c00902040754k22e05c91i72f70f00619d547d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <25e057c00902040754k22e05c91i72f70f00619d547d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: roel kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Brower <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dan Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Roel,

Adding back the linux-i2c list in the loop...

On Wed, 4 Feb 2009 16:54:20 +0100, roel kluin wrote:
> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>:
> > Depends on the hardware implementation. If I2C_PCF_LAB can be set while
> > I2C_PCF_PIN is set then indeed this is wrong. But I suspect the
> > hardware is such that I2C_PCF_LAB can't be set without I2C_PCF_PIN
> > being clear. You'd have to check the PCF8584 datasheet to make sure.
> 
> I took a look at the datasheet, and I think this is not so:
> 
> From Fig 1: PIN and LAB are control status registers (s1)
> 
> From section 6.8.1.1, PIN (Pending Interrupt Not):
> "When the PIN bit is written with a logic 1, all status bits are reset
> to logic 0.
> [...] PIN is the only bit in S1 which may be both read and written to."
> 
> Later in 6.8.2.1: PIN bit:
> Each time a serial data transmission is initiated [...], the PIN bit
> will be set to
> logic 1 automatically (inactive).
> [...]
> After transmission or reception of one byte on the I2C-bus, the PIN bit will be
> automatically reset to logic 0 (active) indicating a complete byte
> transmission/reception.
> 
> and in 6.8.2.6 LAB:
> 'Lost Arbitration' Bit. This bit is set when, in multi-master operation,
> arbitration is lost to another master on the I2C-bus.
> 
> Note: setting I2C_PCF_PIN clears bits, including I2C_PCF_LAB, but
> unsetting does not.
> 
> now consider the function
> 
> static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)
> {
> 
>         int timeout = DEF_TIMEOUT;
> 
>         *status = get_pcf(adap, 1);
> 
>         while (timeout-- && (*status & I2C_PCF_PIN)) {
>                 adap->waitforpin(adap->data);
>                 *status = get_pcf(adap, 1);
>         }
>         if (*status & I2C_PCF_LAB) {
>                 handle_lab(adap, status);
>                 return -EINTR;
>         }
> 
>         if (timeout <= 0)
>                 return -1;
>         else
>                 return 0;
> }
> 
> We wait until I2C_PCF_PIN is set (transmission/reception was succesful),
> but we want to ensure that arbitration is not lost to another master on
> the I2C-bus.
> 
> > I you don't have a PCF8584-based adapter to test, and aren't going to
> > read the datasheet to see how the device is supposed to behave, and
> > have no proof that the current code is buggy, than please don't touch
> > it.
> 
> I do not have a PCF8584-based adapter, but according to the datasheet
> it does seem wrong. I do think the timeout-based return should go first.

I fail to see how you come to this conclusion based on the datasheet
elements you listed above. Anyway, I suspect that lost arbitration and
timeout can't happen at the same time so it doesn't really matter what
test is done first.

If you really want to change the code, please discuss it with Eric
Brower and Dan Smolik (Cc'd). They worked on arbitration loss in
i2c-algo-pcf back in July 2008, so presumably they have systems where
they can test this specific condition.

-- 
Jean Delvare

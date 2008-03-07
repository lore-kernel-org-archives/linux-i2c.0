From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the new
	pca-algorithm
Date: Fri, 07 Mar 2008 16:52:05 +0100
Message-ID: <fqrob6$3e6$1@ger.gmane.org>
References: <20080206202056.364404622@pengutronix.de>	<20080206203037.228001815@pengutronix.de>
	<20080212225306.4cf2bd74@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080212225306.4cf2bd74-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

nearly a month since your reply, I am sorry. Work was shifting in a 
different direction meanwhile.

(Everything I did not comment on is already fixed as suggested)

>> +/* Read/Write functions for different register alignments */
>> +
>> +static int i2c_pca_pf_readbyte8(void *pd, int reg)
>> +{
>> +	struct i2c_pca_pf_data *i2c = pd;
>> +	return ioread8(i2c->reg_base + reg);
>> +}
>> +
>> +static int i2c_pca_pf_readbyte16(void *pd, int reg)
>> +{
>> +	struct i2c_pca_pf_data *i2c = pd;
>> +	return ioread8(i2c->reg_base + reg * 2);
> 
> Shouldn't this be ioread16?
I don't think so. The registers get scattered differently in the 
address-room, but their size itself is still 8 bit. I expect that 
ioread8 gives me just those 8 bits I want, hiding that some busses 
actually do 32-bit accesses only. Am I wrong?

>> +	if (i2c->irq) {
>> +		ret = wait_event_interruptible(i2c->wait,
>> +			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
>> +			& I2C_PCA_CON_SI);
>> +	} else {
>> +		while ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
>> +				& I2C_PCA_CON_SI) == 0)
>> +			udelay(100);
> 
> No timeout?
You got a point there. The thing is that the underlying pca-algorithm 
does not have a timeout when expecting this condition (interrupt bit 
set). Even when using interrupts instead of polling, it will just sleep 
forever, if there goes something _really_ wrong. I could copy at least 
this behaviour by replacing the udelay(100); with an msleep(x) with x 
being a module parameter. I hope this is good enough, connecting the IRQ 
is preferred anyhow. (I am afraid that I don't have the time to add a 
sane and tested timeout mechanism to the algorithm)

> The i2c_clock gets to be copied to the driver data structure, but for
> the gpio you have to fetch it from the platform device data? Not very
> consistent.
ACK.

>> +	i2c->adap.owner   = THIS_MODULE;
> No alignment in code please.
Really? Well, if you say so...

> That's a bit confusing given that the driver isn't named i2c-pca9564.
> Other drivers usually include the address to distinguish between
> multiple device for example (..., "PCA9564 adapter at %04lx",
> res->start).
Okay, will look for something better.

>> +struct i2c_pca9564_pf_platform_data {
> "pf" is redundant with "platform", isn't it?
My intention was that 'i2c_pca9564_pf_' is the prefix for everything 
related to this platform-driver, and platform_data happens to be 
...well... the platform data :)

>> +	int timeout;		/* timeout = this value * 10us */
> A rather curious time unit if you ask me.
Given by the algorithm. I didn't question it.

Best wishes,

    Wolfram

-- 
   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

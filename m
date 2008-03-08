From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the new
 pca-algorithm
Date: Sat, 8 Mar 2008 11:13:37 +0100
Message-ID: <20080308111337.440a7c83@hyperion.delvare>
References: <20080206202056.364404622@pengutronix.de>
	<20080206203037.228001815@pengutronix.de>
	<20080212225306.4cf2bd74@hyperion.delvare>
	<fqrob6$3e6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <fqrob6$3e6$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfgang,

On Fri, 07 Mar 2008 16:52:05 +0100, Wolfram Sang wrote:
> nearly a month since your reply, I am sorry. Work was shifting in a 
> different direction meanwhile.

No problem, I have been pretty busy myself.

> (Everything I did not comment on is already fixed as suggested)
> 
> >> +/* Read/Write functions for different register alignments */
> >> +
> >> +static int i2c_pca_pf_readbyte8(void *pd, int reg)
> >> +{
> >> +	struct i2c_pca_pf_data *i2c = pd;
> >> +	return ioread8(i2c->reg_base + reg);
> >> +}
> >> +
> >> +static int i2c_pca_pf_readbyte16(void *pd, int reg)
> >> +{
> >> +	struct i2c_pca_pf_data *i2c = pd;
> >> +	return ioread8(i2c->reg_base + reg * 2);
> > 
> > Shouldn't this be ioread16?
> I don't think so. The registers get scattered differently in the 
> address-room, but their size itself is still 8 bit. I expect that 
> ioread8 gives me just those 8 bits I want, hiding that some busses 
> actually do 32-bit accesses only. Am I wrong?

I really don't know, I am not familiar with the hardware. Leave it as
is, we'll fix it later if someone complains.

> >> +	if (i2c->irq) {
> >> +		ret = wait_event_interruptible(i2c->wait,
> >> +			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> >> +			& I2C_PCA_CON_SI);
> >> +	} else {
> >> +		while ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> >> +				& I2C_PCA_CON_SI) == 0)
> >> +			udelay(100);
> > 
> > No timeout?
> You got a point there. The thing is that the underlying pca-algorithm 
> does not have a timeout when expecting this condition (interrupt bit 
> set). Even when using interrupts instead of polling, it will just sleep 
> forever, if there goes something _really_ wrong. I could copy at least 
> this behaviour by replacing the udelay(100); with an msleep(x) with x 
> being a module parameter. I hope this is good enough, connecting the IRQ 
> is preferred anyhow. (I am afraid that I don't have the time to add a 
> sane and tested timeout mechanism to the algorithm)

I'd rather not make the driver more complex for a mode you do not want
to encourage anyway. Leave the code as is, once again we can improve it
later if really needed.

Waiting for an updated patch, then I'll push it to -mm. Patches 1/3 and
2/3 are already there.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 7/8] VR1000: Add i2c device list to Thorcom VR1000
Date: Mon, 2 Jun 2008 08:35:55 +0200
Message-ID: <20080602083555.7fe56175@hyperion.delvare>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132407.211335410@fluff.org.uk>
	<20080601093215.67a1ac41@hyperion.delvare>
	<20080601213855.GI7334@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080601213855.GI7334-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 1 Jun 2008 22:38:55 +0100, Ben Dooks wrote:
> On Sun, Jun 01, 2008 at 09:32:15AM +0200, Jean Delvare wrote:
> > On Thu, 29 May 2008 14:22:51 +0100, Ben Dooks wrote:
> > > +/* I2C devices. */
> > > +
> > > +static struct i2c_board_info vr1000_i2c_info[] __initdata = {
> > > +	{
> > > +		.type	= "tlv320aic23",
> > > +		.addr	= 0x1a,
> > > +	}, {
> > > +		.type	= "tmp101",
> > > +		.addr	= 0x48,
> > 
> > Same problem as "eeprom"... The lm75 driver doesn't yet support the
> > "tmp101" as a new-style device in mainline, so this won't work and will
> > prevent the lm75 driver from attaching as a legacy driver too. So this
> > device declaration should be delayed or commented out until the lm75
> > driver is ready.
> 
> I'll think about that one, although it does take a force to load the lm75
> on current kernels due to it not being 'truly' lm75 compatible.

That's still better than not being able to load the driver at all,
which will happen with your device declaration above without the
updated lm75 driver.

> Is there
> any chance of the new driver being merged during the next change window?

Depends on Mark M. Hoffman (Cc'd), not me. I've reviewed and acked the
lm75 patches, but it's up to Mark to merge them.

> PS, I've done a quick test of the new lm75 driver and it seems to work
> fine for me and would like to see a solution where we don't need to force
> probe the lm75 module.

Of course, the updated driver is the way to go in your case.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

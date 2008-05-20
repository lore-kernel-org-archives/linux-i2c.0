From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with unstable i2c communication with i810 bus
 driver
Date: Tue, 20 May 2008 09:18:07 +0200
Message-ID: <20080520091807.071f1032@hyperion.delvare>
References: <48321FD9.2010007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48321FD9.2010007-Mmb7MZpHnFY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wilken Haase <Hibbelharry-Mmb7MZpHnFY@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wilken,

On Tue, 20 May 2008 02:48:25 +0200, Wilken Haase wrote:
> Hi People,
> i own a Samsung TV settopbox which is nice to use with linux, even while
> its manufacturer samsung ships it with another operating system. The box
> consists of a intel i815 chipset with integrated graphics, connected to
> a focus enhancements fs454 scan converter which is controlled by i2c
> commands and which must be setup correctly to produce a useable picture.
> 
> In the current state it kinda works. If i do a dump of the registers of
> the fs454 I always get some bogus values back, even while most registers
> are read out correctly. There is no visible pattern in what registers
> give back wrong values, it differs from dump to dump. As another fact
> writing to the chip is unstable, too. I often need to rewrite the values
> 2 or 3 times to get them in place.
> 
> I did test some different kernel versions up to the current 2.6.25 and i
> saw a nice little increase in reliability but still its a piece off from
> perfect.
> 
> Failures in writing are producing the following messages in syslog:
> 
> May 20 02:33:13 smt i2c-adapter i2c-1: sendbytes: NAK bailout.
> 
> Identified busses derived from the output of i2cdump are:
> 
> i2c-0    i2c           I810-DDC
> i2c-1    i2c           I810-I2C
> i2c-2    i2c           I810-GPIOC
> i2c-3    smbus         SMBus I801 adapter at 1810
> i2c-4    i2c           cx88[0]
> 
> The fs454 scan converter is located on I810-I2C.
> 
> I tried some different values for delays in i2c-i810.c like here:
> 
> /* delays */
> #define CYCLE_DELAY             100
> #define TIMEOUT                 100
> 
> But this didn't seem to offer advantages.

I think that you are not modifying the right file. Apparently you
modified the delay values in drivers/i2c/busses/i2c-i810.c? While bus
I810-I2C is created by driver i810fb. So if you want to change the
timings, you should edit chan->algo.udelay and chan->algo.timeout in
drivers/video/i810/i810-i2c.c.

Note that the i2c-i810 driver is deprecated and will be removed in
kernel 2.6.27, this should help clear the confusion.

> What else can i do ?
> Any suggestions ?
> If more information is needed feel free to drop me a mail, i will offer
> any information as needed.

Are there other I2C devices connected to the i810? It would be
interesting to know whether the problem happens only with the FS454 or
also with other devices. If all I2C devices are affected then the
problem is probably hardware noise, maybe you have a defective part,
and there's not much we can do. If only the FS454 is affected, maybe
this specific device is not able of clock stretching and does support
only very slow I2C transactions (in which case increasing
chan->algo.udelay should help). But the current speed isn't very high
(50 kHz) so I'd be surprised.

Or maybe the FS454 simply needs a delay between reads and writes, I've
seen other I2C devices like this before. It is common for the device to
simply nack the transactions (as you see in your logs) while it is
busy. In this case the fix is to add delays in the fs454 driver (or
user-space tool accessing the device over i2c-dev) between transactions.

If you have access to the FS454 datasheet, it should tell whether the
device can stretch the clock and whether it needs a delay between the
transactions.

As an additional note, I seem to remember that i2c-algo-bit (which
I810-I2C uses) doesn't properly support bus arbitration. So, if you
have a multi-master bus, that could explain your problems, too. You'd
need to know the exact I2C bus topology of your system to rule out this
possibility.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

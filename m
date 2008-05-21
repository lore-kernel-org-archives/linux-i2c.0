From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with unstable i2c communication with i810 bus
 driver
Date: Wed, 21 May 2008 09:14:40 +0200
Message-ID: <20080521091440.2252167d@hyperion.delvare>
References: <48321FD9.2010007@gmx.de>
	<20080520091807.071f1032@hyperion.delvare>
	<4832C0C8.2090401@gmx.de>
	<20080520203715.68c502f3@hyperion.delvare>
	<483352EA.2090005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <483352EA.2090005-Mmb7MZpHnFY@public.gmane.org>
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
Cc: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 21 May 2008 00:38:34 +0200, Wilken Haase wrote:
> I am able to probe the bus. The only discovered device on the bus is the
> fs454 at 0x6a and the master at 0x00.

0x00 is actually the broadcast address. I've never seed used so far,
but apparently the FS454 supports broadcast messages.

BTW, you must be using an old version of i2cdetect. Newer versions
don't probe address 0 by default.

What about the DDC channel? If there is a screen connected with an EDID
EEPROM you should see it on the DDC channel, and then you could test if
it has transaction errors as well.

> "The FS453 registers are accessed through a serial input/output bus (SIO)
> which is I2C*-compatible and SMBus-compatible. These registers can be
> read or written at any time the part is receiving a reference clock at
> XTAL_IN and not being held in reset via the RESET_L pin."

OK, this doesn't sound like any delay is required between accesses then.

> Isn't this true i2c here ?

As the FS454 is advertised as compatible with I2C, yes.

> A hardware defect is not the problem here. There is a growing community
> on these settopboxes in Germany
> and I do talk to many of the owners actively. All the Samsung SMT-7020S
> share the same problem when used with Linux. This is no single defect. 

OK.

> On a sidenote: I never saw the Original WindowsCE Operating System or
> the Intel IEGD Driver fail on setting up the fs454 once, but those both
> are dead end solutions. The IEGD Drivers for older chipsets don't work
> with newer software like Linux Kernel >2.6.15, the original Operating
> System is really plagued by obscure Bugs and missing functionality...

Maybe the i810fb driver is missing an initialization which your system
needs. You might want to discuss your problem with the i810fb driver
maintainer (Antonino Daplas).

You could try the old i2c-i810 driver temporarily and see if it does a
better job, but I wouldn't hold my breath. Both drivers use the same
helper driver (i2c-algo-bit) for the actual work. 

I don't have any more ideas, sorry.

-- 
Jean Delvare


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [PATCH 5/6]: i2c: Add bus addressing support.
Date: Wed, 15 Oct 2008 14:37:22 -0700 (PDT)
Message-ID: <20081015.143722.260594637.davem@davemloft.net>
References: <20080821.024330.51639001.davem@davemloft.net>
	<20081015145228.14b1ae77@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015145228.14b1ae77-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date: Wed, 15 Oct 2008 14:52:28 +0200

> Hi David,
> 
> On Thu, 21 Aug 2008 02:43:30 -0700 (PDT), David Miller wrote:
> > 
> > i2c: Add bus addressing support.
> > 
> > Some I2C bus controllers support the driving of multiple I2C bus
> > segments (think PCI domains).
> > 
> > For example, the pcf8584 variants on some sparc64 boxes can do this.
> > They have an auxiliary 8-bit register that specifies the I2C bus each
> > I2C operation acts upon.  In the openfirmware device tree, the I2C
> > client devices are described using an 8-bit bus address and a 10-bit
> > I2C device address.
> 
> Can you please point me to the part of the PCF8454 datasheet which
> explains this? I can't find it. As I read the datasheet, the PCF8454
> supports a single I2C bus.

It's a feature Sun added to their PCF chips.  The register address
is forwarded to an internal MUX they implemented which implements
the register selecting the I2C bus.

> Oh my, holy crap! I can't believe you dared to propose this.

Propose an alternative solution that actually works and preserves
compatability, as mine does.

> I don't like this at all. This really looks like a custom hack to solve
> the problem at hand without paying too much attention to compatibility
> issues which I am certain will arise. Just to mention the first one
> that comes to mind: access from user-space through i2c-dev, and
> specifically i2c-tools.

I got that working, read the patch my patch works, I was careful
to keep things working.

> What makes your setup fundamentally different from a motherboard with
> more than one I2C bus (which is a rather common case)? Why don't you
> simply register one i2c_adapter for each i2c bus segment?

It doesn't work like that.  All the bit banging goes through the
one I2C controller, the bus it is accessing is simply changed behind
it's back by that special register.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Strange data corruption when read from /sys/class/i2c-adapter/.../eeprom
Date: Thu, 4 Dec 2008 12:22:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812041211020.5079@axis700.grange>
References: <Pine.LNX.4.64.0812031327440.4717@axis700.grange>
 <20081204094800.3f80d7f6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081204094800.3f80d7f6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 4 Dec 2008, Jean Delvare wrote:

> Hi Guennadi,
> 
> On Wed, 3 Dec 2008 13:37:13 +0100 (CET), Guennadi Liakhovetski wrote:
> > on an i.MX31-based system I observe a strange effect:
> > 
> > cat /sys/class/i2c-adapter/.../eeprom > /tmp/e1
> > rmmod <adapter-driver>
> > modprobe <adapter-driver>
> > cat /sys/class/i2c-adapter/.../eeprom > /tmp/e2
> > 
> > after which the first 0x40 bytes in e2 are zero. The rest is correct - as 
> > in e1. To recover I have to
> > 
> > rmmod eeprom
> > i2cdetect ... # incluging eeprom addresses
> > modprobe eeprom
> 
> How repeatable is this? I do not observe this behavior with i2c-I801 +
> eeprom here.

100% - but with slightly different corruptions. In principle, it always 
just skips some bytes. F.e., if it starts from the beginning, it always 
loses the first byte. Then it gets 32 bytes right, then 560 bytes (16 * 
35) skipped, then some more bytes, but after the first lost byte - always 
in multiples of 16 bytes. And this pattern - 1 lost, 32 read, 560 lost is 
repeatable. Then it can vary.

> Anything in the kernel logs?

Nothing.

> To recover, isn't it enough to wait for 5 minutes (giving the eeprom
> driver's cache the time to expire)? If so, I would suspect an
> initialization error in your adapter driver (maybe it takes some time
> to the hardware to fully initialize, or there's an initialization step
> missing in the driver.)

Waiting for several minutes does change the read out data. But it is never 
perfect.

> Note that the eeprom driver can use both I2C block read transactions
> and SMBus word read transactions. The former is used if available
> because it is faster. You may force the eeprom driver to switch to
> SMBus word reads by removing I2C_FUNC_SMBUS_READ_I2C_BLOCK from the bus
> driver's functionality bitfield. It might help you pinpoint the exact
> problem.

Could try that...

> Maybe an even easier way would be to use i2c-dev + i2cdump instead of
> the eeprom driver. With i2cdump you will have full control on the
> transaction type that is used to read the EEPROM data.

Now this is interesting:

i2cdump 1 0x52 c

reads perfectly. Whereas

i2cdump 1 0x52 b

seems to read completely wrong bytes.

i2cdump 1 0x52 i

produces the same corruption as with eeprom. So looks like indeed i2c 
block read isn't implemented correctly in the driver:-( Added Ben und 
Darius to cc - any ideas how to fix? As I said below - both i2c-imx and 
i2c-mxc have this bug.

Thanks
Guennadi

> > I would suspect a software bug, but I get this with two alternative 
> > adapter drivers (mxc and imx - see my recent post to the list), and on a 
> > laptop with 2.6.26 I don't get this. The kernel on i.MX31 is a pretty 
> > fresh linux-next. Does this look like a hardware "feature"? Or do we have 
> > a regression?
> 
> Does this happen as root, or as a regular user, or both? FWIW, the
> eeprom driver handles EEPROMs by blocks of 32 bytes, and for some
> EEPROM types, some fields are zeroed for non-root users, for privacy
> purposes. I doubt this is related to your problem, but let's still keep
> it in mind.
> 
> Do you use both the at24 and eeprom drivers on your system?
> 
> If you think this is a regression then please figure out the last
> kernel which behaved properly and the first kernel which started
> failing.
> 
> -- 
> Jean Delvare
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

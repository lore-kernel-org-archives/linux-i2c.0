From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C from interrupt context?
Date: Fri, 7 Nov 2008 10:11:18 +0100
Message-ID: <20081107101118.286f3713@hyperion.delvare>
References: <m3bpws8ln3.fsf@maximus.localdomain>
	<20081106.154754.02648408.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081106.154754.02648408.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 06 Nov 2008 15:47:54 -0800 (PST), David Miller wrote:
> From: Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>
> Date: Fri, 07 Nov 2008 00:44:48 +0100
> 
> [ Fixed i2c list address, it's now hosted at vger ]
> 
> > I'm updating my EEPROM console logger and have encountered a problem
> > - the logger (as any console) can be called with hardware interrupts
> > disabled and/or from interrupt context. It needs to write to I^2C
> > (using ARM (Xscale) GPIO) and possibly SMBUS-only EEPROM chip. Is it
> > at all supposed to be possible?
> 
> Not really.  The I2C operations need to be able to sleep and that's
> not allowed in interrupt context.

That's not totally correct. Since kernel 2.6.25, i2c_transfer()
supports being called in contexts where it cannot sleep. Of course, for
it to work, the underlying i2c adapter driver must also not sleep. As I
recall, only the i2c-pxa driver was explicitly modified to support this
at the moment (see member use_pio of struct pxa_i2c) but other drivers
could be modified in a similar way (and some i2c adapter drivers may be
naturally non-sleeping - everything based on i2c-algo-bit is likely to
fall into this category.)

The situation is far from perfect though. For one thing, I seem to
recall that Andrew Morton didn't like the approach taken in
i2c_transfer(). For another, i2c_smbus_xfer() was not yet modified so
at this point only I2C-level transactions can be non-sleeping,
SMBus-level transactions can't. But all this could be fixed by anyone
who cares about these specific issues.

-- 
Jean Delvare

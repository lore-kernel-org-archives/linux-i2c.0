From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: I2C from interrupt context?
Date: Thu, 06 Nov 2008 15:47:54 -0800 (PST)
Message-ID: <20081106.154754.02648408.davem@davemloft.net>
References: <m3bpws8ln3.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m3bpws8ln3.fsf-fiqtE+24Nu0B9AHHLWeGtNQXobZC6xk2@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>
Date: Fri, 07 Nov 2008 00:44:48 +0100

[ Fixed i2c list address, it's now hosted at vger ]

> I'm updating my EEPROM console logger and have encountered a problem
> - the logger (as any console) can be called with hardware interrupts
> disabled and/or from interrupt context. It needs to write to I^2C
> (using ARM (Xscale) GPIO) and possibly SMBUS-only EEPROM chip. Is it
> at all supposed to be possible?

Not really.  The I2C operations need to be able to sleep and that's
not allowed in interrupt context.

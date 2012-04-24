From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V1 2/2] i2c: tegra: support for I2C_M_NOSTART protocol
 mangling
Date: Tue, 24 Apr 2012 15:07:50 +0200
Message-ID: <20120424150750.36f8c2fc@endymion.delvare>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>
	<1335251976-31925-3-git-send-email-ldewangan@nvidia.com>
	<20120424105557.7ac07232@endymion.delvare>
	<4F967089.3050004@nvidia.com>
	<20120424143241.0d66fd2e@endymion.delvare>
	<20120424124030.GD13747@opensource.wolfsonmicro.com>
	<20120424130118.GD4030@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120424130118.GD4030-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Apr 2012 15:01:18 +0200, Wolfram Sang wrote:
> > > * We should allocate a new functionality flag for it.
> > > * We should update the documentation to reflect the two use cases.
> > 
> > That sounds like a good plan.  I'll try to get round to it if nobody
> > beats me to it.
> 
> Would it make sense to make all four I2C_M_* mangling features seperate
> I2C_FUNC_* options? The old I2C_FUNC_PROTOCOL_MANGLING could then be all
> four (seperately) exposed mangling features ORed. That's what I was
> wondering when looking at the patch.

The problem is that the functionality is stored in a 32-bit integer,
and we already use 17 bits in it, so every use of extra bits must be
pondered. OK, we have 15 free at the moment, but we could need some in
the future for new SMBus-style transactions, for example multi-byte
addressed block reads and writes.

I think the assumption was that mangling requires full control of the
bus lines, so a driver would either support all quirks (i2c-algo-bit)
or none (everybody else), thus having a single functionality flag. As
it seems I2C_M_NOSTART no longer fits the "quirky" category, having a
separate flag for it would make sense. But I would leave the rest alone
for the time being.

-- 
Jean Delvare

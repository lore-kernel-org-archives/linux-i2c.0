From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH, RFC] Freescale STMP: i2c driver
Date: Mon, 22 Jun 2009 11:51:48 +0100
Message-ID: <20090622105148.GC9006@fluff.org.uk>
References: <1244059155.4074.19.camel@hp.diimka.lan> <20090608225034.GA20446@fluff.org.uk> <1245169539.32549.12.camel@hp.diimka.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1245169539.32549.12.camel-GL0tbJR47UuzLY3athcO2A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 16, 2009 at 08:25:39PM +0400, dmitry pervushin wrote:
> Hello Ben,
> 
> I am sending the updated patch in next message, and this message is just
> to answer your questions/concerns.\
> 
> [...]
> > > +#include <mach/regs-apbx.h>
> > > +
> > > +static const u32 I2C_READ = 1,
> > > +		 I2C_WRITE = 0;
> > 
> > do you really want to be defining things with a prefix of I2C, thatB
> > might end up clashing with the i2c core?
> Fixed, changed to I2C_SMBUS_READ/WRITE as Jean Delvare proposed.
> > 
> > > +static const struct stmp3xxx_dma_command cmd_i2c_select = {
> > > +	.cmd =	BF(1, APBX_CHn_CMD_XFER_COUNT)	|
> > > +		BF(1, APBX_CHn_CMD_CMDWORDS)	|
> > > +		BM_APBX_CHn_CMD_WAIT4ENDCMD	|
> > > +		BM_APBX_CHn_CMD_CHAIN		|
> > > +		BF(BV_APBX_CHn_CMD_COMMAND__DMA_READ, APBX_CHn_CMD_COMMAND),
> > 
> > what is BF() ?
> it is the macro from arch/arm/plat-stmp3xxx/include/mach/platform.h,
> abbreviated "bitfield" :) For example, BF(1, APBX_CHn_CMD_CMDWORDS) is
> expanded like 
> ((1 << BP_APBX_CHn_CMD_CMDWORDS) & BM_APBX_CHn_CMD_CMDWORDS).
> BP_xxx stuff means bitfield position, BM_xxx - bitfield mask. 

yuck. I don't like people hiding thinks in macros for what is very
little gain, especially when an extant constant is being used!

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

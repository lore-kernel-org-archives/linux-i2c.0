From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/4] i2c-designware: always set the STOP bit after last
 byte
Date: Thu, 17 Jan 2013 12:42:47 +0200
Message-ID: <20130117104247.GU2239@intel.com>
References: <1358418667-4533-1-git-send-email-mika.westerberg@linux.intel.com>
 <1358418667-4533-3-git-send-email-mika.westerberg@linux.intel.com>
 <20130117103248.GL10814@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130117103248.GL10814@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, dirk.brandewie@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 17, 2013 at 12:32:48PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jan 17, 2013 at 12:31:05PM +0200, Mika Westerberg wrote:
> > If IC_EMPTYFIFO_HOLD_MASTER_EN is set to one, the DesignWare I2C controller
> > doesn't generate STOP on the bus when the FIFO is empty. This violates the
> > rules of Linux I2C stack as it requires that the STOP is issued once the
> > i2c_transfer() is finished.
> > 
> > However, there is no way to detect this from the hardware registers, so we
> > must make sure that the STOP bit is always set once the last byte of the
> > last message is transferred.
> > 
> > This patch is based on the work of Dirk Brandewie.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c |   16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> > index f5258c2..94fd818 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -413,11 +413,23 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
> >  		rx_limit = dev->rx_fifo_depth - dw_readl(dev, DW_IC_RXFLR);
> >  
> >  		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
> > +			u32 cmd = 0;
> > +
> > +			/*
> > +			 * If IC_EMPTYFIFO_HOLD_MASTER_EN is set we must
> > +			 * manually set the stop bit. However, it cannot be
> > +			 * detected from the registers so we set it always
> > +			 * when writing/reading the last byte.
> > +			 */
> > +			if (dev->msg_write_idx == dev->msgs_num - 1 &&
> > +			    buf_len == 1)
> > +				cmd |= BIT(9);
> > +
> >  			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
> > -				dw_writel(dev, 0x100, DW_IC_DATA_CMD);
> > +				dw_writel(dev, cmd | 0x100, DW_IC_DATA_CMD);
> >  				rx_limit--;
> >  			} else
> > -				dw_writel(dev, *buf++, DW_IC_DATA_CMD);
> > +				dw_writel(dev, cmd | *buf++, DW_IC_DATA_CMD);
> 
> also need to send STP bit if I2C_M_STOP is set.

True but only if the driver exposes I2C_FUNC_PROTOCOL_MANGLING, which is
not done in this driver.

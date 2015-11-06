From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH 1/1] I2C: designware: fix IO timeout issue for AMD
 controller
Date: Fri, 6 Nov 2015 04:34:19 +0000
Message-ID: <1C99EED8F51BBC41A8F1E645B51245F41AE8AA50@scybexdag03.amd.com>
References: <1446726884-30558-1-git-send-email-Xiangliang.Yu@amd.com>
 <20151105135216.GN1509@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2on0064.outbound.protection.outlook.com ([207.46.100.64]:44179
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030793AbbKFEtE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 Nov 2015 23:49:04 -0500
In-Reply-To: <20151105135216.GN1509@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xue, Ken" <Ken.Xue@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Wang, Annie" <Annie.Wang@amd.com>, "Li, Tony" <Tony.Li@amd.com>

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Thursday, November 05, 2015 9:52 PM
> To: Yu, Xiangliang
> Cc: andriy.shevchenko@linux.intel.com; jarkko.nikula@linux.intel.com;
> wsa@the-dreams.de; linux-i2c@vger.kernel.org; linux-
> kernel@vger.kernel.org; Xue, Ken; Wan, Vincent; Huang, Ray; Wang, Annie;
> Li, Tony
> Subject: Re: [PATCH 1/1] I2C: designware: fix IO timeout issue for AMD
> controller
> 
> On Thu, Nov 05, 2015 at 08:34:44PM +0800, Xiangliang Yu wrote:
> > Because of some hardware limitation, AMD I2C controller can't trigger
> > next interrupt if interrupt status has been changed after clearing
> > interrupt status bits. Then, I2C will lost interrupt and IO timeout.
> >
> > According to hardware design, this patch implements a workaround to
> > disable i2c controller interrupt after clearing interrupt bits when
> > entering ISR and to enable i2c interrupt before exiting ISR.
> >
> > To reduce the performance impacts on other vendors, use unlikely
> > function to check flag in ISR.
> >
> > Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c    | 6 ++++++
> >  drivers/i2c/busses/i2c-designware-core.h    | 1 +
> >  drivers/i2c/busses/i2c-designware-platdrv.c | 4 ++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c
> > b/drivers/i2c/busses/i2c-designware-core.c
> > index 7441cdc..04e7b65 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -783,6 +783,9 @@ irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> >
> >  	stat = i2c_dw_read_clear_intrbits(dev);
> 
> What if the status changes right here, before you go and mask the interrupt?
Have no effect, because i2c controller can't trigger next interrupt.

> 
> >
> > +	if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK))
> > +		i2c_dw_disable_int(dev);
> > +
> >  	if (stat & DW_IC_INTR_TX_ABRT) {
> >  		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
> >  		dev->status = STATUS_IDLE;
> > @@ -811,6 +814,9 @@ tx_aborted:
> >  	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) ||
> dev->msg_err)
> >  		complete(&dev->cmd_complete);
> >
> > +	if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK))
> > +		dw_writel(dev, DW_IC_INTR_DEFAULT_MASK,
> DW_IC_INTR_MASK);
> 
> The driver disables TX interrupt when it is not needed anymore or when TX
> gets aborted but the above will re-enable all interrupts regardless.
> Is that the intention?
No, i2c controller can trigger next interrupt only after re-enable all interrupt.

> 
> > +
> >  	return IRQ_HANDLED;
> >  }
> >  EXPORT_SYMBOL_GPL(i2c_dw_isr);
> > diff --git a/drivers/i2c/busses/i2c-designware-core.h
> > b/drivers/i2c/busses/i2c-designware-core.h
> > index 9630222..808ef6a 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.h
> > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > @@ -111,6 +111,7 @@ struct dw_i2c_dev {
> >
> >  #define ACCESS_SWAP		0x00000001
> >  #define ACCESS_16BIT		0x00000002
> > +#define ACCESS_INTR_MASK	0x00000004
> >
> >  extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);  extern void
> > dw_writel(struct dw_i2c_dev *dev, u32 b, int offset); diff --git
> > a/drivers/i2c/busses/i2c-designware-platdrv.c
> > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 472b882..0c59357 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -251,6 +251,10 @@ static int dw_i2c_probe(struct platform_device
> *pdev)
> >  		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
> >  		dev->adapter.nr = pdev->id;
> >  	}
> > +
> > +	if (!strncmp(pdev->name, "AMD0010", 7))
> > +		dev->accessor_flags |= ACCESS_INTR_MASK;
> > +
> 
> Can't you put this to ->driver_data? For example it could refer to a
> configuration structure that then contains quirk flags.
I think it will need to add a function to support it, but the function
Is  rarely used. It will easy to add if i2c driver has quirk mechanisms.
Added code is very simple and have no influence on others.

> 
> >  	r = i2c_dw_init(dev);
> >  	if (r)
> >  		return r;
> > --
> > 1.9.1

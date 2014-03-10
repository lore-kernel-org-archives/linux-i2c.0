From: "Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2] i2c: designware-pci: add 10-bit addressing mode
 functionality for BYT I2C
Date: Mon, 10 Mar 2014 10:12:44 +0000
Message-ID: <604BF5F4C5D71041942BC7E84ED659EA0155D56E@PGSMSX103.gar.corp.intel.com>
References: <1394201571-11681-1-git-send-email-chiau.ee.chew@intel.com>
 <1394201571-11681-2-git-send-email-chiau.ee.chew@intel.com>
 <20140309085357.GA4695@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140309085357.GA4695@katana>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
> Sent: Sunday, March 09, 2014 4:54 PM
> To: Chew, Chiau Ee
> Cc: Mika Westerberg; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 1/2] i2c: designware-pci: add 10-bit addressing mode
> functionality for BYT I2C
> 
> On Fri, Mar 07, 2014 at 10:12:50PM +0800, Chew Chiau Ee wrote:
> > From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > All the I2C controllers on Intel BayTrail LPSS subsystem able to
> > support 10-bit addressing mode functionality.
> >
> > Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Ong, Boon Leong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-designware-pcidrv.c |   17 +++++++++++------
> >  1 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > index f1dabee..87f2fc4 100644
> > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > @@ -64,12 +64,19 @@ struct dw_pci_controller {
> >  	u32 tx_fifo_depth;
> >  	u32 rx_fifo_depth;
> >  	u32 clk_khz;
> > +	u32 functionality;
> >  };
> >
> >  #define INTEL_MID_STD_CFG  (DW_IC_CON_MASTER |
> 	\
> >  				DW_IC_CON_SLAVE_DISABLE |	\
> >  				DW_IC_CON_RESTART_EN)
> >
> > +#define DW_DEFAULT_FUNCTIONALITY (I2C_FUNC_I2C |
> 	\
> > +					I2C_FUNC_SMBUS_BYTE |
> 	\
> > +					I2C_FUNC_SMBUS_BYTE_DATA |
> 	\
> > +					I2C_FUNC_SMBUS_WORD_DATA |
> 	\
> > +					I2C_FUNC_SMBUS_I2C_BLOCK)
> 
> Can't we have I2C_FUNC_SMBUS_EMUL here? (Need checking with
> I2C_SMBUS_QUICK)

Per my understanding, this I2C host is not able to support I2C_SMBUS_QUICK.

From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V2] i2c: designware: fix race between subsequent xfers
Date: Mon, 17 Jun 2013 11:34:20 +0300
Message-ID: <20130617083420.GK11878@intel.com>
References: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
 <1370595083-801-1-git-send-email-christian.ruppert@abilis.com>
 <20130614143740.GD2929@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130614143740.GD2929@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Ruppert <christian.ruppert@abilis.com>, Jean Delvare <khali@linux-fr.org>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 14, 2013 at 04:37:41PM +0200, Wolfram Sang wrote:
> On Fri, Jun 07, 2013 at 10:51:23AM +0200, Christian Ruppert wrote:
> > The designware block is not always properly disabled in the case of
> > transfer errors. Interrupts from aborted transfers might be handled
> > after the data structures for the following transfer are initialised but
> > before the hardware is set up. This can corrupt the data structures to
> > the point that the system is stuck in an infinite interrupt loop (where
> > FIFOs are never emptied because dev->msg_read_idx == dev->msgs_num).
> > 
> > This patch cleanly disables the designware-i2c hardware at the end of
> > every transfer, be it successful or not.
> > 
> > This patch requires https://patchwork.kernel.org/patch/2601241/ to be
> > applied first.
> 
> These last two lines should be below "---".
> 
> > 
> > Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c |   10 ++++++++--
> >  1 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> > index b75d292..55a9991 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -588,11 +588,19 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >  	ret = wait_for_completion_timeout(&dev->cmd_complete, HZ);
> >  	if (ret == 0) {
> >  		dev_err(dev->dev, "controller timed out\n");
> > +		/* i2c_dw_init implicitly disables the adapter */
> >  		i2c_dw_init(dev);
> >  		ret = -ETIMEDOUT;
> >  		goto done;
> >  	}
> >  
> > +	/*
> > +	 * We must disable the adapter before unlocking the &dev->lock mutex
> > +	 * below. Otherwise the hardware might continue generating interrupts
> > +	 * which in turn causes a race condition with the following transfer.
> 
> I added "Needs some more investigation if the additional interrupts are
> a hardware bug or this driver doesn't handle them correctly yet." to the
> comment and
> 
> Applied to for-next, thanks!

Sorry for the late response (was on vacation). This patch looks good to me
as well. Thanks for applying it!

From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v7] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 5 Mar 2013 11:09:36 -0500
Message-ID: <20130305160936.GB23095@hmsreliant.think-freely.org>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
 <1360007650-26272-1-git-send-email-nhorman@tuxdriver.com>
 <20130210150205.GB6282@nekote.pengutronix.de>
 <20130305142225.GA23095@hmsreliant.think-freely.org>
 <20130305154253.317bd23a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130305154253.317bd23a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 05, 2013 at 03:42:53PM +0100, Jean Delvare wrote:
> Hi Neil,
> 
> On Tue, 5 Mar 2013 09:22:25 -0500, Neil Horman wrote:
> > On Sun, Feb 10, 2013 at 04:02:05PM +0100, Wolfram Sang wrote:
> > > On Mon, Feb 04, 2013 at 02:54:10PM -0500, Neil Horman wrote:
> > > > The iSMT (Intel SMBus Message Transport) supports multi-master I2C/SMBus,
> > > > as well as IPMI.  It's operation is DMA-based and utilizes descriptors to
> > > > initiate transactions on the bus.
> > > > 
> > > > The iSMT hardware can act as both a master and a target, although this
> > > > driver only supports being a master.
> > > > 
> > > > Signed-off-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
> > > > Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > > Tested-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > 
> > > Thanks, applied to for-next!
> > > 
> > > 
> > Wolfram-
> > 	Hey, sorry to bother you, but I just wanted to check on this patch. I
> > see its accepted in patchwork, but I haven't seen it show up in your git tree
> > yet, and I was really hoping this would make 3.9.  Since we're in the -rc run
> > for that release, i wanted to check with you to see if you were planning to push
> > it.
> 
> Your driver is already in 3.9, see:
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/i2c/busses/i2c-ismt.c
> 
Crud, I was on the wrong branch.  Sorry for the noise!
Neil

> -- 
> Jean Delvare
> 

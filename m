From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Manually set RESTART bit between messages
Date: Thu, 4 Jul 2013 10:41:21 +0300
Message-ID: <20130704074121.GD4898@intel.com>
References: <1371798328-31931-1-git-send-email-chiaue.ee.chew@intel.com>
 <20130703201510.GB2958@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130703201510.GB2958@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Chew Chiau Ee <chiaue.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 03, 2013 at 10:15:11PM +0200, Wolfram Sang wrote:
> 
> CCing Mika and Christian.
> 
> On Fri, Jun 21, 2013 at 03:05:28PM +0800, Chew Chiau Ee wrote:
> > From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > If both IC_EMPTYFIFO_HOLD_MASTER_EN and IC_RESTART_EN are set to 1, the
> > Designware I2C controller doesn't generate RESTART unless user specifically
> > requests it by setting RESTART bit in IC_DATA_CMD register.
> > 
> > Since IC_EMPTYFIFO_HOLD_MASTER_EN setting can't be detected from hardware
> > register, we must always manually set the restart bit between messages.
> > 
> > Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> How come restart has worked before? Or did it not?

It works fine. However IC_EMPTYFIFO_HOLD_MASTER_EN=1 makes a difference. We
had similar thing with the STOP that was fixed previously.

If I understand the dw i2c databook right, RESTART is only issued if the
transfer direction changes. So if you have two or more consecutive
transfers that have the same direction (not sure how common that is) there
is no RESTART between them unless DW_IC_CON_RESTART_EN is set.

Chiau Ee, does this fix a real problem?

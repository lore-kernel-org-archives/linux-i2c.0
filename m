From: "Westerberg, Mika" <mika.westerberg@intel.com>
Subject: Re: [PATCH] i2c-designware: Mask interrupts during i2c controller
 enable
Date: Mon, 7 Apr 2014 18:11:08 +0300
Message-ID: <20140407151107.GL19349@intel.com>
References: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70E1F@ORSMSX109.amr.corp.intel.com>
 <20140404181613.GB19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70F8B@ORSMSX109.amr.corp.intel.com>
 <20140404184232.GC19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A71351@ORSMSX109.amr.corp.intel.com>
 <20140405061316.GF19349@intel.com>
 <20140406185818.3aaca03d@alan.etchedpixels.co.uk>
 <20140407090403.GG19349@intel.com>
 <20140407154252.6b8f0f7e@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140407154252.6b8f0f7e@alan.etchedpixels.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Du, Wenkai" <wenkai.du@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 07, 2014 at 03:42:52PM +0100, One Thousand Gnomes wrote:
> > I had to check BYT specs about that and I couldn't find if it does
> > posted-writes. 
> 
> Then I would assume it does unless you can find a hardware engineer to
> sign a statement in blood to that effect 8)

Fair enough.

> > Actually the following patch should fix the problem as well. Just move the
> > HW enable to happen last. That way we can make sure that there is a valid
> > interrupt mask programmed before the controller is enabled.
> 
> This fixes the init case, it doesn't fix the question about returning
> from the IRQ before the mask write takes effect and thus taking another
> interrupt.

Do you think we can fix it with adding a dummy read right after write to
the mask register, like the snippet below?

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 14c4b30d4ccc..ff9090381d8b 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -535,6 +535,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		intr_mask = 0;
 
 	dw_writel(dev, intr_mask,  DW_IC_INTR_MASK);
+	dw_readl(dev, DW_IC_INTR_MASK);
 }
 
 static void

From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Mask interrupts during i2c controller
 enable
Date: Sun, 6 Apr 2014 18:58:18 +0100
Message-ID: <20140406185818.3aaca03d@alan.etchedpixels.co.uk>
References: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70E1F@ORSMSX109.amr.corp.intel.com>
	<20140404181613.GB19349@intel.com>
	<7286EAF50D3F4E4AADE7FEECEBF8B5A537A70F8B@ORSMSX109.amr.corp.intel.com>
	<20140404184232.GC19349@intel.com>
	<7286EAF50D3F4E4AADE7FEECEBF8B5A537A71351@ORSMSX109.amr.corp.intel.com>
	<20140405061316.GF19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140405061316.GF19349-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 5 Apr 2014 09:13:16 +0300
"Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Sat, Apr 05, 2014 at 12:54:33AM +0300, Du, Wenkai wrote:
> > >Interrupt masking is done already after each transaction.
> > 
> > At end of transfer, the code uses __i2c_dw_enable(dev, false) to disable
> > adapter. This function doesn't mask interrupts. There is another function
> > i2c_dw_disable that masks and clears interrupts. This could be used, but
> > that means we need to fix in 2 places: 
> 
> Please check i2c_dw_isr() and tell me in which code path interrupts are not
> getting masked. Or am I missing something fundamental here?
> 
> In case of abort, we mask interrupts. Also whenever the transaction
> completes we mask interrupts (in i2c_dw_xfer_msg()).

Well actually you mask the IRQ at some point after the function returns
if the bus allows the write to be posted. As i2c_dw_isr can then exit the
IRQ handler before the write completes I suspect you have a race ?

Alan

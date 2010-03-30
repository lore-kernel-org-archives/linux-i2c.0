From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: removing set_clientdata(NULL)
Date: Tue, 30 Mar 2010 09:05:27 +0200
Message-ID: <20100330090527.303e2386@hyperion.delvare>
References: <20100327121558.GA5880@pengutronix.de>
	<20100329162812.548d131b@hyperion.delvare>
	<20100329150956.GB6717@pengutronix.de>
	<20100329172734.7cd7341d@hyperion.delvare>
	<20100330024831.GB23862@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100330024831.GB23862-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, 30 Mar 2010 04:48:31 +0200, Wolfram Sang wrote:
> On Mon, Mar 29, 2010 at 05:27:34PM +0200, Jean Delvare wrote:
> > Not sure what you mean there... What's the alternative?
> 
> I was confused by your "so that drivers can start removing the call on their
> end quickly". It sounded a bit like they should care themselves.

Ah. I mean that if they care, they can do it themselves. But most
probably they don't care and will leave it up to us (that is, you).

> > No, 2.6.35. This touches too many drivers for 2.6.34 at this point in
> > time.
> 
> I agree. So I base the removal-patch on rc3, so it can go to linux-next. If
> there are other users of i2c_set_clientdata popping up until the merge-window,
> it will be handled by an incremental patch.
> 
> > > - also patches per subsystem?
> > 
> > Not sure if it's worth the effort.
> 
> Not much effort, I made scripts for that :) Still, I think it should go in just
> using one commit. Let's hope it won't get too intrusive (= creating conflicts).

If it turns out to be an issue, I guess we could hold on and generate
the path again at the end of the 2.6.35 merge window.

> > > - shall this better go via the i2c-tree?
> > 
> > This seems simpler, yes. I don't think subsystem or driver maintainers
> > need to be bothered with what is really only a cleanup.
> 
> Yes.

Thanks,
-- 
Jean Delvare

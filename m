From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: removing set_clientdata(NULL)
Date: Mon, 29 Mar 2010 17:27:34 +0200
Message-ID: <20100329172734.7cd7341d@hyperion.delvare>
References: <20100327121558.GA5880@pengutronix.de>
	<20100329162812.548d131b@hyperion.delvare>
	<20100329150956.GB6717@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100329150956.GB6717-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 29 Mar 2010 17:09:56 +0200, Wolfram Sang wrote:
> Hi Jean,
> 
> > Sorry for being a little quiet, I took a long, well-deserved week-end
> > off and didn't have the time to reply before I left. Now I'm back...
> 
> No worries, no rush :)
> 
> > Yes, my intent was to add a call to i2c_set_clientdata(x, NULL) in
> > i2c_device_remove(). We would do this immediately, so that drivers can
> > start removing the call on their end quickly (and new ones are not
> > added.)
> > 
> > Can you please send the patch for i2c-core and Documentation/i2c? It's
> > not difficult but I don't want to steal your credits.
> 
> Yes, can do this in a few hours (already midnight here), this is for 2.6.34
> then.
> 
> > It would also be fair to warn all the developers you already contacted
> > with your first attempt and let them know that it is being cancelled,
> > and let them know the new plan. Hopefully this will avoid useless
> > commits.
> 
> Can do this, too. About the removal of the i2c_set_clientdata-calls:
> 
> - shall I prepare a series for that, too?

Not sure what you mean there... What's the alternative?

> - also for 2.6.34?

No, 2.6.35. This touches too many drivers for 2.6.34 at this point in
time.

> - also patches per subsystem?

Not sure if it's worth the effort.

> - shall this better go via the i2c-tree?

This seems simpler, yes. I don't think subsystem or driver maintainers
need to be bothered with what is really only a cleanup.

-- 
Jean Delvare

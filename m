From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: removing set_clientdata(NULL)
Date: Mon, 29 Mar 2010 16:28:12 +0200
Message-ID: <20100329162812.548d131b@hyperion.delvare>
References: <20100327121558.GA5880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100327121558.GA5880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Sorry for being a little quiet, I took a long, well-deserved week-end
off and didn't have the time to reply before I left. Now I'm back...

On Sat, 27 Mar 2010 13:15:58 +0100, Wolfram Sang wrote:
> Hi Jean,
> 
> do you have already something in mind how to proceed with the
> i2c_setclientdata-topic? I could offer the following:
> 
> I modify my semantic patch to remove all set_clientdata(NULL) calls connected
> to a kfree(). Then, we could have a look if there are still some left and
> investigate why. Once all issues are resolved (maybe there are none), we should
> know what to add in the core-layer, hopefully just the call to set_clientdata.

Yes, my intent was to add a call to i2c_set_clientdata(x, NULL) in
i2c_device_remove(). We would do this immediately, so that drivers can
start removing the call on their end quickly (and new ones are not
added.)

Can you please send the patch for i2c-core and Documentation/i2c? It's
not difficult but I don't want to steal your credits.

It would also be fair to warn all the developers you already contacted
with your first attempt and let them know that it is being cancelled,
and let them know the new plan. Hopefully this will avoid useless
commits.

> Regarding this comment:
> 
> > the core should just set the client data to NULL. If there are drivers that
> > rely on the current behavior, then those drivers should be reviewed first as
> > to the reason why they need it.
> 
> I could check if there is any probe-function calling get_clientdata and making
> use of that? That is probably the most obvious thing which would need to rely
> on the current behaviour or did I miss something?

You are right, but I really hope you won't catch anybody doing this.
This would go against the device driver model.

-- 
Jean Delvare

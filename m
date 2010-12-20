From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: Encourage move to dev_pm_ops by warning on use of
 legacy methods
Date: Mon, 20 Dec 2010 23:38:14 +0000
Message-ID: <20101220233814.GB20387@opensource.wolfsonmicro.com>
References: <1292881260-31987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20101220215958.GB1126@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101220215958.GB1126-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 20, 2010 at 09:59:58PM +0000, Ben Dooks wrote:

> Ok, it'll generate warnings at load-time, maybe move it to when the
> drive is actually bound to a device?

It struck me that this warning was more likely to trigger as you don't
need to actually have the device present in a particular system, just
built into or loaded into the kernel, and that it probably ought to only
go off once per driver anyway.

> I'll look at pm-ops for the bus drivers after christmas, once the
> pre-emptive house spring-clean has finished...

With the patch I sent yesterday this should now all be delegated to the
PM core.

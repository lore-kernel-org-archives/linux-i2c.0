From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: omap patches
Date: Wed, 10 Aug 2011 05:37:07 -0700
Message-ID: <20110810123707.GL1939@atomide.com>
References: <20110801213006.GD22243@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110801213006.GD22243-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Sorry for the delay, I've been on vacation.

* Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> [110802 01:01]:
> Hi, should I have been queing these, or is someone else
> dealing with the dependencies between the omap arch and
> these driver updates?

Yes please. The following fix should go in during the -rc
cycle:

https://patchwork.kernel.org/patch/878772/

And then there's the i2c-omap.c series that you acked that
no longer has dependencies to the arch/arm/*omap*/* code.
So either I or Kevin will send a pull request for that for
the next merge window after some minor updates so it merges
cleanly.

Regards,

Tony

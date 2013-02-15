From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: Remove unneeded platform_set_drvdata to NULL in remove
Date: Fri, 15 Feb 2013 11:43:25 -0800
Message-ID: <CAD=FV=VTJN3bU1rpMyjDMvX1SYZJWoJCiNtHNe+nDrtwnXqTXA@mail.gmail.com>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
	<20130215193736.GD4351@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130215193736.GD4351-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

On Fri, Feb 15, 2013 at 11:37 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> I think we should do this at least I2C subsystem wide (51 occasions of
> setting some *_drvdata to NULL), even better kernel-wide. Patching
> individual drivers won't cut the confusion around this issue, I am
> afraid.

I did it "mux" directory wide and this was the only instance.  ;)
I'll re-send with I2C subsystem wide.  I probably won't attempt the
whole kernel wide at this point, but would be very happy if someone
else wanted to!  :)

Thanks for the review!

-Doug

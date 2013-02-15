From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: Remove unneeded platform_set_drvdata to NULL
 in remove
Date: Fri, 15 Feb 2013 20:37:36 +0100
Message-ID: <20130215193736.GD4351@the-dreams.de>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360953682-25066-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 15, 2013 at 10:41:22AM -0800, Doug Anderson wrote:
> Stephen Warren pointed out as part of a code review of another mux
> driver that there should be no need to have
> "platform_set_drvdata(pdev, NULL)" in the remove function.  Get rid of
> it in the i2c-mux-gpio driver.
> 
> See Stephen's comment at:
>   http://www.gossamer-threads.com/lists/linux/kernel/1678627?do=post_view_threaded#1678627
> 
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

I think we should do this at least I2C subsystem wide (51 occasions of
setting some *_drvdata to NULL), even better kernel-wide. Patching
individual drivers won't cut the confusion around this issue, I am
afraid.

Thanks,

   Wolfram

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C: i2c-pxa - remove incorrect __exit annotations
Date: Thu, 21 Feb 2013 11:01:28 +0100
Message-ID: <20130221100128.GC22806@the-dreams.de>
References: <20130220085008.GA11025@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130220085008.GA11025-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 20, 2013 at 12:50:10AM -0800, Dmitry Torokhov wrote:
> The remove() methods should not be marked __exit unless we are using
> platform_driver_probe() which disables unbinding device from driver
> via sysfs.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Eeks, I broke this with my very first linux patch years ago :) Applied
to -next, thanks!

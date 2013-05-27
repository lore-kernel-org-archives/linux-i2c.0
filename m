From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to subsys_initcall
Date: Mon, 27 May 2013 09:54:56 +0800
Message-ID: <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana> <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130525201032.GD32043-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2013/5/26 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, May 16, 2013 at 06:25:39PM +0800, Barry Song wrote:
>> 2013/5/16 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
>
>> > What about deferred probing?
>
>> deferred probing could work but could not work for automative.
>> what we really want is that devices begin to work as early as
>> possible. we want i2c clients like lcd, camera begin to show images as
>> early as possible as an automative requirement.
>
> Probe deferral should have at most a mimimal impact on the boot time -
> it's pretty much just changing the order providing the probe functions
> aren't excessively slow to defer.  If the probe functions are taking a
> long time to defer that's probably what needs looking at.
>
> If it really is probe deferral itself that's too slow then we ought to
> be looking at improving that rather than boding around it.

Mark, the case is not that deferred probing is slow or not. deferred
probing is pretty good.
the case is that we want to i2c and media connected with i2c probed
earlier than other devices.
in auto infotainment devices, we actually do some hacking in kernel
that makes rear view work earlier than other device driver
initialization with a kernel thread which take care of backing-car
policy not only mechanism. that means, we make camera work to see
backview image even earlier than other drivers' initialization.
we don't want media deferred to wait for i2c. we want make some early
jobs ready earlier.

-barry

From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
Date: Wed, 11 Sep 2013 14:05:43 +0300
Message-ID: <20130911110543.GA7393@intel.com>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
 <20130910213522.GG29403@sirena.org.uk>
 <2029393.u6DaKBPszu@vostro.rjw.lan>
 <522FC0DC.9030708@intel.com>
 <20130911095552.GI29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130911095552.GI29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 11, 2013 at 10:55:52AM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2013 at 09:01:16AM +0800, Aaron Lu wrote:
> 
> > Looks like, it all boils down to how many I2C devices should be allowed
> > for runtime PM by default and how many I2C devices should be forbidden.
> > , and then we allow/forbid runtime PM for the majority case in I2C core
> > while individual driver can still forbid/allow it in their own code.
> 
> > So if the majority case is runtime PM should be allowed by default, I'm
> > also OK to not forbid runtime PM for I2C client device in I2C core. My
> > original intention to forbid runtime PM by default is to make sure no
> > adverse effect would occur to some I2C devices that used to work well
> > before runtime PM.
> 
> The really big problem here is that there are I2C devices currently
> using runtime PM quite happily and forbidding it by default will break
> them.
> 
> In general though requiring userspace to manually activate power saving
> features isn't going to make people happy.

Yeah, we are going change that in the next revision (default to RPM
unblocked).

I'll also look into converting the existing I2C client drivers to use this
method. One question, though, is it better to have the conversion in the
same patch that introduces the I2C core runtime PM change or as a separate
patch?

From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Fri, 4 May 2012 20:50:45 +0200
Message-ID: <201205042050.46033.rjw@sisk.pl>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com> <201205032125.37631.rjw@sisk.pl> <20120504125830.GM14230@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120504125830.GM14230-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rickard ANDERSSON <rickard.andersson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, May 04, 2012, Mark Brown wrote:
> On Thu, May 03, 2012 at 09:25:37PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, May 03, 2012, Mark Brown wrote:
> 
> > > This seems like a really useful idiom in general - might it be worth
> > > supporting as a standard framework feature?
> 
> > The generic PM domains framework does this, it's not platform-specific
> > (if I understood your question correctly).
> 
> AIUI it only works if the device gets placed into a doman, though?

Yes, it does, because otherwise the runtime PM framework avoids calling
.runtime_suspend() or .runtime_resume() twice in a row.

So the flag is only when the callbacks are not always run through the runtime
PM framework, like when domains are involved.

Thanks,
Rafael

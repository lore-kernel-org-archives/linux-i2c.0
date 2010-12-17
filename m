From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 17 Dec 2010 14:25:07 +0100
Message-ID: <201012171425.07775.rjw@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com> <20101217125427.GA29640@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101217125427.GA29640-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, December 17, 2010, Mark Brown wrote:
> On Thu, Dec 16, 2010 at 11:56:57PM +0530, Rabin Vincent wrote:
> 
> > There seem to be some differences between the generic ops and the i2c
> > and platform busses' implementations of the interaction between runtime
> > PM and system sleep:
> 
> >   (1) The platform bus does not implement the
> >       don't-call-pm->suspend()-if pm_runtime_suspended()-returns-true
> >       functionality implemented by the generic ops and i2c.
> 
> This is platform lagging behind I2C in implementation - both originally 
> did what platform does and then I2C was updated and platform wasn't.
> 
> It'd be really good if this could all be factored out into the PM core,
> we're going to have to do the same thing for at least SPI as well and
> possibly some other buses :/

So how exactly the PM core is supposed to include those things?

There certainly are other buses that don't want to do them.

Thanks,
Rafael

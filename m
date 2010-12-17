From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 17 Dec 2010 14:49:25 +0100
Message-ID: <201012171449.26082.rjw@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com> <201012171425.07775.rjw@sisk.pl> <20101217133434.GH31453@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101217133434.GH31453-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, December 17, 2010, Mark Brown wrote:
> On Fri, Dec 17, 2010 at 02:25:07PM +0100, Rafael J. Wysocki wrote:
> > On Friday, December 17, 2010, Mark Brown wrote:
> 
> > > It'd be really good if this could all be factored out into the PM core,
> > > we're going to have to do the same thing for at least SPI as well and
> > > possibly some other buses :/
> 
> > So how exactly the PM core is supposed to include those things?
> 
> > There certainly are other buses that don't want to do them.
> 
> By, for example, providing default implementations which the buses can
> use if they choose to.

OK, so we have generic_subsys_pm_ops.  Do we need anything beyond that?

Rafael

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: dev_pm_ops conversion.
Date: Thu, 30 Jul 2009 00:47:12 +0100
Message-ID: <20090729234712.GB8850@fluff.org.uk>
References: <1248115661-20189-1-git-send-email-manuel.lauss@gmail.com> <20090720210617.GA28218@fluff.org.uk> <f861ec6f0907202202w104f269au8086a243b68d9b3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f861ec6f0907202202w104f269au8086a243b68d9b3a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 21, 2009 at 07:02:58AM +0200, Manuel Lauss wrote:
> Hi Ben,
> 
> On Mon, Jul 20, 2009 at 11:06 PM, Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> 
> >> +
> >> +static struct dev_pm_ops au1xpsc_smbus_pmops = {
> >> + ? ? .resume ? ? ? ? = i2c_au1550_resume,
> >> + ? ? .suspend ? ? ? ?= i2c_au1550_suspend,
> >> +};
> >>
> >> ?static struct platform_driver au1xpsc_smbus_driver = {
> >> ? ? ? .driver = {
> >> ? ? ? ? ? ? ? .name ? = "au1xpsc_smbus",
> >> ? ? ? ? ? ? ? .owner ?= THIS_MODULE,
> >> + ? ? ? ? ? ? .pm ? ? = &au1xpsc_smbus_pmops,
> >
> > hmm, why not
> > ? ? ? ? ? ? ? ?.pm ? ? = (struct dev_pm_ops &) {
> > ? ? ? ? ? ? ? ? ? ? ? ?.suspend ? ? ? ?= ...,
> > ? ? ? ? ? ? ? ? ? ? ? ?.resume ? ? ? ? = ...,
> > ? ? ? ? ? ? ? ?},
> >
> > ?
> 
> I remember one patch being shot down on account of having this
> style.  I prefer the original style too, but I've no objections to changing
> it...

no objections on style, the only thing to change is to put the
#ifdef CONFIG_PM back.
 
> Thank you!
>        Manuel Lauss
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

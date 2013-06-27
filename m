From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 0/4] Kontron PLD drivers
Date: Thu, 27 Jun 2013 23:48:08 +0200
Message-ID: <20130627214808.GB26192@zurbaran>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
 <1372046406-3127-1-git-send-email-kevin.strasser@linux.intel.com>
 <20130624120650.GC30838@zurbaran>
 <20130627203436.GB30950@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130627203436.GB30950-1F/o1hAF34+bEvaWgpTR7kEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Strasser <strassek-29tvszzbzErpgkiH4x7ZXw@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Michael Brunner <Michael.Brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>, Chris Healy <chealy-KRR2zmvM+DFWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dirk Hohndel <Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wim,

On Thu, Jun 27, 2013 at 10:34:36PM +0200, Wim Van Sebroeck wrote:
> Hi All,
> 
> > > Changes since v2:
> > > -Change Michael's "Signed-off-by" to "Originally-From" in all patches
> > > -Add "From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>" to gpio patch
> > > 
> > > Guenter Roeck (1):
> > >   gpio: Kontron PLD gpio driver
> > > 
> > > Kevin Strasser (3):
> > >   mfd: Kontron PLD mfd driver
> > >   i2c: Kontron PLD i2c bus driver
> > >   watchdog: Kontron PLD watchdog timer driver
> > I just applied (after a warning fix) and pushed the MFD driver, thanks.
> > 
> > I am happy to take the sub devices driver as well, although the
> > respective maintainers can safely carry them as they all have a Kconfig
> > dependency on MFD_KEMPLD. So it's up to them.
> > If I have to take them, I'd need Wolfram's ACK for the i2c one and Wim's
> > for the watchdog one. Linus already ACKed the GPIO one.
> 
> Acked-by: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
> 
> I'm OK that itgoes via the MFD tree.
I took it, thanks for your ACK.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

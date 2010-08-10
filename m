From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Status of multiplexed i2c support
Date: Tue, 10 Aug 2010 08:13:51 -0700
Message-ID: <20100810151351.GA19251@ericsson.com>
References: <20100721042922.GA30524@ericsson.com>
 <20100810142938.5a2e1bd1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100810142938.5a2e1bd1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 10, 2010 at 08:29:38AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late answer, I am just returning from vacation.
> 
Hi Jean,

I figured that much...

> On Tue, 20 Jul 2010 21:29:22 -0700, Guenter Roeck wrote:
> > what is the current status of i2c mux support, specifically support for pca945x ?
> 
> (Assuming this is a typo and you really meant pca954x.)
> 
obviously ..

> Support is ready for public consumption and will be merged upstream
> very soon now (i.e. before 2.6.36-rc1.) The PCA954x family will be the
> first supported one, support will be merged together with core
> multiplexing support.
> 

Yes, I found your updated patchset a couple of hours after I sent my e-mail.
Since then, I backported the code to 2.6.32 (which is what we are currently
using here).

> Note that I don't take much credit for this, all the hard work was done
> by Rodolfo Giometti and Michael Lawnick (Cc'd), which were additionally
> kind enough to patiently wait for someone (that is me) to review their
> work.

Excellent job, by everyone involved. I think this is a prime example
of how to introduce new functionality into the kernel.

Guenter

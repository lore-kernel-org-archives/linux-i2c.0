From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/2] i2c: davinci: Couple of patches to make i2c usable
 on Keystone SOCs
Date: Mon, 12 Aug 2013 00:26:49 +0000
Message-ID: <448912EABC71F84BBCADFD3C67C4BE5285C5D1@DBDE04.ent.ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <52054C7E.70108@ti.com>,<20130811095337.GA3796@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130811095337.GA3796-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

(Sorry for top posting ..)

No dependency so feel free to pick and merge them appropriately.

Regards,
Santosh
________________________________________
From: Wolfram Sang [wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
Sent: Sunday, August 11, 2013 5:53 AM
To: Shilimkar, Santosh
Cc: Nori, Sekhar; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Subject: Re: [PATCH 0/2] i2c: davinci: Couple of patches to make i2c usable on Keystone SOCs

On Fri, Aug 09, 2013 at 04:09:34PM -0400, Santosh Shilimkar wrote:
> Wolfram, Sekhar,
>
> On Wednesday 24 July 2013 08:28 PM, Santosh Shilimkar wrote:
> > Keystone SOCs uses the same I2C IP as available on DaVinci SOCs. These
> > couple of patches makes it possible to select the I2C_DAVINCI on
> > Keystone SOCs.
> >
> > Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> >
> > Santosh Shilimkar (2):
> >   i2c: davinci: remove useless mach/hardware include
> >   i2c: davinci: Allow i2c driver available for keystone platforms
> >
> Who is queuing up these patches ?

I can pick them. Do they depend on something?

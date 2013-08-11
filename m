From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 0/2] i2c: davinci: Couple of patches to make i2c usable
 on Keystone SOCs
Date: Sun, 11 Aug 2013 11:53:38 +0200
Message-ID: <20130811095337.GA3796@the-dreams.de>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <52054C7E.70108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52054C7E.70108-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

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

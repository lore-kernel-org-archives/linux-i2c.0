From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: convert to platform driver
Date: Thu, 17 Jan 2008 17:38:56 +0100
Message-ID: <20080117163856.GB13110@roarinelk.homelinux.net>
References: <20071006161606.GB9270@roarinelk.homelinux.net>
	<20071027200521.3d800147@hyperion.delvare>
	<20080117165916.5171348d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080117165916.5171348d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: cd-8pe3aW1LYQuzSzjNS9e3XA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 17, 2008 at 04:59:16PM +0100, Jean Delvare wrote:
> Hi Manuel,
> 
> On Sat, 27 Oct 2007 20:05:21 +0200, Jean Delvare wrote:
> > Hi Manuel,
> > 
> > On Sat, 6 Oct 2007 18:16:06 +0200, Manuel Lauss wrote:
> > > From db75417225eb3bddcbc2e5b57d97fef2cc0ce4c6 Mon Sep 17 00:00:00 2001
> > > From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> > > Date: Sat, 6 Oct 2007 17:21:40 +0200
> > > Subject: [PATCH] i2c-au1550: convert to platform driver
> > > 
> > > Convert the i2c-au1550.c driver to a platform_device, get rid of the
> > > i2c-au1550.h file and hook up I2C for the alchemy demoboards.
> > > 
> > > Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> > > ---
> > >  arch/mips/au1000/common/platform.c |   21 +++++
> > >  drivers/i2c/busses/i2c-au1550.c    |  152 ++++++++++++++++++++---------------
> > >  drivers/i2c/busses/i2c-au1550.h    |   32 --------
> > >  3 files changed, 108 insertions(+), 97 deletions(-)
> > >  delete mode 100644 drivers/i2c/busses/i2c-au1550.h
> 
> Any news from this patch? I didn't hear about this since I reviewed
> it back in October 2007. If you would submit an update addressing the
> problems I had noticed back then, I could queue this patch for 2.6.25.
> From what I remember, there weren't many changes needed.

I was waiting for the other au1550 fix to be accepted before resending.
I'll post a revamped version shortly.

Thanks,
	Manuel Lauss

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: fix PM support.
Date: Sat, 28 Jun 2008 19:57:05 +0200
Message-ID: <20080628195705.202fef80@hyperion.delvare>
References: <20080619082749.GA20058@roarinelk.homelinux.net>
	<20080628112746.32349c47@hyperion.delvare>
	<20080628161232.22f0ba50@scarran>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080628161232.22f0ba50@scarran>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

On Sat, 28 Jun 2008 16:12:32 +0200, Manuel Lauss wrote:
> Hi Jean,
> 
> > Hi Manuel,
> > 
> > On Thu, 19 Jun 2008 10:27:49 +0200, Manuel Lauss wrote:
> > > From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> > > 
> > > Factor out reset/disable code to separate functions as they are
> > > also required for suspend/resume.
> > > 
> > > Tested on Au1200.
> > > 
> > > Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/i2c-au1550.c |  119 +++++++++++++++++++++------------------
> > >  1 files changed, 64 insertions(+), 55 deletions(-)
> > 
> > This patch doesn't apply cleanly on top of 2.6.26-rc8. I can try to fix
> > it manually, but given that I can't even build the i2c-au1550 driver,
> > that's a bit risky. Can you please update the patch so that it applies
> > on top of 2.6.26-rc8, test again and resubmit?
> 
> Sorry about that; here is the new and tested patch.
> I took the opportunity to sneak one additional change in (runtime PM).
> 
> Thanks!
> 	Manuel Lauss
> 
> --
> 
> From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> Subject: [PATCH] i2c-au1550: fix PM support.
> 
> Fix driver power management:
> - suspend the PSC while driver is idle.
> - move PSC init/deinit to separate functions, as PSC must be
>   initialized/shutdown on resume/suspend.
> 
> Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-au1550.c |  130 ++++++++++++++++++++++----------------
>  1 files changed, 75 insertions(+), 55 deletions(-)
> 

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

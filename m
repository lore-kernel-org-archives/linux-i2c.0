From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-rc8] i2c: fix platform driver
 hotplug/coldplug
Date: Thu, 10 Apr 2008 19:51:18 +0200
Message-ID: <20080410195118.327575f5@hyperion.delvare>
References: <200804091354.07807.david-b@pacbell.net>
	<20080410133444.6f910312@hyperion.delvare>
	<200804100949.10255.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200804100949.10255.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kay-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 10 Apr 2008 09:49:09 -0700, David Brownell wrote:
> On Thursday 10 April 2008, Jean Delvare wrote:
> > On Wed, 9 Apr 2008 13:54:07 -0700, David Brownell wrote:
> > > From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
> > > 
> > > Since 43cc71eed1250755986da4c0f9898f9a635cb3bf, the platform
> > > modalias is prefixed with "platform:". Add MODULE_ALIAS() to the
> > > hotpluggable I2C platform drivers, to allow module auto loading.
> > > 
> > > [ db: add some more drivers ]
> > > 
> > > Signed-off-by: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
> > > Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/...
> > >  17 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > <snip>
> > 
> > OK... Is this a regression we need to fix in 2.6.25, or can this patch
> > wait until 2.6.26?
> 
> It was a regresssion as of 2.6.24, for 200+ drivers;
> every platform_bus driver used have hotplug/coldplug
> support, but that patch stopped that from working.
> 
> The thing is, that had only been working for a few
> releases at that time, so not many folk were relying
> on it yet.  They would just have been able to start
> doing so when that mechanism stopped working.
> 
> So I can't see a rush to get this into 2.6.25 now.
> I think the 200+ drivers will hotplug/coldplug again
> in 2.6.26 ... I've pushed almost a hundred such driver
> updates by now (sigh).

OK, patch queued up for 2.6.26, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

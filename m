From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [patch 2.6.25-rc3] tps65010 driver converts to gpiolib
Date: Tue, 4 Mar 2008 17:43:02 +0200
Message-ID: <20080304154301.GN31006@atomide.com>
References: <20080228220729.9B01C28E0DB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080303140539.GB31006@atomide.com>
	<200803030934.37376.david-b@pacbell.net>
	<20080303231818.2f03d5d6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080303231818.2f03d5d6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> [080304 00:50]:
> On Mon, 3 Mar 2008 09:34:37 -0800, David Brownell wrote:
> > On Monday 03 March 2008, Tony Lindgren wrote:
> > > * David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> [080229 00:12]:
> > > > Make the tps65010 driver use gpiolib to expose its GPIOs.
> > > > 
> > > > Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > > > ---
> > > > NOTE:  this depends on the patch to convert OMAP over to gpiolib.
> > > > Also, commit e27a93a944a5ba6a0112750c8243abba86d56e94 broke both
> > > > H2 and H3 support ... that seems to be a 2.6.25-rc regression.
> > > 
> > > Pushing to linux-omap & adding to omap-upstream for post 2.6.25.
> > 
> > That seems best to me, although Jean should probably ack this...
>
> Jean is too busy these days to even look at the patch... but I trust
> you, if you and Tony are happy with the patch, I am totally fine with
> it going upstream through the omap tree.

Well looks like I accidentally added this to omap-upstream although it's
I2C only patch..

But considering that it depends on omap gpiolib patches, pushing this
via omap-upstream sounds like a good idea to me :) Will keep Jean Cc'd.

Cheers,

Tony

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

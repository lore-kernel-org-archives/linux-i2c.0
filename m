From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
 updates, part 2
Date: Sun, 24 Feb 2008 10:30:52 +0100
Message-ID: <20080224103052.66da6803@hyperion.delvare>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<200802231010.40108.david-b@pacbell.net>
	<20080223202832.4a953910@hyperion.delvare>
	<200802231153.04011.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200802231153.04011.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 23 Feb 2008 11:53:03 -0800, David Brownell wrote:
> On Saturday 23 February 2008, Jean Delvare wrote:
> > On Sat, 23 Feb 2008 10:10:39 -0800, David Brownell wrote:
> > > On Saturday 23 February 2008, Felipe Balbi wrote:
> > > > Thanks Dave, the patch is attached. patch 1 is acked by Jean, right Jean?
> > 
> > Yes, except that my copy has "isp->irq_type = 0;" removed.
> 
> From a bzeroed structure?  Then I won't worry about that difference...

I removed this statement exactly because the structure is kzalloc'd.
You don't have to worry as a tester. I do worry as the i2c subsystem
maintainer, because I'd like Felipe to base his second patch on the
"right" first patch, so that it applies properly to my tree.

Felipe, my version of the first patch is available here:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-isp1301_omap-convert-to-new-style-1.patch

Please make sure that the next update to the second part applies
properly on top of it.

> > > But not yet in the I2C merge queue??
> > 
> > I was waiting for the second part. The first part doesn't make much
> > sense alone. I could add the first part to my i2c tree, but I can't
> > merge it upstream without the second part.
> 
> That makes no sense to me.  If the first part is OK, it's OK to
> merge without the second part.

And if the second part never makes it, we end up with garbage in the
upstream kernel. Thanks but no thanks.

> Even if you don't _plan_ to merge it soon, it'd be less confusing
> to have that in your queue ... say, towards the end, below a line
> that indicates a scheduled merge point.  (FWIW that's not unlike
> Andrew does with MM.)

Indeed, the first patch in question has even been in -mm for quite some
time now, and Andrew keeps sending it to me so that I take it in my i2c
tree. So I've now included the first part in my public i2c patch queue
to make everyone happy. But then again, there is no "scheduled merge
point" for a patchset that is not yet complete.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

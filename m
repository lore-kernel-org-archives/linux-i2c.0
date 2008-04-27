From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Sun, 27 Apr 2008 14:18:56 +0200
Message-ID: <20080427141856.7725e877@hyperion.delvare>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<200804221612.06745.laurentp@cse-semaphore.com>
	<20080423131657.71d6312f@hyperion.delvare>
	<200804231412.40038.laurentp@cse-semaphore.com>
	<20080423144756.3fc9b1bf@hyperion.delvare>
	<480F390A.90707@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <480F390A.90707-NIgtFMG+Po8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Apr 2008 15:26:34 +0200, Jochen Friedrich wrote:
> Hi Jean,
> 
> > Jochen, I'm a bit confused by the dependencies that exist - or not -
> > between these 7 patches you sent at once. I thought they had to be
> > applied in sequence but it seems not? And some of them should
> > apparently go through me i2c tree but others (e.g. [7/7]) not?
> 
> [1/7] and [2/7] are forward ports of patches from you. I'm currently
> just running a make allmodconfig compile to check if it really caught
> all affected i2c drivers.
> 
> These are the patches we are talking about.
> 
> [3/7] is the OF helper stuff which translates between OF names and
> i2c types. It does NOT translate OF names to module names, but relies
> on [1/7] to do so. Without [1/7], [3/7] still applies, but module
> auto loading won't work.
> 
> This has been applied to 2.6.26.
> 
> > I would appreciate if you could summarize quickly which patches depend
> > on others in which way. If we can make smaller subsets of patches, that
> > will be easier for me to review and push upstream on my limited time.
> 
> [4/7] is the patch from Jon Smirl to convert i2c-mpc to OF. This relies
> on [3/7] instead of Jons initial OF-autoloading patches you didn't like.
> As there were no comments at all, I would however postpone this to 2.6.27.
> 
> [5/7] is the cleanup patch (originating from you) which completely removes
> old driver matching scheme. This should probably wait until 2.6.27, as well.
> This relies on [1/7] and [2/7].
> 
> [6/7] and [7/7] are a new driver and depend on [3/7]. This can wait for 2.6.27,
> as well (i would rather like to see those in -mm to get more testing, though).

Thanks for the summary. Right now I'm working on [1/7] and [2/7] to get
something ready to go upstream in the next few days. Probably only a
part of [2/7] can go there quickly, non-trivial cases (e.g. ivtv) will
have to wait until rc2 or later. I also agree with you that [5/7]
should be delayed for now, we need to make sure that no driver is left
using the old device/driver matching scheme, and that can't possibly be
done before rc2 at best.

I will post the 2 updated patches for review and testing as soon as I
am done.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

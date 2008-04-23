From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Wed, 23 Apr 2008 14:47:56 +0200
Message-ID: <20080423144756.3fc9b1bf@hyperion.delvare>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<200804221612.06745.laurentp@cse-semaphore.com>
	<20080423131657.71d6312f@hyperion.delvare>
	<200804231412.40038.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200804231412.40038.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Apr 2008 14:12:37 +0200, Laurent Pinchart wrote:
> On Wednesday 23 April 2008 13:16, Jean Delvare wrote:
> > I still don't know exactly what happened there... I think I saw some
> > "OpenFirmware i2c" patches go upstream yesterday? But not the ones
> > listed below, which I thought they depended upon.
> 
> The code that went upstream introduces helper functions to create i2c devices 
> from information supplied by the OF device tree. It doesn't strictly depend 
> on the below patches, but the new devices won't be properly bound to a driver 
> without them.

OK. So... Out of the 7 patches Jochen sent originally, only 1 ([3/7] OF
helpers for the i2c API) went upstream. Am I correct?

Jochen, I'm a bit confused by the dependencies that exist - or not -
between these 7 patches you sent at once. I thought they had to be
applied in sequence but it seems not? And some of them should
apparently go through me i2c tree but others (e.g. [7/7]) not?

I would appreciate if you could summarize quickly which patches depend
on others in which way. If we can make smaller subsets of patches, that
will be easier for me to review and push upstream on my limited time.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

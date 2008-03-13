From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/6] Blackfin I2C TWI driver updates
Date: Thu, 13 Mar 2008 15:50:59 +0800
Message-ID: <386072610803130050j47f2659bpbf53199c7dec4916@mail.gmail.com>
References: <1205479360-25240-1-git-send-email-cooloney@kernel.org>
	<20080312193718.1aa86caf@hyperion.delvare>
	<386072610803121907y499903ban37456d06d36a07a8@mail.gmail.com>
	<Pine.LNX.4.64.0803130726410.26435@pc-213-140-179-32.aina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0803130726410.26435-er0LZAA46r2WwDxiJSwuDc1vFkv34tBQrE5yTffgRl4@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Kalle Pokki <kalle.pokki-jgfpPLbCha8@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 13, 2008 at 1:43 PM, Kalle Pokki <kalle.pokki-jgfpPLbCha8@public.gmane.org> wrote:
> On Thu, 13 Mar 2008, Bryan Wu wrote:
>
>  > I understand. It is too late.
>  >
>  > Actually, I plan to send out these for 2.6.26 at first. But found
>  > following BF54x compiling error:
>
>  Please post a fix for the compile error in 2.6.25. As Jean pointed out,
>  build and bug fixes should always be sent upstream asap, without waiting
>  for the next merge window.
>

[PATCH 2/6]  is to fix this compile error bug.
So Jean, could you please just merge
patch 1/6 and patch 2/6 for 2.6.25, while others for 2.6.26?

>  Although I don't have a BF54x platform I have at times run into a few
>  other build failures with BF533 and BF537. These are the most irritating
>  bugs for other people to discover in the final releases since they should
>  be the simplest to find and fix, often leaving the impression the code
>  wasn't even built before submitting. Of course, in reality we cannot
>  always build for every platform.
>

Actually, we got a daily build machine try to build upstream mainline
git-tree, -mm tree
and other source tree with all Blackfin platform configuration. This
BF54x compile error was
found by this. We will try to fix it before stable version out.

>  Actually, patch 1/6 seems to be a real bug fix. In the current code the
>  i2c-bfin-twi master transmit is broken for all drivers requiring a restart
>  condition.
>

So patch 1/6 and patch 2/6 is ready for 2.6.25, don't they?

Thanks
Regards,
-Bryan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

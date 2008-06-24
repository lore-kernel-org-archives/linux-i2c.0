From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa.c recover from false start
Date: Tue, 24 Jun 2008 18:51:55 +0200
Message-ID: <20080624185155.18d27cad@hyperion.delvare>
References: <36A8B4824CA88E478F1A25136D0597610112DD04@mail.ad.skymv.com>
	<20080619134237.3b7dff53@hyperion.delvare>
	<36A8B4824CA88E478F1A25136D0597610112DEAE@mail.ad.skymv.com>
	<20080624180307.6de9d47d@hyperion.delvare>
	<36A8B4824CA88E478F1A25136D05976101163DF1@mail.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <36A8B4824CA88E478F1A25136D05976101163DF1-RKsfjrak5bi0VCHWTNMfawC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Chuck Kamas <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Jun 2008 09:13:11 -0700, Chuck Kamas wrote:
> > please discuss this with someone
> >familiar with the i2c-pxa driver
> 
> Who is the official maintainer of the PXA code?  I would like very much
> to come up with a better way to deal with bus faults, and Nukes, that
> the reset work around I came up with.

File MAINTAINERS apparently has the answer to this question. You might
additionally want to check
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/i2c/busses/i2c-pxa.c
for a list of recent contributors to the i2c-pxa driver.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

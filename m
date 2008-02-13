From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 6/6] Minor fixes for pxa-driver
Date: Wed, 13 Feb 2008 14:11:35 +0100
Message-ID: <20080213141135.5945db53@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143659.089906703@pengutronix.de>
	<20080213095839.5d99d48a@hyperion.delvare>
	<47B2DB21.7020404@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <47B2DB21.7020404-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mike,

On Wed, 13 Feb 2008 13:57:21 +0200, Mike Rapoport wrote:
> Jean Delvare wrote:
> > Looks good. I've added a couple more fixes, resulting patch is below.
> > As I don't have hardware for testing either, I would appreciate if
> > someone with a PXA board could test it and confirm that it causes no
> > regression. Mike? Eric? I plan to send this patch to Linus for 2.6.25
> > (i.e. quickly.)
> 
> This patch doesn't apply on top of Linus' tree most probably due
> to a conflict with this patch by Eric Miao:
> 
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-pxa-use-cpu_is_pxa27x.patch

This patch no longer exists as a file because it has already been merged
into Linus' tree:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=59d70df025473931c500d6d60510798e4bfa3279

My patch was generated on top of Linus' tree so it certainly applies
there.

> Except that, it seems to be Ok, at least with the hardware I have.

Thanks for testing and reporting!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

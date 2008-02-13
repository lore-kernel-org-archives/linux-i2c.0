From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [patch 6/6] Minor fixes for pxa-driver
Date: Wed, 13 Feb 2008 13:57:21 +0200
Message-ID: <47B2DB21.7020404@compulab.co.il>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143659.089906703@pengutronix.de>
	<20080213095839.5d99d48a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-reply-to: <20080213095839.5d99d48a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Wolfram,
> 
> On Mon, 21 Jan 2008 15:20:16 +0100, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
>> While working on the PCA9564-platform driver, I sometimes had a glimpse at the
>> pxa-driver. I found some suspicious places, and this patch contains my
>> suggestions. Note: They are not tested, due to no hardware.
> 
> Looks good. I've added a couple more fixes, resulting patch is below.
> As I don't have hardware for testing either, I would appreciate if
> someone with a PXA board could test it and confirm that it causes no
> regression. Mike? Eric? I plan to send this patch to Linus for 2.6.25
> (i.e. quickly.)

This patch doesn't apply on top of Linus' tree most probably due
to a conflict with this patch by Eric Miao:

http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-pxa-use-cpu_is_pxa27x.patch

Except that, it seems to be Ok, at least with the hardware I have.


> From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Subject: i2c-pxa: Misc fixes
> 
> While working on the PCA9564-platform driver, I sometimes had a glimpse at the
> pxa-driver. I found some suspicious places, and this patch contains my
> suggestions. Note: They are not tested, due to no hardware.
> 

[ snip ]



-- 
Sincerely yours,
Mike.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Mon, 23 Jun 2008 15:59:09 +0200
Message-ID: <20080623155909.525f5095@hyperion.delvare>
References: <20080620084155.GA17701@pengutronix.de>
	<20080623124425.GE3926@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080623124425.GE3926-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 23 Jun 2008 14:44:25 +0200, Wolfram Sang wrote:
> On Fri, Jun 20, 2008 at 10:41:55AM +0200, Wolfram Sang wrote:
> 
> Any new on this one? I think at least the interrupt fix should make it
> into 2.6.26. The mistakenly activated interrupt caused a regression
> here, which made at24 fail on writes.

I was away for the week-end and am now processing the stacked e-mail
and other real-life tasks (takes time.)

I fail to see how there would be a regression here given that the
i2c-cpm driver is new and is not in kernel 2.6.26. It will only be
merged in 2.6.27-rc1. Not to mean that we don't want to fix the bugs
quickly, but it feels less urgent than if it was in 2.6.26.

As far as the review is concerned, ideally Jochen would do it as the
driver author and someone who presumably has hardware to test the
driver (I don't.) If Jochen acks the patch then I can add it to my i2c
tree quickly.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

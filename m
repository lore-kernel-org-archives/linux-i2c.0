From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Fri, 27 Jun 2008 10:15:11 +0200
Message-ID: <4864A18F.5070804@scram.de>
References: <20080620084155.GA17701@pengutronix.de>	<20080623124425.GE3926@pengutronix.de>
	<20080623155909.525f5095@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080623155909.525f5095-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>> Any new on this one? I think at least the interrupt fix should make it
>> into 2.6.26. The mistakenly activated interrupt caused a regression
>> here, which made at24 fail on writes.
> 
> I was away for the week-end and am now processing the stacked e-mail
> and other real-life tasks (takes time.)

I was away the last 2 weeks, as well and just finished my stacked e-mail.

> As far as the review is concerned, ideally Jochen would do it as the
> driver author and someone who presumably has hardware to test the
> driver (I don't.) If Jochen acks the patch then I can add it to my i2c
> tree quickly.

I'll do this ASAP now.

Thanks,
Jochen

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

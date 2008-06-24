From: "Chuck Kamas" <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa.c recover from false start
Date: Tue, 24 Jun 2008 09:13:11 -0700
Message-ID: <36A8B4824CA88E478F1A25136D05976101163DF1@mail.ad.skymv.com>
References: <36A8B4824CA88E478F1A25136D0597610112DD04@mail.ad.skymv.com><20080619134237.3b7dff53@hyperion.delvare><36A8B4824CA88E478F1A25136D0597610112DEAE@mail.ad.skymv.com>
	<20080624180307.6de9d47d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080624180307.6de9d47d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

Jean,

> please discuss this with someone
>familiar with the i2c-pxa driver

Who is the official maintainer of the PXA code?  I would like very much
to come up with a better way to deal with bus faults, and Nukes, that
the reset work around I came up with.

Chuck


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

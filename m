From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH 0/2] i2c: Add support for device alias names
Date: Mon, 28 Apr 2008 22:24:28 +0200
Message-ID: <4816327C.3080207@scram.de>
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428153543.GB4353@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080428153543.GB4353-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Laurent-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Kay-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> I tested on this hardware
> 
>  MPC8260 (powerpc) + PCF8575 (io expander) + LM84 (sensor)
>  + RS5C372 (rtc) + X24645 (eeprom)

It's also OK on dbox2 hardware: MPC823 (powerpc)
+ saa7127 (patch needed to add id_table) + dbox frontprocessor
(8051 controller with i2c interface).

Thanks,
Jochen

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

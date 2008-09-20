From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: tvp5150 new style i2c driver
Date: Sat, 20 Sep 2008 10:16:23 +0200
Message-ID: <20080920101623.791ed72f@hyperion.delvare>
References: <48D3C5A3.3080802@spesonline.com>
	<20080919222608.030a3801@hyperion.delvare>
	<48D41902.9020804@spesonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48D41902.9020804-wNesuFfO2Ajz1n+OaKNE4w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Luca Santini <luca.santini-wNesuFfO2Ajz1n+OaKNE4w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Luca,

Please keep the i2c list Cc'd.

On Fri, 19 Sep 2008 23:26:26 +0200, Luca Santini wrote:
> My board is a custom board based on a Renesas SH4 cpu (sh7760). 
> This uP has 2 i2c channels where i have a tvp5150 video codec, a
> wm8731 audio codec , a realtime clock and a renesas h8  connected
> to; so my i2c bus is drivers/i2c/busses/i2c-sh7760.c .
> 
> my goal - regarding tvp5150 - is to initialize it and set it's
> input (to composite, for the moment).
> The digital video output is 'directly' (there's only a mux
> controlled by H8 beetween) connected to GPU (fujitsu lime).
> (...)
> "SMBus Quick command not supported, " in drivers/i2c/i2c-core.c
> sorry for previous imprecision.

Indeed, the i2c-sh7760 driver doesn't support the SMBus Quick command.
This means that devices on that bus can't be probed. You can still use
legacy i2c drivers on that bus; all you have to do is load them with
the "force" parameter:

modprobe tvp5150 force=0,0x5c

(Adjust for the actual bus number and device address on your system.)

Admittedly, with a new-style i2c driver you would no longer have to do
that. That being said, that's only a small part of your problem. The
other part is that you need some glue code to register a video device
through which you can control your TVP5150 chip.

> (...)
> http://lists.lm-sensors.org/pipermail/i2c/2007-June/001462.html

Ah, right. Well, did you try contacting Jorge Luis Zapata Muga about
this? If someone did some work on the tvp5150 driver, that would be
him. I plan to convert all i2c drivers in the kernel tree to new-style
drivers eventually, but I have no plan to work on the tvp5150 driver in
a near future.

> so my interface will be something like /dev/video ?

Yes.

> I'll be able to change i.e. sources by this?

I do not understand your question, sorry.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 10:16:55 +0200
Message-ID: <20080605101655.4397206c@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604233335.13459512@hyperion.delvare>
	<Pine.LNX.4.58.0806041638080.10290@shell4.speakeasy.net>
	<200806041727.51746.david-b@pacbell.net>
	<Pine.LNX.4.58.0806041731250.10290@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0806041731250.10290-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Wed, 4 Jun 2008 17:40:05 -0700 (PDT), Trent Piepho wrote:
> So scanning an I2C bus doesn't work as well as with PCI, we all know that.
> How does creating a new "i2c listeners" system solve any of these problems?

There are two key properties of the i2c listeners:

1* They live besides the driver model and complement it, rather than
   replacing it. They have to, because the driver model cares about
   device enumeration and device/driver binding, NOT device detection
   and identification in the hardware sense of the terms.

2* Listeners allow the i2c-core to delegate the device detection /
   identification to the drivers themselves (avoiding a fat, slow and
   unmaintainable centralized detection routine) but the drivers are
   still not creating the devices themselves (so the device driver
   model's spirit is respected.)

> You still want to probe for a chip and there's no foolproof way to do that,
> and there's still no way to know for sure what chip you have found.

That's correct, but the fact is that for example all I2C-based hardware
monitoring drivers are already doing their best to identify the chips
they support, with good success. The question is not whether we'll do
that or not - we _have_ to do it in many cases. The question is how we
implement it.

Currently we have a separate binding model for this case, I'm proposing
something that would instead fit in the standard binding model, only
adding the part that the binding model doesn't cover. This is certainly
an improvement, I don't think anyone can deny this. Not to say that my
proposal cannot be improved further - it certainly can.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

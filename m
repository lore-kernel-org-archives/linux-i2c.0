From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PCF8563 doesn't pass validation check
Date: Wed, 2 Jul 2008 13:10:20 +0200
Message-ID: <20080702131020.28e1979a@hyperion.delvare>
References: <200807021134.59668.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200807021134.59668.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rod Whitby <rod-wR+KslBqWDsXC2x5gXVKYQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Laurent,

On Wed, 2 Jul 2008 11:34:55 +0200, Laurent Pinchart wrote:
> I'm having issues with the PCF8563 RTC chip.
> 
> The Linux driver tries to validate the chip by checking if the
> BCD-coded time and date registers contain valid values.
> 
> When a low voltage condition is detected, the registers are not
> guaranteed to contain valid values. Experimentation showed that
> while the seconds, minutes, hours and day of the week registers
> didn't cause any issue, the months register could get out of the
> 01-12 range.
> 
> Has anyone experienced the same issue ?

This issue sounds familiar, I think Alessandro mentioned it to me a few
weeks ago in private already.

> Would it be acceptable to remove the months register check ?

I think you should convert rtc-pcf8563 to a new-style i2c driver. Then
the whole validation function becomes pointless and you can delete it.
I guess that the PCF8563 chip is used in embedded designs with platform
code to instantiate the I2C devices as needed, so it should work fine.
Apparently some IXP4xx platforms already expect rtc-pcf8563 to be a
new-style i2c driver... I'm curious if some ARM people have already
converted the driver. Rod?

> I've contacted NXP to get more information about what the chip
> guarantees and what it doesn't. I haven't had any answer yet but
> I expect them to tell me there is no guarantee at all.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

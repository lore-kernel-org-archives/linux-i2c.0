From: Rod Whitby <rod-wR+KslBqWDsXC2x5gXVKYQ@public.gmane.org>
Subject: Re: PCF8563 doesn't pass validation check
Date: Wed, 02 Jul 2008 20:51:55 +0930
Message-ID: <486B64D3.3080600@whitby.id.au>
References: <200807021134.59668.laurentp@cse-semaphore.com>
	<20080702131020.28e1979a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080702131020.28e1979a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> I think you should convert rtc-pcf8563 to a new-style i2c driver. Then
> the whole validation function becomes pointless and you can delete it.
> I guess that the PCF8563 chip is used in embedded designs with platform
> code to instantiate the I2C devices as needed, so it should work fine.
> Apparently some IXP4xx platforms already expect rtc-pcf8563 to be a
> new-style i2c driver... I'm curious if some ARM people have already
> converted the driver. Rod?

I believe this patch:

<http://svn.nslu2-linux.org/svnroot/kernel/trunk/patches/2.6.25/rtc-pcf8563-new-style.patch>

was merged as:

<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=e5fc9cc0266e5babcf84c81908ec8843b7e3349f>

-- Rod

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

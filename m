From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-pcf8575: check for errors when accessing the
 chip
Date: Thu, 15 May 2008 20:54:16 +0200
Message-ID: <20080515205416.0a6bdaf9@hyperion.delvare>
References: <1210862127-9493-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1210862127-9493-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, 15 May 2008 16:35:27 +0200, Wolfram Sang wrote:
> Make the driver check and report error cases when reading from or writing to
> the chip. It used to assume 'always success' and could even deliver bogus
> values.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> The PCF on my system seems broken, it does not respond (and I can't probe as my
> master doesn't support smbus_quick). The broken chip went unnoticed as the
> driver reported some (= bogus) values. So, I can only test the properly
> reported error cases, hopefully someone else can confirm the working case.
> (Michael and Bart, sorry for double post)
> 
>  drivers/i2c/chips/pcf8575.c |   29 +++++++++++++++++++++--------
>  1 files changed, 21 insertions(+), 8 deletions(-)

This driver is deprecated and you should be using
drivers/gpio/pcf857x.c instead if you can. That driver properly handles
I/O errors as far as I can see.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

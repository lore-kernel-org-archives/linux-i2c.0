From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Remove client validation
Date: Wed, 2 Jul 2008 13:34:57 +0200
Message-ID: <20080702133457.05a75e7c@hyperion.delvare>
References: <200807021332.15495.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200807021332.15495.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
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

On Wed, 2 Jul 2008 13:32:14 +0200, Laurent Pinchart wrote:
> Validating clients with black magic register checks doesn't make much sense
> for new-style i2c driver and has been known to fail on valid NXP pcf8563 chips.
> This patch removes the client validation code.
> 
> Signed-off-by: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
> ---
>  drivers/rtc/rtc-pcf8563.c |   58 ---------------------------------------------
>  1 files changed, 0 insertions(+), 58 deletions(-)
> (...)

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

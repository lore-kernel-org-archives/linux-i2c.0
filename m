From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Ramtron FM3130 RTC support
Date: Wed, 4 Jun 2008 13:49:50 +0200
Message-ID: <20080604134950.6d77bebb@hyperion.delvare>
References: <12125798043537-git-send-email-slapin@ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <12125798043537-git-send-email-slapin-9cOl001CZnBAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "[Sergey Lapin" <slapin-9cOl001CZnBAfugRpC6u6w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed,  4 Jun 2008 15:43:24 +0400, [Sergey Lapin wrote:
> From: Sergey Lapin <slapin-9cOl001CZnBAfugRpC6u6w@public.gmane.org>
> 
> Hi, all!
> This patch provides support for RTC in Ramtron FM3130 chip
> which is I2C RTC+FRAM.
>
> Signed-off-by: Sergey Lapin <slapin-9cOl001CZnBAfugRpC6u6w@public.gmane.org>
> ---
>  drivers/rtc/Kconfig      |    7 +
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-fm3130.c |  481 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 489 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-fm3130.c
> 

Wrong mailing list, please check MAINTAINERS.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

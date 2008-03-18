From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 2
Date: Tue, 18 Mar 2008 13:42:59 +0100
Message-ID: <20080318134259.1b7e2878@hyperion.delvare>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-2-git-send-email-me@felipebalbi.com>
	<1205585237-21492-3-git-send-email-me@felipebalbi.com>
	<1205585237-21492-4-git-send-email-me@felipebalbi.com>
	<20080315124918.GA21547@kedavra.cpe.vivax.com.br>
	<20080315125458.GB21547@kedavra.cpe.vivax.com.br>
	<20080315131309.GA24990@kedavra.cpe.vivax.com.br>
	<20080316105617.GA4503@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080316105617.GA4503-4vvIQG7NF+ITKvXZea5imILpUPVTGn5w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felipe,

On Sun, 16 Mar 2008 12:56:18 +0200, Felipe Balbi wrote:
> This patch uses set_irq_type as suggested by Dave.
> 
> ============= CUT HERE =========
> 
> From 293a73277794a1ca0f2307e7fe9d5ecd76d3ad06 Mon Sep 17 00:00:00 2001
> From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
> Date: Tue, 1 Jan 2008 23:00:18 -0500
> Subject: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates, part 2
> 
> Based on David Brownell's patch for tps65010, this patch
> finish conversting isp1301_omap.c to new-style i2c driver.
> 
> Signed-off-by: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
> ---
>  arch/arm/mach-omap1/board-h2.c   |    4 +
>  arch/arm/mach-omap1/board-h3.c   |    8 ++
>  arch/arm/mach-omap2/board-h4.c   |   14 ++++
>  drivers/i2c/chips/isp1301_omap.c |  134 ++++++++++---------------------------
>  4 files changed, 62 insertions(+), 98 deletions(-)

OK, I've applied this version of the patch. Note though that I am still
worried that it removed platform-specific code (in
isp1301_detach_client/isp1301_remove, isp1301_set_host and
isp1301_probe). The IRQ mode setting has moved to the board code, but
the rest has simply disappeared. I really would like you to confirm
that it is OK, or to send an updated patch if not.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

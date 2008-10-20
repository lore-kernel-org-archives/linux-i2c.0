From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] [RESEND] i2c-cpm: Suppress autoprobing for devices
Date: Mon, 20 Oct 2008 09:46:07 -0500
Message-ID: <00F15E59-07B4-436E-9CEA-B445826E5534@kernel.crashing.org>
References: <20081016111300.GC3432@pengutronix.de>
	<20081016191200.GB13629@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081016191200.GB13629-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Oct 16, 2008, at 2:12 PM, Wolfram Sang wrote:

> Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also  
> remove
> automatic probing for this i2c controller. Might need updates to dts  
> files
> using it.
>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Acked-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> ---
> Resend with cc to i2c.
>
> drivers/i2c/busses/i2c-cpm.c |    1 -
> 1 file changed, 1 deletion(-)

applied

- k

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

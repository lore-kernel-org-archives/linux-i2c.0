From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 6/6] Blackfin I2C TWI driver: ADSP-BF52x arch/mach
 support
Date: Mon, 24 Mar 2008 22:33:10 +0100
Message-ID: <20080324223310.7e3df49b@hyperion.delvare>
References: <1205479360-25240-7-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1205479360-25240-7-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 14 Mar 2008 00:22:40 -0700, Bryan Wu wrote:
> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 476b0bb..a1351ce 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -100,10 +100,10 @@ config I2C_AU1550
>  
>  config I2C_BLACKFIN_TWI
>  	tristate "Blackfin TWI I2C support"
> -	depends on BF534 || BF536 || BF537 || BF54x
> +	depends on BF534 || BF536 || BF537 || BF54x || BF522 || BF525 || BF527
>  	help
> -	  This is the TWI I2C device driver for Blackfin 534/536/537/54x.
> -	  This driver can also be built as a module.  If so, the module
> +	  This is the TWI I2C device driver for Blackfin 522/525/527/534/536/537/54x.
> +	  This driver can also be built as a module. If so, the module
>  	  will be called i2c-bfin-twi.

Now that the i2c-bfin-twi driver no longer requires special defines in
the arch/mach header files, wouldn't it be more simple to just make it
depend on BLACKFIN? Otherwise we'll have to update the "depends on"
statement over and over again with every new machine.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

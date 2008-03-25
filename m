From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-ibm_iic fast mode parm desc fixup.
Date: Tue, 25 Mar 2008 14:16:53 +0100
Message-ID: <20080325141653.5ce67d6a@hyperion.delvare>
References: <20080325063529.GB29012@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080325063529.GB29012-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Paul,

On Tue, 25 Mar 2008 15:35:29 +0900, Paul Mundt wrote:
> Noticed this when grepping for fast mode module params, the i2c-ibm_iic
> driver was using a non-existent variable for MODULE_PARM_DESC. Fix it up
> to reflect what it's actually supposed to be describing.
> 
> Signed-off-by: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
> 
> ---
> 
>  drivers/i2c/busses/i2c-ibm_iic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index 7c7eb0c..22bb247 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -55,7 +55,7 @@ MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
>  
>  static int iic_force_fast;
>  module_param(iic_force_fast, bool, 0);
> -MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
> +MODULE_PARM_DESC(iic_force_fast, "Force fast mode (400 kHz)");
>  
>  #define DBG_LEVEL 0
>  

Good catch. Patch applied, thank you. It seems that it has been broken
pretty much forever. I thought that building would fail in this case,
but it seems not.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

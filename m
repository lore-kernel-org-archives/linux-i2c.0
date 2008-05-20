From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-pca-platform: Fix errorcode
Date: Tue, 20 May 2008 20:42:30 +0200
Message-ID: <20080520204230.6b48a0dc@hyperion.delvare>
References: <20080520171854.10908.95737.stgit@octopus.labnet.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080520171854.10908.95737.stgit-WosDo8ZsKtpoC+DoxizDebTfikLOBL9CDsAVuJBuCrE@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 20 May 2008 19:18:54 +0200, Wolfram Sang wrote:
> Fix errorcode to be more descriptive when ioremap fails.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-pca-platform.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
> index 9d75f51..6bb15ad 100644
> --- a/drivers/i2c/busses/i2c-pca-platform.c
> +++ b/drivers/i2c/busses/i2c-pca-platform.c
> @@ -163,7 +163,7 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
>  
>  	i2c->reg_base = ioremap(res->start, res_len(res));
>  	if (!i2c->reg_base) {
> -		ret = -EIO;
> +		ret = -ENOMEM;
>  		goto e_remap;
>  	}
>  	i2c->io_base = res->start;

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

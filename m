From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-pca-algo: Fix errorcode
Date: Tue, 20 May 2008 20:17:55 +0200
Message-ID: <20080520201755.59b140f5@hyperion.delvare>
References: <20080520171848.10908.23451.stgit@octopus.labnet.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080520171848.10908.23451.stgit-WosDo8ZsKtpoC+DoxizDebTfikLOBL9CDsAVuJBuCrE@public.gmane.org>
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

Hi Wolfram,

On Tue, 20 May 2008 19:18:49 +0200, Wolfram Sang wrote:
> Give a more concrete error code, when the bus is not idle.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
>  drivers/i2c/algos/i2c-algo-pca.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
> index e954a20..8001d6d 100644
> --- a/drivers/i2c/algos/i2c-algo-pca.c
> +++ b/drivers/i2c/algos/i2c-algo-pca.c
> @@ -182,7 +182,7 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
>  	}
>  	if (state != 0xf8) {
>  		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
> -		return -EIO;
> +		return -EBUSY;
>  	}
>  
>  	DEB1("{{{ XFER %d messages\n", num);

EBUSY is a fatal error, while a you should be able to retry the
transaction later when the bus is free. So I think that EAGAIN would be
more appropriate.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

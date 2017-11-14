From: jacopo mondi <jacopo@jmondi.org>
Subject: Re: [RFT] i2c: sh_mobile: avoid unnecessary register read
Date: Tue, 14 Nov 2017 10:10:47 +0100
Message-ID: <20171114091047.GG19070@w540>
References: <20171109222053.27093-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171109222053.27093-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Nov 09, 2017 at 11:20:53PM +0100, Wolfram Sang wrote:
> There is no data when the first WAIT interrupt arrives. No need to read
> something then.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> I am not super happy with (real pos >= 0) done twice, but I didn't find a
> better solution yet. The compiler will make this cheap anyhow, I guess.
>
> Jacopo: can you please test this on top of all other patches?

No regressions on Migo-R during image capture.

Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
   j

>
>  drivers/i2c/busses/i2c-sh_mobile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 80561ffbcf7b46..40a66d466c3c49 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -433,8 +433,9 @@ static int sh_mobile_i2c_isr_rx(struct sh_mobile_i2c_data *pd)
>  				break;
>  			}
>  			data = i2c_op(pd, OP_RX_STOP_DATA, 0);
> -		} else
> +		} else if (real_pos >= 0) {
>  			data = i2c_op(pd, OP_RX, 0);
> +		}
>
>  		if (real_pos >= 0)
>  			pd->msg->buf[real_pos] = data;
> --
> 2.11.0
>

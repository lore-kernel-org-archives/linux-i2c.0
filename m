From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH][next] i2c: xiic: fix indentation issue
Date: Mon, 27 Jan 2020 08:43:40 +0100
Message-ID: <e20558ec-bf4e-9348-f6cb-a37c5dbbb2de@xilinx.com>
References: <20200126154257.41336-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200126154257.41336-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 26. 01. 20 16:42, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a statment that is indented one level too deeply, remove

typo             ^

> the extraneous tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/i2c/busses/i2c-xiic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index b17d30c9ab40..90c1c362394d 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -261,7 +261,7 @@ static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
>  		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
>  		if (time_after(jiffies, timeout)) {
>  			dev_err(i2c->dev, "Failed to clear rx fifo\n");
> -				return -ETIMEDOUT;
> +			return -ETIMEDOUT;
>  		}
>  	}

When fixed.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

From: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/7 v3] i2c-eg20t: delete 10bit access processing
Date: Thu, 06 Oct 2011 16:00:22 +0900
Message-ID: <4E8D5206.4080608@dsn.lapis-semi.com>
References: <1317884192-10694-1-git-send-email-tomoya-linux@dsn.lapis-semi.com> <1317884192-10694-4-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1317884192-10694-4-git-send-email-tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(2011/10/06 15:56), Tomoya MORINAGA wrote:

Previous [PATCH 3/7] is duplicated like below.
  [PATCH 3/7 v3] i2c-eg20t: delete 10bit access processing
  [PATCH 3/7 v1] i2c-eg20t: Fix 10bit access issue

Please ignore "[PATCH 3/7 v3] i2c-eg20t: delete 10bit access processing"
Sorry for the in inconvenience.

-- 
tomoya
ROHM Co., Ltd.

> From: Tomoya MORINAGA<tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
> 
> Linux I2C core doesn't support 10bit access formally.
> Additionally, we can't test with 10bit mode.
> This patch deletes the 10bit access processing.
> 
> Signed-off-by: Tomoya MORINAGA<tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-eg20t.c |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index c5b9924..aa1705e 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -410,7 +410,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
>   	}
> 
>   	if (msgs->flags&  I2C_M_TEN) {
> -		addr_2_msb = ((addr&  I2C_MSB_2B_MSK)>>  7);
> +		addr_2_msb = ((addr&  I2C_MSB_2B_MSK)>>  7)&  0x06;
>   		iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2CDR);
>   		if (first)
>   			pch_i2c_start(adap);
> @@ -515,7 +515,6 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
>   	if (msgs->flags&  I2C_M_TEN) {
>   		addr_2_msb = (((addr&  I2C_MSB_2B_MSK)>>  7) | (I2C_RD));
>   		iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2CDR);
> -
>   	} else {
>   		/* 7 address bits + R/W bit */
>   		addr = (((addr)<<  1) | (I2C_RD));

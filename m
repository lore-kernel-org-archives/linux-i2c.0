From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
Date: Thu, 21 Aug 2014 22:04:31 +0400
Message-ID: <53F634AF.1010303@cogentembedded.com>
References: <1408643457-7126-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408643457-7126-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>, wsa@the-dreams.de, max.schwarz@online.de, heiko@sntech.de, olof@lixom.net, dianders@chromium.org
Cc: huangtao@rock-chips.com, hl@rock-chips.com, yzq@rock-chips.com, zyw@rock-chips.com, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org, xjq@rock-chips.com, linux-i2c@vger.kernel.org, caesar.wang@rock-chips.com, cf@rock-chips.com, hj@rock-chips.com, zhengsq@rock-chips.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 08/21/2014 09:50 PM, Addy Ke wrote:

> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one transaction, so the size of data to be write/read to/from
> TXDATAx/RXDATAx must be less than or equal 32 bytes at a time.

> Test on pinky board, elan receive 158 bytes data.

> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>   drivers/i2c/busses/i2c-rk3x.c | 3 +++
>   1 file changed, 3 insertions(+)

> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 69e1185..dc0aa64 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -323,6 +323,9 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
>   	/* ack interrupt */
>   	i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
>
> +	/* Can only handle a maximum of 32 bytes at a time */
> +	len = (len > 32) ? 32 : len;

    Why not min(len, 32)? Or even:

	if (len > 32)
		len = 32;

WBR, Sergei

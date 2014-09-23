From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: detect No Slave Ack on SELECT in PIO mode
Date: Tue, 23 Sep 2014 12:48:40 +0200
Message-ID: <54215008.80705@elproma.com.pl>
References: <1411469306-15390-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411469306-15390-1-git-send-email-j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marex-ynQEQJNshbs@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The patch is sent.

W dniu 2014-09-23 12:48, Janusz Uzycki pisze:
> i2cdetect scanned i2c bus slow because the i2c-mxs driver ignored
> the NO_SLAVE_ACK bit during busy-waiting loop.
> Thanks to the patch, the speedup happens.
> The change doesn't break anything else because:
> - on SELECT: NO_SLAVE_ACK bit checking is just welcome
> - on READ: master (the i2c controller, no slave device) generates
>     ACK/NAK bit
> - on WRITE: NO_SLAVE_ACK can be treated as NAK (the same effect)
>     so even the i2c controller sets NO_SLAVE_ACK on NAK (not confirmed)
>     the WRITE is not effected
typo: affected

best regards
Janusz Uzycki

> - on clock stretching: SCL wire is involved, it has no influence
>     on the ACK bit value on SDA wire
>
> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-mxs.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 87ee72d..f3c4a43 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -307,6 +307,9 @@ static int mxs_i2c_pio_wait_xfer_end(struct mxs_i2c_dev *i2c)
>   	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
>   
>   	while (readl(i2c->regs + MXS_I2C_CTRL0) & MXS_I2C_CTRL0_RUN) {
> +		if (readl(i2c->regs + MXS_I2C_CTRL1) &
> +				MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ)
> +			return -ENXIO;
>   		if (time_after(jiffies, timeout))
>   			return -ETIMEDOUT;
>   		cond_resched();

From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH v2 3/8] i2c: bcm2835: Use ratelimited logging on transfer errors
Date: Tue, 27 Sep 2016 15:01:54 +0200
Message-ID: <74D9ED33-1B99-4ED6-88B5-879950D160C8@martin.sperl.org>
References: <1474977426-3272-1-git-send-email-noralf@tronnes.org> <1474977426-3272-4-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:47056
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbcI0NCB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Sep 2016 09:02:01 -0400
In-Reply-To: <1474977426-3272-4-git-send-email-noralf@tronnes.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org


> On 27 Sep 2016, at 13:57, Noralf Trønnes <noralf@tronnes.org> wrote:
> 
> Writing to an AT24C32 generates on average 2x i2c transfer errors per
> 32-byte page write. Which amounts to a lot for a 4k write. This is due
> to the fact that the chip doesn't respond during it's internal write
> cycle when the at24 driver tries and retries the next write.
> Reduce this flooding of the log by using dev_err_ratelimited().
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
> drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index df036ed..370a322 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -207,7 +207,8 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
>        (msg->flags & I2C_M_IGNORE_NAK))
>        return 0;
> 
> -    dev_err(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);
> +    dev_err_ratelimited(i2c_dev->dev, "i2c transfer failed: %x\n",
> +                i2c_dev->msg_err);
Do we really need this error message at all?

Maybe just remove it instead, because error messages during 
"normal"/successfull operations of at24 seems  strange.

Or make it a debug message instead.

Martin

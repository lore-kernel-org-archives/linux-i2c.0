From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 1/3] i2c: Revert "i2c: xiic: Do not reset controller
 before every transfer"
Date: Tue, 17 Nov 2015 10:47:24 +0530
Message-ID: <CAKfKVtGqPPP=bnWH4dPLT1=gjrvZe=0zmix58SKBT79MsR+CXg@mail.gmail.com>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34289 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbKQFRY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Nov 2015 00:17:24 -0500
Received: by qgeb1 with SMTP id b1so65481500qge.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2015 21:17:24 -0800 (PST)
In-Reply-To: <1447681325-30914-1-git-send-email-lars@metafoo.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org

On Mon, Nov 16, 2015 at 7:12 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Commit d701667bb331 ("i2c: xiic: Do not reset controller before every
> transfer") removed the reinitialization of the controller before the start
> of each transfer. Apparently this change is not safe to make and the commit
> results in random I2C bus failures.

Which is the platform and the ip version that you  saw the issue.
Did you see the issue with read and write as  well?
.

>
> An easy way to trigger the issue is to run i2cdetect.
>
> Without the patch applied:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>          00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>          10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          30: -- -- -- -- -- -- -- -- UU UU -- UU 3c -- -- UU
>          40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          70: -- -- -- -- -- -- -- --
>
> With the patch applied every other or so invocation:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>          00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
>          10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
>          20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
>          30: -- -- -- -- -- -- -- -- UU UU -- UU 3c -- -- UU
>          40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>          70: -- -- -- -- -- -- -- --
>
I assume that you have these many peripherals.
on the bus am I right?


> So revert the commit for now.
>
> Fixes: d701667bb331 ("i2c: xiic: Do not reset controller before every transfer")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/i2c/busses/i2c-xiic.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index e23a7b0..705cf69 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -662,6 +662,9 @@ static void __xiic_start_xfer(struct xiic_i2c *i2c)
>
>  static void xiic_start_xfer(struct xiic_i2c *i2c)
>  {
> +       spin_lock(&i2c->lock);
> +       xiic_reinit(i2c);
> +       spin_unlock(&i2c->lock);
>
>         __xiic_start_xfer(i2c);
>  }
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

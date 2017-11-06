From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFT 3/5] i2c: sh_mobile: manually "inline" two short functions
Date: Mon, 6 Nov 2017 09:35:53 +0100
Message-ID: <CAMuHMdXoSyauV1ikYzVBq85Qwm=iPBWvEWNCwd-JNUt32NYUOw@mail.gmail.com>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com> <20171102124731.10484-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:56734 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdKFIfy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Nov 2017 03:35:54 -0500
In-Reply-To: <20171102124731.10484-4-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>

Hi Wolfram,

On Thu, Nov 2, 2017 at 1:47 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Those two functions are very short and only called once. The code
> becomes easier to understand if the code is directly put into the main
> xfer function.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-sh_mobile.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index a1253df9574594..cdd7a746b9d1ed 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -298,23 +298,6 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
>         return 0;
>  }
>
> -static void activate_ch(struct sh_mobile_i2c_data *pd)
> -{
> -       /* Wake up device and enable clock */
> -       pm_runtime_get_sync(pd->dev);
> -       clk_prepare_enable(pd->clk);
> -}
> -
> -static void deactivate_ch(struct sh_mobile_i2c_data *pd)
> -{
> -       /* Disable channel */
> -       iic_set_clr(pd, ICCR, 0, ICCR_ICE);
> -
> -       /* Disable clock and mark device as idle */
> -       clk_disable_unprepare(pd->clk);
> -       pm_runtime_put_sync(pd->dev);
> -}
> -
>  static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
>                             enum sh_mobile_i2c_op op, unsigned char data)
>  {
> @@ -717,7 +700,9 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
>         int i;
>         long timeout;
>
> -       activate_ch(pd);
> +       /* Wake up device and enable clock */
> +       pm_runtime_get_sync(pd->dev);
> +       clk_prepare_enable(pd->clk);

Suggestion for further cleanup: the call to clk_prepare_enable() should
not be needed, due to Runtime PM taking care of that.
This is also the case on SH, which uses the legacy clock domain
(drivers/sh/pm_runtime.c).

>
>         /* Process all messages */
>         for (i = 0; i < num; i++) {
> @@ -754,7 +739,12 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
>                         break;
>         }
>
> -       deactivate_ch(pd);
> +       /* Disable channel */
> +       iic_set_clr(pd, ICCR, 0, ICCR_ICE);
> +
> +       /* Disable clock and mark device as idle */
> +       clk_disable_unprepare(pd->clk);

Likewise for clk_disable_unprepare().

> +       pm_runtime_put_sync(pd->dev);

Gr{oetje,eeting}s,

                        Geert

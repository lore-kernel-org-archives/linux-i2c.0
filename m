From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] i2c: synquacer: fix fall-through annotation
Date: Fri, 14 Sep 2018 08:07:20 +0200
Message-ID: <CAKv+Gu_ny+CZ+SRT2bN2UdrxVchxeSdd999Eqy91fwJEG=MEmg@mail.gmail.com>
References: <20180913185913.GA8471@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913185913.GA8471@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 13 September 2018 at 20:59, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Replace "fallthru" with a proper "fall through" annotation.
>
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/i2c/busses/i2c-synquacer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
> index 915f5ed..2184b7c 100644
> --- a/drivers/i2c/busses/i2c-synquacer.c
> +++ b/drivers/i2c/busses/i2c-synquacer.c
> @@ -404,7 +404,7 @@ static irqreturn_t synquacer_i2c_isr(int irq, void *dev_id)
>                 if (i2c->state == STATE_READ)
>                         goto prepare_read;
>
> -               /* fallthru */
> +               /* fall through */
>
>         case STATE_WRITE:
>                 if (bsr & SYNQUACER_I2C_BSR_LRB) {
> --
> 2.7.4
>

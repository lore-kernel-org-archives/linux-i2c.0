From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 1/2] i2c: bcm-iproc: constify i2c_adapter_quirks
 structures
Date: Mon, 17 Oct 2016 10:49:10 -0700
Message-ID: <cb5bd61e-6dd6-1c39-ed0e-10a38dfa3e5e@broadcom.com>
References: <1476552722-12352-1-git-send-email-Julia.Lawall@lip6.fr>
 <1476552722-12352-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1476552722-12352-2-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Wolfram Sang <wsa@the-dreams.de>
Cc: kernel-janitors@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Julia,

On 10/15/2016 10:32 AM, Julia Lawall wrote:
> Check for i2c_adapter_quirks structures that are only stored in the
> quirks field of an i2c_adapter structure.  This field is declared
> const, so i2c_adapter_quirks structures that have this property can be
> declared as const also.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct i2c_adapter_quirks i@p = { ... };
>
> @ok@
> identifier r.i;
> struct i2c_adapter e;
> position p;
> @@
> e.quirks = &i@p;
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct i2c_adapter_quirks e;
> @@
> e@i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct i2c_adapter_quirks i = { ... };
> // </smpl>
>
> The effect on the layout of the .o file is shown by the following
> output of the size command, first before then after the
> transformation:
>
>    text    data     bss     dec     hex filename
>    3458     744       8    4210    1072 drivers/i2c/busses/i2c-bcm-iproc.o
>    3490     720       8    4218    107a drivers/i2c/busses/i2c-bcm-iproc.o
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 326b3db..318df55 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -395,7 +395,7 @@ static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
>  	.functionality = bcm_iproc_i2c_functionality,
>  };
>
> -static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> +static const struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
>  	/* need to reserve one byte in the FIFO for the slave address */
>  	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
>  };
>

Change looks good. Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>

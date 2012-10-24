From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] i2c: at91: add a sanity check on i2c message length
Date: Wed, 24 Oct 2012 16:34:13 +0200
Message-ID: <5087FC65.30904@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: ludovic.desroches@atmel.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Le 10/10/2012 04:25 PM, ludovic.desroches@atmel.com a =E9crit :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> If the i2c message length is zero, i2c-at91 will directly return an error
> instead of trying to send a zero-length message.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>
> fix for 3.7
>
>   drivers/i2c/busses/i2c-at91.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index aa59a25..eaddc77 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -263,6 +263,9 @@ static int at91_twi_xfer(struct i2c_adapter *adap, st=
ruct i2c_msg *msg, int num)
>   	unsigned int_addr_flag =3D 0;
>   	struct i2c_msg *m_start =3D msg;
>
> +	if (!msg->len)
> +		return -EINVAL;
> +
>   	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
>
>   	/*
>

Could you take this fix for 3.7?

Thanks

Regards

Ludovic

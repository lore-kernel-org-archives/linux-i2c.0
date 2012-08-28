From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 28 Aug 2012 17:10:00 +0200
Message-ID: <503CDF48.5080201@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nikolaus Voss <n.voss@weinmann.de>
Cc: rmallon@gmail.com, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, balbi@ti.com, h.feurstein@gmail.com, ludovic.desroches@atmel.com, linux-i2c@vger.kernel.org, ben-linux@fluff.org, adrian.yanes@aalto.fi, linux-arm-kernel@lists.infradead.org, carsten.behling@garz-fricke.com
List-Id: linux-i2c@vger.kernel.org

Hi Nikolaus,

I forgot one correction I did in your patch:

Le 11/08/2011 11:49 AM, Nikolaus Voss a =E9crit :
[...]

> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at9=
1/at91sam9261_devices.c
> index 9295e90..27fddc1 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -283,9 +283,18 @@ static struct i2c_gpio_platform_data pdata =3D {
>   	.udelay			=3D 2,		/* ~100 kHz */
>   };
>
> +static const struct platform_device_id twi_ip_type =3D {
> +	/*
> +	 * driver_data is 2 for SAM9261 compatible ip, see enum twi_ip_id in
> +	 * drivers/i2c/busses/i2c-at91.c
> +	 */
> +	.driver_data	=3D 2,
> +};
> +
>   static struct platform_device at91sam9261_twi_device =3D {
>   	.name			=3D "i2c-gpio",
>   	.id			=3D -1,
> +	.id_entry		=3D &twi_ip_type,
>   	.dev.platform_data	=3D &pdata,
>   };
>

[...]

You add the id_entry to the i2c-gpio device instead of at91_i2c device.

Regards

Ludovic

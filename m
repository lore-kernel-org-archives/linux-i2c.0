From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v7] Add ov772x driver
Date: Thu, 23 Oct 2008 21:28:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810232120010.9657@axis700.grange>
References: <uhc77mucm.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <uhc77mucm.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: khali@linux-fr.org, V4L <video4linux-list@redhat.com>, i2c@lm-sensors.org, mchehab@infradead.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 20 Oct 2008, Kuninori Morimoto wrote:

> This patch adds ov772x driver that use soc_camera framework.
> It was tested on SH Migo-r board.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> PATCH v6 -> v7
> fix ov772x_get/set_register return value.
> fix error message of I2C_FUNC_SMBUS_BYTE_DATA.
>  (error message become 2 line. because of 80 char)
> 
> # I always test with CONFIG_VIDEO_ADV_DEBUG=y.
> # but compiler didn't warn... I think.

[snip]

> +/* COM3 */
> +#define SWAP_MASK       (BIT_MASK(3) << 3)

Ohhoh... This equals 0x40. In v3 this used to be

#define SWAP_MASK       (B5|B4|B3)

i.e., 0x38. Is this a correction? And even if so, why such an "unusual" 
form "BIT_MASK(3) << 3"? Doesn't look good:-(

> +static unsigned long ov772x_query_bus_param(struct soc_camera_device *icd)
> +{
> +
> +	struct ov772x_priv *priv = container_of(icd, struct ov772x_priv, icd);
> +
> +	return  SOCAM_PCLK_SAMPLE_RISING |
> +		SOCAM_HSYNC_ACTIVE_HIGH  |
> +		SOCAM_VSYNC_ACTIVE_HIGH  |
> +		SOCAM_MASTER             |
> +		priv->info->buswidth;
> +}
> +
> +static int ov772x_get_chip_id(struct soc_camera_device *icd,
> +			      struct v4l2_chip_ident   *id)
> +{
> +
> +	id->ident    = V4L2_IDENT_OV772X;
> +	id->revision = 0;
> +
> +	return 0;
> +}

And if the above is indeed a mistake and there's going to be a v8, please, 
also remove these empty lines at the very beginning of the above two 
functions.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list

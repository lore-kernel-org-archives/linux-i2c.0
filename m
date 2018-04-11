From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] MAINTAINERS: I'll maintain Renesas R-Car I2C host drivers
Date: Wed, 11 Apr 2018 10:08:21 +0200
Message-ID: <20180411080821.gmq6g667k7ubdmst@verge.net.au>
References: <20180410141347.5014-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180410141347.5014-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

There seems to be some room to enhance the subject, but otherwise:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

On Tue, Apr 10, 2018 at 04:13:47PM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f7ccdcf76f7..3bb87e65889c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11897,6 +11897,12 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/adc/rcar_gyro_adc.c
>  
> +RENESAS R-CAR I2C DRIVERS
> +M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
> +S:	Supported
> +F:	drivers/i2c/busses/i2c-rcar.c
> +F:	drivers/i2c/busses/i2c-sh_mobile.c
> +
>  RENESAS USB PHY DRIVER
>  M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>  L:	linux-renesas-soc@vger.kernel.org
> -- 
> 2.11.0
> 

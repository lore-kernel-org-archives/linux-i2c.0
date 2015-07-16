From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c-parport: Add VCT-jig adapter
Date: Thu, 16 Jul 2015 14:53:24 +0200
Message-ID: <20150716145324.2fcc32f5@endymion.delvare>
References: <1436808672-15503-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436808672-15503-1-git-send-email-linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 13 Jul 2015 19:31:12 +0200, Ondrej Zary wrote:
> Add support for VCT-jig parallel port I2C adapter to i2c-parport.
> 
> The adapter schematic can be found here (in the RAR file):
> http://remont-aud.net/shop/22/desc/vct-jig-komplekt-dlja-samostojatelnoj-sborki
> 
> Signed-off-by: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-parport |    1 +
>  drivers/i2c/busses/i2c-parport.h     |    8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/i2c/busses/i2c-parport b/Documentation/i2c/busses/i2c-parport
> index 0e2d17b..c3dbb3b 100644
> --- a/Documentation/i2c/busses/i2c-parport
> +++ b/Documentation/i2c/busses/i2c-parport
> @@ -20,6 +20,7 @@ It currently supports the following devices:
>   * (type=5) Analog Devices evaluation boards: ADM1025, ADM1030, ADM1031
>   * (type=6) Barco LPT->DVI (K5800236) adapter
>   * (type=7) One For All JP1 parallel port adapter
> + * (type=8) VCT-jig
>  
>  These devices use different pinout configurations, so you have to tell
>  the driver what you have, using the type module parameter. There is no
> diff --git a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-parport.h
> index 4e12945..84a6616 100644
> --- a/drivers/i2c/busses/i2c-parport.h
> +++ b/drivers/i2c/busses/i2c-parport.h
> @@ -89,6 +89,13 @@ static const struct adapter_parm adapter_parm[] = {
>  		.getsda	= { 0x80, PORT_STAT, 1 },
>  		.init	= { 0x04, PORT_DATA, 1 },
>  	},
> +	/* type 8: VCT-jig */
> +	{
> +		.setsda	= { 0x04, PORT_DATA, 1 },
> +		.setscl	= { 0x01, PORT_DATA, 1 },
> +		.getsda	= { 0x40, PORT_STAT, 0 },
> +		.getscl	= { 0x80, PORT_STAT, 1 },
> +	},
>  };
>  
>  static int type = -1;
> @@ -103,4 +110,5 @@ MODULE_PARM_DESC(type,
>  	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
>  	" 6 = Barco LPT->DVI (K5800236) adapter\n"
>  	" 7 = One For All JP1 parallel port adapter\n"
> +	" 8 = VCT-jig\n"
>  );

Looks good.

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

-- 
Jean Delvare
SUSE L3 Support

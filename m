From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] drivers: misc: eeprom: at24: support reading mac
 eeprom from different addresses
Date: Fri, 30 Jun 2017 09:20:32 +0200
Message-ID: <20170630072032.tbnatpnh3rej4lmf@pengutronix.de>
References: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com>
 <1498736351-9021-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498736351-9021-3-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hallo,

On Thu, Jun 29, 2017 at 02:39:10PM +0300, Claudiu Beznea wrote:
> diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
> index 271a4e2..d55c454 100644
> --- a/include/linux/platform_data/at24.h
> +++ b/include/linux/platform_data/at24.h
> @@ -50,6 +50,7 @@ struct at24_platform_data {
>  #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
>  #define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
>  #define AT24_FLAG_MAC		BIT(2)	/* factory-programmed mac address */
> +	u8		offset;

Assuming you rename the property, please adapt the member name here
accordingly.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

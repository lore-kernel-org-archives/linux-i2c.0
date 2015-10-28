From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v4 4/4] iio: humidity: si7020: added No Hold read mode
Date: Wed, 28 Oct 2015 10:38:05 +0100
Message-ID: <5630977D.2020102@metafoo.de>
References: <f113de76b2369d404909cfc5158feca4@rainloop.corna.info> <1446015506-21371-1-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446015506-21371-1-git-send-email-nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/28/2015 07:58 AM, Nicola Corna wrote:
[...]
> +			holdmode = !((*client)->adapter->quirks &&
> +					(*client)->adapter->quirks->flags &
[...]
> +		   client->adapter->quirks &&
> +		   client->adapter->quirks->flags & I2C_AQ_NO_CLK_STRETCH)

This is rather ugly, can we get a helper in the I2C core something along the
lines of

i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH)

- Lars

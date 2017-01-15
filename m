From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] iio: distance: srf08: add IIO driver for us ranger
Date: Sun, 15 Jan 2017 13:24:49 +0100
Message-ID: <54ad8bc2-905b-2481-1b42-539746f884cd@metafoo.de>
References: <20170110184815.GA15532@andreas>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170110184815.GA15532@andreas>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/10/2017 07:48 PM, Andreas Klinger wrote:
[...]
> +	indio_dev->name = dev_name(&client->dev);

The name is supposed to be the type of the device, e.g. part name, not the
name of parent device instance. E.g. "srf08" in this case.

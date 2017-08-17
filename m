From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/5] iio: srf08: add device tree binding for srf02 and
 srf10
Date: Thu, 17 Aug 2017 17:17:58 -0500
Message-ID: <20170817221758.qjxdqgznq4enj6yl@rob-hp-laptop>
References: <20170816193323.GA24405@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170816193323.GA24405@arbeit>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 16, 2017 at 09:33:23PM +0200, Andreas Klinger wrote:
> add trivial device tree binding "devantech,srf02" and "devantech,srf10"
> 
> Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>  1 file changed, 2 insertions(+)

I thought this was mentioned in the prior versions, but this file has 
moved. Rebase to 4.13. Please send trivial-devices.txt changes 
separately to me.

Rob

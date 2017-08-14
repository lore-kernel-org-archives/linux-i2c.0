From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: Re: [PATCH v2 1/5] iio: srf08: add device tree binding for srf02 and
 srf10
Date: Mon, 14 Aug 2017 12:39:18 +0200
Message-ID: <20170814103918.GB3062@imap.1und1.de>
References: <20170814085941.GA9759@arbeit>
 <20170814091106.rvdvebcxfbpggmjd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170814091106.rvdvebcxfbpggmjd@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> schrieb am Mon, 14. Aug 11:11:
> On Mon, Aug 14, 2017 at 10:59:41AM +0200, Andreas Klinger wrote:
> > add trivial device tree binding "devantech,srf02" and "devantech,srf10"
> > 
> > Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
> 
> Again: This file has moved since v4.12-rc1. Please rebase to v4.12 or
> even v4.13-rc5.
> 

Then i split the patch series up in two parts:
- patch with only device tree binding against >= v4.12
- everything else as patch series against git tree of IIO

Ok?

Andreas

-- 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

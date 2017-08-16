From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v3 0/5] iio: srf08: add support for similar devices and
 triggered buffers
Date: Wed, 16 Aug 2017 22:14:33 +0200
Message-ID: <823ea9d0-0410-2d6d-813b-686582656d68@axentia.se>
References: <20170816193257.GA24393@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170816193257.GA24393@arbeit>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-08-16 21:32, Andreas Klinger wrote:
> This patch series adds support for:
> - triggered buffer
> - ultrasonic devices srf02 and srf10
> 
> Thanks for the review of Peter and Wolfram.
> 
> @Wolfram: please let me know, if you want a separate patch for [PATCH 1/5]

I think what you should do is rebase to something fresher, such as the
togreg branch in the iio repo. As you have discovered, master branch is
lagging behind in that repo.

And I think Jonathan would like that as well, but perhaps it doesn't
make a difference for him?

Cheers,
peda

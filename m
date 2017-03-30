From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v12 00/10] mux controller abstraction and iio/i2c muxes
Date: Thu, 30 Mar 2017 09:34:52 +0200
Message-ID: <c321dad0-4c0e-b192-ee93-45359e29f61b@axentia.se>
References: <1490624525-15865-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490624525-15865-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-03-27 16:21, Peter Rosin wrote:
> Hi Greg!
> 
> Please apply.
>

*snip snip*

> v10 -> v11 changes
> - added a new patch (12) with a fix for messed up error path reported
>   by Paul Gortmaker.

Oops, should be Dan Carpenter. Sorry about that...

And, I forgot to high-light this:

> v4 -> v5 changes
> - driver for Analog Devices ADG792A/G, literally the first mux chip
>   I found on the Internet with an i2c interface (that was not a
>   dedicated i2c multiplexer like PCA9547) which I used to verify
>   that the abstractions in the mux core are up to the task. Untested,
>   just proof of concept that at least looks pretty and compiles...

Maybe the patches related to adg792 (last two patches in v12) should
not be applied? I don't care much either way, your call Greg...

Cheers,
peda

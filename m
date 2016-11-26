From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v4 0/7] mux controller abstraction and iio/i2c muxes
Date: Sat, 26 Nov 2016 19:38:09 +0100
Message-ID: <8e4c6895-c06f-3412-26ea-dfb02d52d328@axentia.se>
References: <1480000687-5630-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480000687-5630-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2016-11-24 16:18, Peter Rosin wrote:
> v3 -> v4 changes
> - added support for having the mux-controller in a child node of a
>   mux-consumer if it is a sole consumer, to hopefully even further satisfy
>   the complaint from Rob (and later Lars-Peter) about dt complexity.
> - the above came at the cost of some rather horrible refcounting code,
>   please review and suggest how it should be done...
> 
> v2 -> v3 changes
> - have the mux-controller in the parent node of any mux-controller consumer,
>   to hopefully satisfy complaint from Rob about dt complexity.

I did some further tests and both of these attempts to support fancier
devicetree bindings have severe problems. I will remove them for v5 and
go back to having a phandle reference to the mux-controller from the
consumer (unless I get some revelation of course and just get it). I'm
simply not yet understanding the driver model well enough to pull this
off at the moment...

Cheers,
Peter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

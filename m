From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
Date: Tue, 18 Apr 2017 19:23:11 -0700
Message-ID: <1492568591.8661.53.camel@perches.com>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
         <1492101794-13444-4-git-send-email-peda@axentia.se>
         <20170418085156.GA4773@kroah.com>
         <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
         <20170418114430.GA1496@kroah.com>
         <aacdc359-e46d-7d1a-d959-63d4ecb99fde@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aacdc359-e46d-7d1a-d959-63d4ecb99fde-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2017-04-18 at 23:53 +0200, Peter Rosin wrote:
> On 2017-04-18 13:44, Greg Kroah-Hartman wrote:
> > On Tue, Apr 18, 2017 at 12:59:50PM +0200, Peter Rosin wrote:
[]
> > > > > +	ret = device_add(&mux_chip->dev);
> > > > > +	if (ret < 0)
> > > > > +		dev_err(&mux_chip->dev,
> > > > > +			"device_add failed in mux_chip_register: %d\n", ret);
> > > > 
> > > > Did you run checkpatch.pl in strict mode on this new file?  Please do so :)
> > > 
> > > I did, and did it again just to be sure, and I do not get any complaints.
> > > So, what's wrong?
> > 
> > You list the function name in the printk string, it should complain
> > that __func__ should be used.  Oh well, it's just a perl script, it
> > doesn't always catch everything.
> > isn't always correct :)
> 
> Ah, ok.

Also, please use the checkpatch in -next as it has a
slightly better mechanism to identify functions and
uses in strings.

$ ./scripts/checkpatch.pl ~/1.patch
WARNING: Prefer using '"%s...", __func__' to using 'mux_chip_register', this function's name, in a string
#302: FILE: drivers/mux/mux-core.c:134:
+			"device_add failed in mux_chip_register: %d\n", ret);

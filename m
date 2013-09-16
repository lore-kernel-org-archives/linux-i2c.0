From: Graeme Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
Date: Mon, 16 Sep 2013 15:46:16 +0100
Message-ID: <20130916144616.GM1823@xora-yoga.xora.org.uk>
References: <20130913065434.GZ7393@intel.com>
 <87bo3whjz4.fsf@linaro.org>
 <20130913145022.GC7393@intel.com>
 <20130913173149.GE7393@intel.com>
 <87ioy4e8bw.fsf@linaro.org>
 <20130915064139.GJ7393@intel.com>
 <20130915124744.GW29403@sirena.org.uk>
 <20130915132823.GL7393@intel.com>
 <20130916101249.GX29403@sirena.org.uk>
 <20130916143811.GP7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130916143811.GP7393-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 16, 2013 at 05:38:12PM +0300, Mika Westerberg wrote:
> On Mon, Sep 16, 2013 at 11:12:49AM +0100, Mark Brown wrote:
> > That's definitely an ACPI specific (probably x86 specific ACPI?)
> > requirement not a generic one, on some systems it would increase power
> > consumption since the controller will need to sit on while the device is
> > functioning autonomously.
> 
> Yes, the ACPI 5.0 spec says that the device cannot be in higher D-state
> than its parent. This is not x86 specific, though I'm not sure if this is
> implemented elsewhere.
> 
I do not think this stops the OS fine controlling the power of the device
though. It is only a mechanism to make sure the tree of D states is vaguely
sane from the ACPI point of view. What happens in each D state is never
actually defined in the ACPI spec.

Graeme

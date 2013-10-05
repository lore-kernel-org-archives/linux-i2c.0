From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4] i2c: enable runtime PM for I2C adapter devices
 enumerated from ACPI
Date: Sat, 5 Oct 2013 11:09:01 +0300
Message-ID: <20131005080901.GQ28875@intel.com>
References: <1380552228-23329-2-git-send-email-mika.westerberg@linux.intel.com>
 <1380632982-10709-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380632982-10709-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 01, 2013 at 04:09:42PM +0300, Mika Westerberg wrote:
> The ACPI specification requires the parent device to be powered on before
> any of its children. It can be only powered off when all the children are
> already off.
> 
> Currently whenever there is no I2C traffic going on, the I2C controller
> driver can put the device into low power state transparently to its
> children (the I2C client devices). This violates the ACPI specification
> because now the parent device is in lower power state than its children.
> 
> In order to keep ACPI happy we enable runtime PM for the I2C adapter device
> if we find out that the I2C controller was in fact an ACPI device. In
> addition to that we attach the I2C client devices to the ACPI power domain
> and make sure that they are powered on when the driver ->probe() is called.

It looks like Windows actually powers the I2C controller off independently
of the I2C client power state. We should probably do the same in Linux even
though it is not following what the ACPI spec says (but makes sense with
serial buses like I2C and SPI).

Wolfram, please don't apply this patch - we are going to do one more
iteration but this time we only attach devices to the ACPI power domain and
leave runtime PM alone.

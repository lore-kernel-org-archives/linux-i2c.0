From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v6] i2c-gpio: add devicetree support
Date: Thu, 24 Feb 2011 09:22:10 -0700
Message-ID: <20110224162210.GC17735@angua.secretlab.ca>
References: <20110223011232.GC15795@trinity.fluff.org>
 <1298520013-3630-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298520013-3630-1-git-send-email-thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 24, 2011 at 12:00:13PM +0800, Thomas Chou wrote:
> From: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
> 
> This patch adds devicetree support to i2c-gpio driver. The allocation
> of local data is integrated to a private structure, and use devm_*
> helper for easy cleanup.
> 
> It is base on an earlier patch for gc-linux from
> Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>.
> 
> Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
> CC: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
> Acked-by: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> new file mode 100644
> index 0000000..38ef4f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> @@ -0,0 +1,40 @@
> +GPIO-based I2C
> +
> +Required properties:
> +- compatible : should be "i2c-gpio".
> +- gpios : should specify GPIOs used for SDA and SCL lines, in that order.
> +Optional properties:
> +- sda-is-open-drain : present if SDA gpio is open-drain.
> +- scl-is-open-drain : present if SCL gpio is open-drain.
> +- scl-is-output-only : present if the output driver for SCL cannot be
> +	turned off. this will prevent clock stretching from working.
> +- speed-hz : SCL frequency.

Hi Thomas,

One nitpick; I just looked, and other i2c controllers are already
using 'clock-frequency' instead of 'speed-hz' for the speed of the
bus.  I'd like to see this patch use the same terminology.

Otherwise this looks good to me.

Thanks,
g.

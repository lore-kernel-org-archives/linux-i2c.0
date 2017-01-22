From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] iio: distance: srf08: add driver ABI documentation
Date: Sun, 22 Jan 2017 13:41:02 +0000
Message-ID: <2e87aeed-a611-e160-c245-f5b16f2ef304@kernel.org>
References: <20170117135006.GA22903@andreas>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117135006.GA22903@andreas>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 17/01/17 13:50, Andreas Klinger wrote:
> Add sysfs-bus-iio-distance-srf08 for individual attributes of the driver,
> especially:
>  - sensitivity which the device documentation calls gain for amplifying the
>    signal
>  - max_range for limiting the maximum distance for expected echos and
>    therefore limiting the time waiting for telegrams
> 
> Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
> ---
>  .../ABI/testing/sysfs-bus-iio-distance-srf08       | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> new file mode 100644
> index 000000000000..e96c28064748
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> @@ -0,0 +1,27 @@
> +What		/sys/bus/iio/devices/iio:deviceX/in_distance_raw
> +Date:		January 2017
> +KernelVersion:	4.11
> +Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +Description:
> +		Get the current distance in meters between the sensor and
> +		the first object recognized
Generally no need to document what are effectively standard elements.
Just leads to the possibility of disagreements in the docs! 
Still no harm here really.
> +
> +What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
> +Date:		January 2017
> +KernelVersion:	4.11
> +Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +Description:
> +		Show or set the gain boost of the amp, from 0-31 range.
> +		default 31
> +
> +What		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
> +Date:		January 2017
> +KernelVersion:	4.11
> +Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +Description:
> +		Show or set the maximum range between the sensor and the
> +		first object echoed in millimeters.
> +		This setting limits the time the driver is waiting for a
> +		echo.
> +		Can be set between 43 and 11008 in a grid of 43 mm.
> +		default 6020
This needs to be in the same units as the range - so m.
I'm not 100% sure this is the best ABI we can do for this. However, supporting
this as a legacy abi if we come up with something more general will be a very
small burden, so lets not stall the driver on this!

Jonathan
> 

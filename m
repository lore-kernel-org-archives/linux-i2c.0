From: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Date: Mon, 6 Sep 2010 13:47:18 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C2018464@dbde02.ent.ti.com>
References: <1283470837-18210-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283470837-18210-1-git-send-email-achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TbrhsbdSgBK9A@public.gmane.org
Cc: "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-iio-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Sent: Friday, September 03, 2010 5:11 AM
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org;
> Andrew Chew
> Subject: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
> 
> From: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> This is for the Asahi Kasei AK8975 3-axis magnetometer.  It resides within
> the magnetometer section of the IIO subsystem, and implements the raw
> magn_x,y,z attributes, as well as x,y,z factory calibration attributes.
> 
Could you help me with the datasheet details.
> Signed-off-by: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/staging/iio/magnetometer/Kconfig  |   11 +
>  drivers/staging/iio/magnetometer/Makefile |    1 +
>  drivers/staging/iio/magnetometer/ak8975.c |  521
> +++++++++++++++++++++++++++++
>  3 files changed, 533 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/magnetometer/ak8975.c
> 
> diff --git a/drivers/staging/iio/magnetometer/Kconfig
> b/drivers/staging/iio/magnetometer/Kconfig
> index d014450..00e1204 100644
> --- a/drivers/staging/iio/magnetometer/Kconfig
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -3,6 +3,17 @@
>  #
>  comment "Magnetometer sensors"
> 
> +config SENSORS_AK8975
> +	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
> +	default n
Default is anyways n however does no harm.
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
> +	  Magnetometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ak8975.
> +
>  config SENSORS_HMC5843
>  	tristate "Honeywell HMC5843 3-Axis Magnetometer"
>  	depends on I2C
> diff --git a/drivers/staging/iio/magnetometer/Makefile
> b/drivers/staging/iio/magnetometer/Makefile
> index f9bfb2e..e3dbaa4 100644
> --- a/drivers/staging/iio/magnetometer/Makefile
> +++ b/drivers/staging/iio/magnetometer/Makefile
> @@ -2,4 +2,5 @@
>  # Makefile for industrial I/O Magnetometer sensors
>  #
> 
> +obj-$(CONFIG_SENSORS_AK8975)	:= ak8975.o

Was the : intentional

>  obj-$(CONFIG_SENSORS_HMC5843)	+= hmc5843.o
> diff --git a/drivers/staging/iio/magnetometer/ak8975.c
> b/drivers/staging/iio/magnetometer/ak8975.c
> new file mode 100644
> index 0000000..ca39840
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/ak8975.c
> @@ -0,0 +1,521 @@
> +/*
> + * A sensor driver for the magnetometer AK8975.

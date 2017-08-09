From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] iio: srf08: add device tree binding for srf02 and
 srf10
Date: Thu, 10 Aug 2017 00:33:06 +0100
Message-ID: <20170810003306.651be1a1@archlinux>
References: <20170802232335.GA15222@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170802232335.GA15222@arbeit>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgRob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 3 Aug 2017 01:23:35 +0200
Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org> wrote:

> add trivial device tree binding "devantech,srf02" and "devantech,srf10"
> 
> Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Please remember to cc the device tree maintainers and list of bindings.
For trivial ones, sometimes it makes more sense for them to pick them
up directly as it reduces the chance of conflict on merges.

Acked-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index ad10fbe61562..0e5fb016e912 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -36,7 +36,9 @@ dallas,ds1775		Tiny Digital Thermometer and Thermostat
>  dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
>  dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
>  dallas,ds75		Digital Thermometer and Thermostat
> +devantech,srf02		Devantech SRF02 ultrasonic ranger in I2C mode
>  devantech,srf08		Devantech SRF08 ultrasonic ranger
> +devantech,srf10		Devantech SRF10 ultrasonic ranger
>  dlg,da9053		DA9053: flexible system level PMIC with multicore support
>  dlg,da9063		DA9063: system PMIC for quad-core application processors
>  domintech,dmard09	DMARD09: 3-axis Accelerometer

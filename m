From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/3] iio: distance: srf08: add trivial DT binding
Date: Sat, 28 Jan 2017 16:39:04 +0000
Message-ID: <f26e31b7-11ad-c902-65ae-2a0b4a5fabb5@kernel.org>
References: <20170125190648.GA9260@andreas>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170125190648.GA9260@andreas>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 25/01/17 19:06, Andreas Klinger wrote:
>  - Add DT binding for devantech,srf08
>  - Add vendor devantech to vendor list
> 
> Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Applied to the togreg branch of iio.git.  Will be first
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 539874490492..86c6930c3c91 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -36,6 +36,7 @@ dallas,ds1775		Tiny Digital Thermometer and Thermostat
>  dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
>  dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
>  dallas,ds75		Digital Thermometer and Thermostat
> +devantech,srf08		Devantech SRF08 ultrasonic ranger
>  dlg,da9053		DA9053: flexible system level PMIC with multicore support
>  dlg,da9063		DA9063: system PMIC for quad-core application processors
>  epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4696bb5c2198..80325e602403 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -65,6 +65,7 @@ dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
>  davicom	DAVICOM Semiconductor, Inc.
>  delta	Delta Electronics, Inc.
>  denx	Denx Software Engineering
> +devantech	Devantech, Ltd.
>  digi	Digi International Inc.
>  digilent	Diglent, Inc.
>  dlg	Dialog Semiconductor
> 

From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 07/12] dt-bindings: iio: iio-mux: document iio-mux
 bindings
Date: Sun, 8 Jan 2017 10:29:25 +0000
Message-ID: <7e3e79a6-12a5-d253-e855-a4de209e9513@kernel.org>
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-8-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483532187-28494-8-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/01/17 12:16, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../bindings/iio/multiplexer/io-channel-mux.txt    | 39 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> new file mode 100644
> index 000000000000..c82794002595
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> @@ -0,0 +1,39 @@
> +I/O channel multiplexer bindings
> +
> +If a multiplexer is used to select which hardware signal is fed to
> +e.g. an ADC channel, these bindings describe that situation.
> +
> +Required properties:
> +- compatible : "io-channel-mux"
> +- io-channels : Channel node of the parent channel that has multiplexed
> +		input.
> +- io-channel-names : Should be "parent".
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +- mux-controls : Mux controller node to use for operating the mux
> +- channels : List of strings, labeling the mux controller states.
> +
> +For each non-empty string in the channels property, an io-channel will
> +be created. The number of this io-channel is the same as the index into
> +the list of strings in the channels property, and also matches the mux
> +controller state. The mux controller state is described in
> +../mux/mux-controller.txt
> +
> +Example:
> +	mux: mux-controller {
> +		compatible = "mux-gpio";
> +		#mux-control-cells = <0>;
> +
> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	adc-mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc 0>;
> +		io-channel-names = "parent";
> +
> +		mux-controls = <&mux>;
> +
> +		channels = "sync", "in", "system-regulator";
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebe96f3e25a0..91775f2be209 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6274,6 +6274,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
>  F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
>  F:	drivers/iio/adc/envelope-detector.c
>  
> +IIO MULTIPLEXER
> +M:	Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> +L:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> +
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>  R:	Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: i2c: add support for 'i2c-gate'
 subnode
Date: Tue, 16 Aug 2016 08:57:51 -0500
Message-ID: <20160816135751.GA32704@rob-hp-laptop>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
 <1471268431-5148-4-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471268431-5148-4-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 15, 2016 at 03:40:26PM +0200, Peter Rosin wrote:
> Handle i2c gates similarly to how i2c arbitrators are handled.
> This gets rid of a pointless 'reg' property for i2c gates.
> 
> I.e. this new and more compact style
> 
>         some-gate {
>                 i2c-gate {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         some-i2c-device@50 {
>                                 reg = <0x50>;
>                         };
>                 };
>         };
> 
> instead of the old
> 
>         some-gate {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 i2c@0 {
>                         reg = <0>;
> 
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         some-i2c-device@50 {
>                                 reg = <0x50>;
>                         };
>                 };
>         };
> 
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-gate.txt | 41 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-gate.txt b/Documentation/devicetree/bindings/i2c/i2c-gate.txt
> new file mode 100644
> index 000000000000..0b057fb2a15a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-gate.txt
> @@ -0,0 +1,41 @@
> +An i2c gate is useful to e.g. reduce the digital noise for RF tuners connected
> +to the i2c bus. Gates are similar to arbitrators in that you need to perform
> +some kind of operation to access the i2c bus past the arbitrator/gate, but
> +there are no competing masters to consider for gates and therefore there is
> +no arbitration happening for gates.
> +
> +Common i2c gate properties.
> +
> +- i2c-gate child node
> +
> +Required properties for the i2c-gate child node:
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +
> +Optional properties for i2c-gate child node:
> +- Child nodes conforming to i2c bus binding
> +
> +
> +Example :
> +
> +	/*
> +	   An Invensense mpu9150 at address 0x68 featuring an on-chip Asahi
> +	   Kasei ak8975 compass behind a gate.
> +	 */
> +
> +	mpu9150@68 {
> +		compatible = "invensense,mpu9150";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <18 1>;
> +
> +		i2c-gate {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ax8975@0c {

Drop the leading 0. With that,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

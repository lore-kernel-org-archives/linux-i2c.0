From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Wed, 13 Feb 2013 10:45:59 -0800
Message-ID: <20130213184559.GA29145@quad.lixom.net>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360778532-7480-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Prashanth G <prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc@v
List-Id: linux-i2c@vger.kernel.org

Hi,

The driver pieces have been reviewed a bit already, but I have a question on
the bindings below.

On Wed, Feb 13, 2013 at 10:02:09AM -0800, Doug Anderson wrote:
> The i2c-arbitrator driver implements the arbitration scheme that the
> Embedded Controller (EC) on the ARM Chromebook expects to use for bus
> multimastering.  This i2c-arbitrator driver could also be used in
> other places where standard i2c bus arbitration can't be used and two
> extra GPIOs are available for arbitration.
> 
> This driver is based on code that Simon Glass added to the i2c-s3c2410
> driver in the Chrome OS kernel 3.4 tree.  The current incarnation as a
> mux driver is as suggested by Grant Likely.  See
> <https://patchwork.kernel.org/patch/1877311/> for some history.
> 
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes in v1: None
> 
>  .../devicetree/bindings/i2c/i2c-arbitrator.txt     |  76 +++++++
>  drivers/i2c/muxes/Kconfig                          |  11 +
>  drivers/i2c/muxes/Makefile                         |   1 +
>  drivers/i2c/muxes/i2c-arbitrator.c                 | 242 +++++++++++++++++++++
>  4 files changed, 330 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt
>  create mode 100644 drivers/i2c/muxes/i2c-arbitrator.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt b/Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt
> new file mode 100644
> index 0000000..bb9cca7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt
> @@ -0,0 +1,76 @@
> +GPIO-based Arbitration
> +======================
> +This uses GPIO lines between the AP (Application Processor) and an attached
> +EC (Embedded Controller) which both want to talk on the same I2C bus as master.
> +
> +The AP and EC each have a 'bus claim' line, which is an output that the
> +other can see. These are both active low, with pull-ups enabled.
> +
> +- AP_CLAIM: output from AP, signalling to the EC that the AP wants the bus
> +- EC_CLAIM: output from EC, signalling to the AP that the EC wants the bus
> +
> +
> +This mechanism is used instead of standard i2c multimaster to avoid some of the
> +subtle driver and silicon bugs that are often present with i2c multimaster.
> +
> +
> +Algorithm:
> +
> +The basic algorithm is to assert your line when you want the bus, then make
> +sure that the other side doesn't want it also. A detailed explanation is best
> +done with an example.
> +
> +Let's say the AP wants to claim the bus. It:
> +1. Asserts AP_CLAIM.
> +2. Waits a little bit for the other side to notice (slew time, say 10
> +   microseconds).
> +3. Checks EC_CLAIM. If this is not asserted then the AP has the bus and we are
> +   done.
> +4. Otherwise, wait for a few milliseconds and see if EC_CLAIM is released.
> +5. If not, back off, release the claim and wait for a few more milliseconds.
> +6. Go back to 1 (until retry time has expired).
> +
> +
> +Required properties:
> +- compatible: i2c-arbitrator
> +- bus-arbitration-gpios: Two GPIOs to use with the GPIO-based bus
> +    arbitration protocol.  The first should be an output, and is used to
> +    claim the I2C bus for us (AP_CLAIM).  The second should be an input and
> +    signals that the other side wants to claim the bus (EC_CLAIM).
> +- bus-arbitration-slew-delay-us: microseconds to wait for a GPIO to go high.
> +- bus-arbitration-wait-retry-us: we'll attempt another claim after this many
> +    microseconds.
> +- bus-arbitration-wait-free-us: we'll give up after this many microseconds.
> +- Standard I2C mux properties. See mux.txt in this directory.
> +- Single I2C child bus node at reg 0. See mux.txt in this directory.
> +
> +
> +Example:
> +	i2c@12CA0000 {
> +		compatible = "acme,some-i2c-device";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	i2c-arbitrator {
> +		compatible = "i2c-arbitrator";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c-parent = <&{/i2c@12CA0000}>;

Why use this custom i2c-parent property? The arbitrator should just be
under the i2c controller in the device tree, and thus parent would be
derived from the topology there.


-Olof

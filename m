From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 12 Sep 2013 17:28:40 +0100
Message-ID: <20130912162840.GE22013@e106331-lin.cambridge.arm.com>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob@landley.net" <rob@landley.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "gavidov@codeaurora.org" <gavidov@codeaurora.org>, "sdharia@codeaurora.org" <sdharia@codeaurora.org>, "alokc@codeaurora.org" <alokc@codeaurora.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel" <linux-kernel@vger.kernel>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 29, 2013 at 02:27:52PM +0100, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> The Qualcomm Universal Peripherial (QUP) wraps I2C mini-core and
> provide input and output FIFO's for it. I2C controller can operate
> as master with supported bus speeds of 100Kbps and 400Kbps.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-qup.txt |   99 +++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qup.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-qup.txt b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
> new file mode 100644
> index 0000000..c682726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
> @@ -0,0 +1,99 @@
> +Qualcomm Universal Periferial (QUP) I2C controller
> +
> +Required properties:
> + - compatible : should be "qcom,i2c-qup"
> + - reg : Offset and length of the register region for the device
> + - interrupts : core interrupt

How about the following:

- interrupts: interrupt-specifier for the core interrupt.

> +
> + - pinctrl-names: Should contain only one value - "default".
> + - pinctrl-0: Should specify pin control group used for this controller.
> +
> + - clocks : phandles to clock instances of the device tree nodes

Clocks aren't just phandles, they have a clock-specifier component. This
should probably be something like:

 - clocks: a list of phandle + clock-specifier pairs for each entry in
           clock-names

> + - clock-names :
> +		"core" : Allow access to FIFO buffers and registers

Huh? That description doesn't seem to descripe the hardware.

> +		"iface" : Clock used by QUP interface

Which interface? The slave interface the CPUs access, or the interface
to the I2C devices?

Are these the only clock inputs to the device?

Is there a regulator input that might need to be specified?

> +
> + - #address-cells : should be <1> Address cells for I2C device address
> + - #size-cells : should be <0> I2C addresses have no size component.
> +
> +Optional properties :
> + - Child nodes conforming to i2c bus binding
> + - clock-frequency : Desired I2C bus clock frequency in Hz. If
> +		not set thedefault frequency is 100kHz

Why is this necessary?

> + - qcom,src-freq : Frequency of the source clocking this bus in Hz.
> +		Divider value is set based on soruce-frequency and
> +		desired I2C bus frequency. If this value is not
> +		provided, the source clock is assumed to be running
> +		at 19.2 MHz.

This looks like it should be a clock input.

Thanks,
Mark.

From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 29 Aug 2013 20:26:26 +0300
Message-ID: <1377797186.30358.14.camel@localhost>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
	 <3A0F4153-1C55-4008-8EB1-D6FA60D87CEA@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3A0F4153-1C55-4008-8EB1-D6FA60D87CEA-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Kumar,

On Thu, 2013-08-29 at 10:28 -0500, Kumar Gala wrote:
> On Aug 29, 2013, at 8:27 AM, Ivan T. Ivanov wrote:
> 
> > From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > 
> > The Qualcomm Universal Peripherial (QUP) wraps I2C mini-core and
> > provide input and output FIFO's for it. I2C controller can operate
> > as master with supported bus speeds of 100Kbps and 400Kbps.
> > 
> > Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > ---
> > Documentation/devicetree/bindings/i2c/i2c-qup.txt |   99 +++++++++++++++++++++
> > 1 file changed, 99 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qup.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-qup.txt b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
> > new file mode 100644
> > index 0000000..c682726
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
> > @@ -0,0 +1,99 @@
> > +Qualcomm Universal Periferial (QUP) I2C controller
> 
> [nit: remove extra spaces before ':']

ok.

> 
> > +
> > +Required properties:
> > + - compatible : should be "qcom,i2c-qup"
> > + - reg : Offset and length of the register region for the device
> > + - interrupts : core interrupt
> > +
> > + - pinctrl-names: Should contain only one value - "default".
> > + - pinctrl-0: Should specify pin control group used for this controller.
> > +
> > + - clocks : phandles to clock instances of the device tree nodes
> > + - clock-names :
> > +		"core" : Allow access to FIFO buffers and registers
> > +		"iface" : Clock used by QUP interface
> > +
> > + - #address-cells : should be <1> Address cells for I2C device address
> > + - #size-cells : should be <0> I2C addresses have no size component.
> > +
> > +Optional properties :
> > + - Child nodes conforming to i2c bus binding
> > + - clock-frequency : Desired I2C bus clock frequency in Hz. If
> > +		not set thedefault frequency is 100kHz
> > + - qcom,src-freq : Frequency of the source clocking this bus in Hz.
> > +		Divider value is set based on soruce-frequency and
> > +		desired I2C bus frequency. If this value is not
> > +		provided, the source clock is assumed to be running
> > +		at 19.2 MHz.
> 
> I'd spell out frequency instead of 'freq' to be consistent with 'clock-frequency'

ok.

> 
> Is the frequency of the 'iface' clock?  Can we not use clk_get_rate?

It is for 'core' clock. I think that for higher I2C bus frequencies,
'core' clock have to be higher, but I am not sure what is relation.

> 
> > +
> > +Aliases: An alias may optionally be used to bind the I2C controller
> > +to bus number. Aliases are of the form i2c<n> where <n> is an integer
> > +representing the bus number to use.
> > +
> > +Example:
> > +
> > + aliases {
> > +		i2c0 = &i2c_A;
> > +		i2c1 = &i2c_B;
> > +		i2c2 = &i2c_C;
> > + };
> 
> What is the purpose here?

Define on which I2C bus this controller operate. I2C client 
drivers usually do i2c_get_adapter(bus_number) before its
registration. This is for drivers before invention of
of_i2c_register_devices(), I believe.


Thanks,
Ivan

> 
> > +
> > + i2c_A: i2c@f9967000 {
> > +		compatible = "qcom,i2c-qup";
> > +		reg = <0Xf9967000 0x1000>;
> > +		interrupts = <0 105 0>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c0_data>;
> > +
> > +		clocks = <&core>, <&iface>;
> > +		clock-names = "core", "iface";
> > +
> > +		clock-frequency = <100000>;
> > +		qcom,src-freq = <50000000>;
> > +		status = "disabled";
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		dummy@60 {
> > +			compatible = "dummy";
> > +			reg = <0x60>;
> > +		};
> > +	};
> > +
> > + i2c_B: i2c@f9923000 {
> > +		compatible = "qcom,i2c-qup";
> > +		reg = <0xf9923000 0x1000>;
> > +		interrupts = <0 95 0>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c1_data>;
> > +
> > +		clocks = <&core>, <&iface>;
> > +		clock-names = "core", "iface";
> > +
> > +		clock-frequency = <100000>;
> > +		qcom,src-freq = <19200000>;
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +	};
> > +
> > + i2c_C: i2c@f9924000 {
> > +		compatible = "qcom,i2c-qup";
> > +		reg = <0xf9924000 0x1000>;
> > +		interrupts = <0 96 0>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c5_data>;
> > +
> > +		clocks = <&core>, <&iface>;
> > +		clock-names = "core", "iface";
> > +
> > +		clock-frequency = <100000>;
> > +		qcom,src-freq = <50000000>;
> > +
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +	};
> > -- 
> > 1.7.9.5
> 
> 
> - k
> 

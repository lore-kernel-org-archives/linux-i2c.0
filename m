From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: npcm7xx: add binding for i2c
 controller
Date: Wed, 15 Aug 2018 14:30:15 -0600
Message-ID: <20180815203015.GA19242@rob-hp-laptop>
References: <20180814182907.182139-1-tali.perry1@gmail.com>
 <20180814182907.182139-2-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180814182907.182139-2-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tali Perry <tali.perry1@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com, yuenn@google.com, brendanhiggins@google.com, mark.rutland@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, arnd@arndb.de, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, pierre-yves.mordret@st.com, cedric.madianga@gmail.com, baolin.wang@spreadtrum.com, jarkko.nikula@linux.intel.com, hdegoede@redhat.com, rmk+kernel@armlinux.org.uk, ard.biesheuvel@linaro.org, thor.thayer@linux.intel.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, tglx@linutronix.de, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 14, 2018 at 09:29:06PM +0300, Tali Perry wrote:
> 
> Nuvoton NPCM7XX I2C Controller
> NPCM7xx includes 16 I2C contollers. This driver operates the controller.

s/contollers/controllers/

> This module also includes a slave mode, which will be submitted later on.
> 
> Any feedback would be appreciated.  
> 
> v3 -> v2:
> 	- fix dt binding: compatible name: ommit "bus"
> 
> v2 -> v1:
> 	- run check patch in strict mode.
> 	- use linux crc.
> 	- define regs in constant offset without base.
> 	- remove debug prints.
> 	- no declerations for local functions.
> 	
> v1: initial version

The version info normally goes below the '---' so it is not part of the 
commit msg.

> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> 
> ---
>  .../devicetree/bindings/i2c/i2c-npcm7xx.txt        | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> new file mode 100644
> index 000000000000..2a474a2a5b3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
> @@ -0,0 +1,29 @@
> +Nuvoton NPCM7XX I2C bus
> +
> +The NPCM750x includes sixteen I2C bus controllers. All Conterollers support

s/Conterollers/controllers/

With those fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +both master and slave mode. Each controller has two 16 byte HW FIFO for TX and
> +RX.
> +
> +Required properties:
> +- compatible      : must be "nuvoton,npcm750-i2c"
> +- reg             : Offset and length of the register set for the device.
> +- interrupts      : Contain the I2C interrupt with flags for falling edge.
> +- clocks          : phandle of I2C reference clock.
> +
> +Optional:
> +- bus-frequency   : Contain the I2C bus frequency,
> +			the default I2C bus frequency is 100000.
> +- pinctrl-0       : must be <&smbX_pins>, X is module number
> +			(on NPCM7XX it's 0 to 15)
> +- pinctrl-names   : should be set to "default"
> +Example:
> +
> +	i2c0: i2c@80000 {
> +		compatible = "nuvoton,npcm750-i2c";
> +		reg = <0x80000 0x1000>;
> +		clocks = <&clk NPCM7XX_CLK_APB2>;
> +		bus-frequency = <100000>;
> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&smb0_pins>;
> +	};
> -- 
> 2.14.1
> 

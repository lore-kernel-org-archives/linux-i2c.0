From: Peter Rosin <peda@axentia.se>
Subject: Compatibles for i2c muxes nxp,pca954x and ti,tca954x
Date: Thu, 3 Aug 2017 12:00:27 +0200
Message-ID: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi!

Texas has apparently made copies for some of the NXP devices
handled by the drivers/i2c/muxes/i2c-mux-pca954x.c driver.

How is that best handled?

I see e.g. that arch/arm/boot/dts/vf610-zii-dev-rev-{b,c}.dts has
this snippet:

&i2c2 {
	tca9548@70 {
		compatible = "nxp,pca9548";

Which indicates that it really is a Texas chip sitting there, but that
someone did not bother to state that explicitly.

As I see it, there are two levels to this.

1. Update the above to be

		compatible = "ti,tca9548a", "nxp,pca9548";

   and rely on the secondary compatible to be matched with the driver.

2. Also update the driver to recognize the "ti,tca9548a" compatible.

There are also "ti,tca9543a", "ti,tca9544a", "ti,tca9545a" and
"ti,tca9546a" to consider (but no "ti,tca9542a" or "ti,tca9547a").

AFAIU, the Texas chips are completely compatible from the driver
point of view.

Step 1 above is probably a bugfix, should someone find some
unexpected incompatibility in the future. Without differentiating
the compatibles now, there's just no way to handle that in a future
driver.

But is step 2 needed/desired until such a time that differences between
the chips are found? How is this situation handled elsewhere?

Cheers,
peda

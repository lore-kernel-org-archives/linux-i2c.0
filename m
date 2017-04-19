From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v13 02/10] dt-bindings: document devicetree bindings for
 mux-controllers and gpio-mux
Date: Wed, 19 Apr 2017 12:41:53 +0200
Message-ID: <0cf0254e-0e43-37c3-f14d-eeffa7d7b9ba@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-3-git-send-email-peda@axentia.se>
 <1492509996.2432.63.camel@pengutronix.de>
 <17135062-e58a-b50e-ac85-5f0f0b73d958@axentia.se>
 <1492593449.2970.24.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1492593449.2970.24.camel@pengutronix.de>
Sender: linux-doc-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kernel@pengutronix.de, Paul Gortmaker <paul.gortmaker@windriver.com>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-04-19 11:17, Philipp Zabel wrote:
> On Tue, 2017-04-18 at 15:36 +0200, Peter Rosin wrote:
>> If I got things wrong when I skimmed whatever I came across, and if the
>> mmio register is the only mux control option in the stars, it becomes
>> less obvious... It's of course still possible to hook into the mux
>> subsystem, but the benefit is questionable. And you do get the extra
>> device tree node. You could of course also implement a mux driver
>> outside of drivers/mux and thus make use of the mux api, but it's tiny
>> and any benefit is truly small.
> 
> What I wondered mostly is whether it would be a good idea to move the
> OF-graph ports into the mux controller node, and let the video capture
> device be the consumer of the mux.
> But this wouldn't fit well with the clear split between the mux
> controller and the actual mux hardware in the mux DT bindings.

I have tried to do something similar. I think. The current
drivers/i2c/muxes/i2c-mux-gpio.c is a good candidate for the same thing
IIUC.

That dedicated driver and the general purpose i2c mux driver does pretty
much the same thing with these two DT snippets:

Dedicated i2c-mux-gpio DT snippet:

	i2c-mux {
		compatible = "i2c-mux-gpio";
		i2c-parent = <&i2c1>;

		mux-gpios = <&gpio1 22 0 &gpio1 23 0>;

		#address-cells = <1>;
		#size-cells = <0>;

		i2c@1 {
			...
		};

		i2c@3 {
			...
		};
	};

General purpose mux DT snippet:

	mux: mux-controller {
		compatible = "gpio-mux";
		#mux-control-cells = <0>;

		mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
	};

	i2c-mux {
		compatible = "i2c-mux";
		i2c-parent = <&i2c1>;

		mux-controls = <&mux>;

		#address-cells = <1>;
		#size-cells = <0>;

		i2c@1 {
			...
		};

		i2c@3 {
			...
		};
	};

I would love to find a way to cleanly get the mux framework to handle
the first DT as well, and thus being able to obsolete the dedicated
i2c-mux-gpio driver. I have not figured out how to accomplish that
without abusing the driver-model to a point that it's not working.
Help with that task is dearly appreciated.

What I have stumbled on, I think, is that two drivers needs to be
instantiated from the same DT node. At the same time, I need the
mux framework to handle the current out-of-node thing with a
phandle as well, so that several mux consumers can share a common
mux controller. My understanding of these matters are apparently not
deep enough...

I think you would like a DT that looks more like the first DT
snippet but still enjoy the flexibility of the mux framework and w/o
implementing a (another) full muxing sub-sub-system like the i2c
sub-system has done. Correct?

Cheers,
peda


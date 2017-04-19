From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v13 02/10] dt-bindings: document devicetree bindings for
 mux-controllers and gpio-mux
Date: Wed, 19 Apr 2017 13:23:42 +0200
Message-ID: <687b26d7-7d80-e8e1-5aa8-a4e8bc070e42@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-3-git-send-email-peda@axentia.se>
 <1492509996.2432.63.camel@pengutronix.de>
 <17135062-e58a-b50e-ac85-5f0f0b73d958@axentia.se>
 <1492593449.2970.24.camel@pengutronix.de>
 <0cf0254e-0e43-37c3-f14d-eeffa7d7b9ba@axentia.se>
 <1492599958.2970.84.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1492599958.2970.84.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-04-19 13:05, Philipp Zabel wrote:
> On Wed, 2017-04-19 at 12:41 +0200, Peter Rosin wrote:
>> On 2017-04-19 11:17, Philipp Zabel wrote:
>>> On Tue, 2017-04-18 at 15:36 +0200, Peter Rosin wrote:
>>>> If I got things wrong when I skimmed whatever I came across, and if the
>>>> mmio register is the only mux control option in the stars, it becomes
>>>> less obvious... It's of course still possible to hook into the mux
>>>> subsystem, but the benefit is questionable. And you do get the extra
>>>> device tree node. You could of course also implement a mux driver
>>>> outside of drivers/mux and thus make use of the mux api, but it's tiny
>>>> and any benefit is truly small.
>>>
>>> What I wondered mostly is whether it would be a good idea to move the
>>> OF-graph ports into the mux controller node, and let the video capture
>>> device be the consumer of the mux.
>>> But this wouldn't fit well with the clear split between the mux
>>> controller and the actual mux hardware in the mux DT bindings.
>>
>> I have tried to do something similar. I think. The current
>> drivers/i2c/muxes/i2c-mux-gpio.c is a good candidate for the same thing
>> IIUC.
>>
>> That dedicated driver and the general purpose i2c mux driver does pretty
>> much the same thing with these two DT snippets:
>>
>> Dedicated i2c-mux-gpio DT snippet:
>>
>> 	i2c-mux {
>> 		compatible = "i2c-mux-gpio";
>> 		i2c-parent = <&i2c1>;
>>
>> 		mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
>>
>> 		#address-cells = <1>;
>> 		#size-cells = <0>;
>>
>> 		i2c@1 {
>> 			...
>> 		};
>>
>> 		i2c@3 {
>> 			...
>> 		};
>> 	};
>>
>> General purpose mux DT snippet:
>>
>> 	mux: mux-controller {
>> 		compatible = "gpio-mux";
>> 		#mux-control-cells = <0>;
>>
>> 		mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
>> 	};
>>
>> 	i2c-mux {
>> 		compatible = "i2c-mux";
>> 		i2c-parent = <&i2c1>;
>>
>> 		mux-controls = <&mux>;
>>
>> 		#address-cells = <1>;
>> 		#size-cells = <0>;
>>
>> 		i2c@1 {
>> 			...
>> 		};
>>
>> 		i2c@3 {
>> 			...
>> 		};
>> 	};
> 
> Yes, replace i2c-mux with video-mux and the i2c@x nodes with port@x
> nodes, and this is very close to what I am thinking about.
> 
>> I would love to find a way to cleanly get the mux framework to handle
>> the first DT as well, and thus being able to obsolete the dedicated
>> i2c-mux-gpio driver. I have not figured out how to accomplish that
>> without abusing the driver-model to a point that it's not working.
>> Help with that task is dearly appreciated.
>>
>> What I have stumbled on, I think, is that two drivers needs to be
>> instantiated from the same DT node. At the same time, I need the
>> mux framework to handle the current out-of-node thing with a
>> phandle as well, so that several mux consumers can share a common
>> mux controller. My understanding of these matters are apparently not
>> deep enough...
> 
> Not necessarily, if the framework could export a function to create a
> gpio/mmio mux_chip on a given device and the gpio-mux and *-mux-gpio
> drivers just reuse that.

I've been up that creek. Why should the gpio mux be special cased?
That's not clean, the implication is that all mux consumers need
to handle the gpio case and have a special compatible for that
case etc. Then someone thinks the DT should look equally "clean" for
some i2c based mux, and the weeds start piling up. This is exactly
what we don't want. We want the mux consumer drivers to be totally
agnostic about the fact that they happen to use a gpio mux.

Cheers,
peda

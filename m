From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: add bindings for i2c-pca-platform
Date: Fri, 23 Jun 2017 16:41:41 -0500
Message-ID: <20170623214141.2kyvqlyywteho36b@rob-hp-laptop>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170620011837.14010-2-chris.packham@alliedtelesis.co.nz>
 <20170622082230.wf4r2ylyevidizkd@ninjato>
 <e121e9ad4afe49008e34b5b4a76b22c6@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e121e9ad4afe49008e34b5b4a76b22c6@svr-chch-ex1.atlnz.lc>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 22, 2017 at 09:20:59PM +0000, Chris Packham wrote:
> On 22/06/17 20:23, Wolfram Sang wrote:
> > 
> >> + - reset-gpios : gpio specifier for gpio connected to RESET_N pin.
> > 
> > What about the 'active' state that Rob mentioned in his last review?
> > 
> 
> My intention was that by saying it is connected to the RESET_N bin the 
> active state is covered.

I would say okay, but based on below it's not.

> I personally always get a little confused when talking about reset 
> lines. The _N denotes that the line is active low but because it is a 
> reset line writing 1 releases the reset so from a what-the-user-wants 
> perspective it's active high.
> 
> dt-binding-wise what we want here is GPIO_ACTIVE_HIGH, as in the driver 
> writes 1 to release reset so don't do any polarity inversion. I'd be 
> happy do add something to that effect in a v3 but I actually felt saying 
> the gpio is connected to RESET_N was less ambiguous.

No, the driver is wrong. The binding should say GPIO_ACTIVE_LOW because 
that is how the pin is defined. The driver needs to set it to inactive.

Rob

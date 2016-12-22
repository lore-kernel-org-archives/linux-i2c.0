From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/5] i2c: designware: Add slave definitions
Date: Thu, 22 Dec 2016 17:29:09 +0200
Message-ID: <1482420549.9552.134.camel@linux.intel.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
         <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei@synopsys.com>
         <20161212170214.4cydp256jsp7srar@rob-hp-laptop>
         <BCF0D4927F9C694C9AEA8827D4A9C7C897CE12@de02wembxa.internal.synopsys.com>
         <CAL_JsqJwjX1Y=bDD-hKcXqa1aBKjVhXjEZm6j2tMAQszyv-QhA@mail.gmail.com>
         <BCF0D4927F9C694C9AEA8827D4A9C7C897CEDB@de02wembxa.internal.synopsys.com>
         <CAL_Jsq+DDx460jcLj34_X9MdtCqyc4izwc=3ThnFri+NjBaGUA@mail.gmail.com>
         <3ef11852-8dc5-dbb3-7dc3-1ec8f4fc58da@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ef11852-8dc5-dbb3-7dc3-1ec8f4fc58da@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, Rob Herring <robh@kernel.org>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ramiro.Oliveira@synopsys.com" <Ramiro.Oliveira@synopsys.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2016-12-22 at 14:59 +0000, Luis Oliveira wrote:
> On 13-Dec-16 14:11, Rob Herring wrote:

> > Something like this:
> > 
> > of_for_each_child_node(child) {
> >   of_property_read_u32(child, "reg", &reg);
> >   if (reg & I2C_OWN_SLAVE_ADDRESS))
> >     im_a_slave = true;
> > }
> > 
> > ...rather than testing "mode" is equal to "slave".
> > 
> > Rob
> > 
> 
> Hi Rob, Andy,
> 
> I'm struggling to implement your suggestion @Rob. I checked the
> tegra124-jetson-tk1.dts that uses that approach but I have some
> doubts.
> 
> My DT is as follows
> 
> 	i2c@0x2000 {
>                         compatible = "snps,designware-i2c";
>                         reg = <0x2000 0x100>;
>                         clock-frequency = <400000>;
>                         clocks = <&i2cclk>;
>                         interrupts = <0>;
> 
> I could add something like this:
> 
> 			eeprom@64 {
> 				compatible = "linux,slave-24c02";
> 				reg = <(I2C_OWN_SLAVE_ADDRESS | 0x64)>;
> 			}
> 
> But I think this is different form what I was doing before. I have two
> questions:
> 
> - This way the I2C controller is identified as a slave controller or
> just the
> subnode eeprom?
> - This way looks like my slave address will be fixed
> 
> In the previous Patch v3 submission @Andy suggested a property that
> selects mode
> that I did and it's working. And you @Rob suggested to do it a common
> property.
> It is implemented in the DT like:
> 
> 			mode = "slave";
> 
> So before I do this changes can you please agree both if you still
> think this is
> the best approach?

I'm a bit lost in the discussion (and TBH busy by something else), so I
would agree on whatever you and Rob make an agreement on.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: I2C filtering (was Re: [PATCH v2 6/9] dt-bindings: i2c: at91:
 add binding for enable-ana-filt)
Date: Thu, 27 Jun 2019 15:22:00 +0200
Message-ID: <20190627132200.GK3692@piout.net>
References: <1561449642-26956-1-git-send-email-eugen.hristev@microchip.com>
 <1561449642-26956-7-git-send-email-eugen.hristev@microchip.com>
 <4e81d3c9-25f3-ca6e-f2d5-17fad5905bb8@axentia.se>
 <84628b5e-bea7-7d91-f790-f3a2650040fa@microchip.com>
 <20190625093156.GF5690@piout.net>
 <20190625095533.GC1688@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625095533.GC1688@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Eugen.Hristev@microchip.com, peda@axentia.se, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
List-Id: linux-i2c@vger.kernel.org

On 25/06/2019 11:55:33+0200, Wolfram Sang wrote:
> On Tue, Jun 25, 2019 at 11:31:56AM +0200, Alexandre Belloni wrote:
> > On 25/06/2019 09:14:13+0000, Eugen.Hristev@microchip.com wrote:
> > > > Perhaps
> > > > 
> > > > 	microchip,digital-filter;
> > > > 	microchip,analog-filter;
> > > > 
> > > > ?
> > > 
> > > Hi Peter,
> > > 
> > > Thanks for reviewing. The name of the property does not matter much to 
> > > me, and we have properties prefixed with vendor, and some are not.
> > > 
> > > @Alexandre Belloni: which name you think it's best ?
> > > 
> > 
> > I'm not sure, it depends on whether Wolfram thinks it is generic enough
> > to be used without a vendor prefix.
> 
> I could imagine that we design a generic property for filters. The ones
> above make me wonder, though, because they are bool. I'd think you can
> configure the filters in some way, too?
> 

Apart from enabling the filter there is indeed one configuration
setting, the maximum pulse width of spikes to be suppressed by the input
filter.

> I never used such filtering, so I am unaware of the parameters needed /
> suitable. Quick grepping through I2C master drivers reveals that
> i2c-stm32f7.c also handles filters, but only with default values. Maybe
> DT configuration would be benefitial to that driver, too?
> 
> Adding some people to CC.
> 



-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: I2C filtering (was Re: [PATCH v2 6/9] dt-bindings: i2c: at91:
 add binding for enable-ana-filt)
Date: Thu, 27 Jun 2019 15:39:32 +0200
Message-ID: <20190627133932.GL3692@piout.net>
References: <1561449642-26956-1-git-send-email-eugen.hristev@microchip.com>
 <1561449642-26956-7-git-send-email-eugen.hristev@microchip.com>
 <4e81d3c9-25f3-ca6e-f2d5-17fad5905bb8@axentia.se>
 <84628b5e-bea7-7d91-f790-f3a2650040fa@microchip.com>
 <20190625093156.GF5690@piout.net>
 <20190625095533.GC1688@kunai>
 <20190627132200.GK3692@piout.net>
 <eb2d87b7-437c-53ee-a1ca-37c4d3fadea6@microchip.com>
 <20190627133440.GA7158@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190627133440.GA7158@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Eugen.Hristev@microchip.com, peda@axentia.se, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, pierre-yves.mordret@st.com
List-Id: linux-i2c@vger.kernel.org

On 27/06/2019 15:34:40+0200, Wolfram Sang wrote:
> 
> > > Apart from enabling the filter there is indeed one configuration
> > > setting, the maximum pulse width of spikes to be suppressed by the input
> > > filter.
> 
> Yup, this is what I anticipated.
> 
> > This is a number 0 to 7 (3 bits) that represents the width of the spike 
> > in periph clock cycles.
> 
> For a generic binding, we would need some time-value as a parameter and
> convert it to clock cycles in the driver then, I'd think.
> 

Yes, that is what I was going to suggest.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

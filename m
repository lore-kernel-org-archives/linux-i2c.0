From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: i2c: at91: add binding for
 enable-ana-filt
Date: Tue, 25 Jun 2019 11:31:56 +0200
Message-ID: <20190625093156.GF5690@piout.net>
References: <1561449642-26956-1-git-send-email-eugen.hristev@microchip.com>
 <1561449642-26956-7-git-send-email-eugen.hristev@microchip.com>
 <4e81d3c9-25f3-ca6e-f2d5-17fad5905bb8@axentia.se>
 <84628b5e-bea7-7d91-f790-f3a2650040fa@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <84628b5e-bea7-7d91-f790-f3a2650040fa@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen.Hristev@microchip.com
Cc: peda@axentia.se, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 25/06/2019 09:14:13+0000, Eugen.Hristev@microchip.com wrote:
> > Perhaps
> > 
> > 	microchip,digital-filter;
> > 	microchip,analog-filter;
> > 
> > ?
> 
> Hi Peter,
> 
> Thanks for reviewing. The name of the property does not matter much to 
> me, and we have properties prefixed with vendor, and some are not.
> 
> @Alexandre Belloni: which name you think it's best ?
> 

I'm not sure, it depends on whether Wolfram thinks it is generic enough
to be used without a vendor prefix.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

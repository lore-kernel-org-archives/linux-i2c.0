From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v5 0/9] i2c: add support for filters
Date: Fri, 25 Oct 2019 12:05:43 +0200
Message-ID: <20191025100542.licpieymkbsbm5cd@M43218.corp.atmel.com>
References: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
 <20191024183035.GA1870@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191024183035.GA1870@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Eugen.Hristev@microchip.com, peda@axentia.se, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, robh+dt@kernel.org, Nicolas.Ferre@microchip.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 24, 2019 at 08:30:35PM +0200, Wolfram Sang wrote:
> On Wed, Sep 11, 2019 at 08:24:14AM +0000, Eugen.Hristev@microchip.com wrote:
> > From: Eugen Hristev <eugen.hristev@microchip.com>
> > 
> > Hello,
> > 
> > This series adds support for analog and digital filters for i2c controllers
> > 
> > This series is based on the series:
> > [PATCH v2 0/9] i2c: at91: filters support for at91 SoCs
> > and later
> > [PATCH v4 0/9] i2c: add support for filters
> > and enhanced to add the bindings for all controllers plus an extra bindings
> > for the width of the spikes in nanoseconds (digital filters) and cut-off
> > frequency (analog filters)
> > 
> > First, bindings are created for
> > 'i2c-analog-filter'
> > 'i2c-digital-filter'
> > 'i2c-digital-filter-width-ns'
> > 'i2c-analog-filter-cutoff-frequency'
> > 
> > The support is added in the i2c core to retrieve filter width/cutoff frequency
> > and add it to the timings structure.
> > Next, the at91 driver is enhanced for supporting digital filter, advanced
> > digital filter (with selectable spike width) and the analog filter.
> > 
> > Finally the device tree for two boards are modified to make use of the
> > new properties.
> > 
> > This series is the result of the comments on the ML in the direction
> > requested: to make the bindings globally available for i2c drivers.
> 
> Applied patches 1-7 to for-next (patch 3 is v6). Thanks for your
> patience and thanks to Ludovic and Peter for the review! Patches 8-9
> should go via the at91 tree.
> 

Thanks, patch 8 and 9 applied to at91-dt.

Regards

Ludovic

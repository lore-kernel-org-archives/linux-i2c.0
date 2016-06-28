From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] Documentation: dt: i2c: use correct
 STMicroelectronics vendor prefix
Date: Tue, 28 Jun 2016 15:56:47 -0500
Message-ID: <20160628205647.GQ3737@rob-hp-laptop>
References: <20160626093406.26785-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160626093406.26785-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, arnd@arndb.de, shawnguo@kernel.org, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org, scottwood@freescale.com, dinguyen@opensource.altera.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Jun 26, 2016 at 02:34:04AM -0700, Stefan Agner wrote:
> The documentation currently uses the non-standard vendor prefix stm
> and st-micro for STMicroelectronics. The drivers do not specify the
> vendor prefixes since the I2C Core strips them away from the DT
> provided compatible string. Therefor, changing documentation and
> existing device trees does not have any impact on device detection.

For Linux at least...

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi,
> 
> Mark mentioned that issue already once in the past, see:
> http://lkml.iu.edu/hypermail/linux/kernel/1309.0/01686.html
> 
> Not sure through which trees this patches should flow, I guess
> the first through Wolfram's tree, the ARM changes through Arnd
> or Shawns tree (mostly Freescale boards are affected), not sure
> about the PowerPC changes...

I can take the series. dts files shouldn't be changing causing 
conflicts.

Rob

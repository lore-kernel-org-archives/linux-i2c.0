From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/7] i2c: designware: document MSCC Ocelot bindings
Date: Fri, 17 Aug 2018 09:09:54 -0600
Message-ID: <20180817150954.GB20845@rob-hp-laptop>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
 <20180816084521.16289-5-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180816084521.16289-5-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Thu, 16 Aug 2018 10:45:18 +0200, Alexandre Belloni wrote:
> Document bindings for the Microsemi Ocelot integration of the Designware
> I2C controller.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

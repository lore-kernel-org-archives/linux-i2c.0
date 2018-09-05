From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v5 0/7] Add support for MSCC Ocelot i2c
Date: Wed, 5 Sep 2018 16:09:19 -0700
Message-ID: <20180905230919.ycqmkohubym5foz3@pburton-laptop>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
 <20180901124353.GB1196@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180901124353.GB1196@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microchip.com>
List-Id: linux-i2c@vger.kernel.org

Hi Alexandre & Wolfram,

On Sat, Sep 01, 2018 at 02:43:53PM +0200, Wolfram Sang wrote:
> > Because the designware IP was not able to handle the SDA hold time before
> > version 1.11a, MSCC has its own implementation. Add support for it and then add
> > i2c on ocelot boards.
> > 
> > I would expect patches 1 to 5 to go through the i2c tree.
> 
> Applied to for-next, thanks!
> 
> > Pathces 6-7 can go through the mips tree now that the bindings have been
> > reviewed.
> 
> They have been reviewed by Rob and are applied now to my tree.

Patches 6 & 7 applied to mips-next for 4.20 - thanks!

Paul

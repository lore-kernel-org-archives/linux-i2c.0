From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
Date: Thu, 12 Sep 2013 12:27:43 +0300
Message-ID: <20130912092743.GK7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-9-git-send-email-mika.westerberg@linux.intel.com>
 <20130911155120.GW29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130911155120.GW29403@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 11, 2013 at 04:51:20PM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2013 at 06:32:39PM +0300, Mika Westerberg wrote:
> > This patch adds runtime PM support for the SPI bus analogous to what has
> > been done for the I2C bus. This means that the SPI core prepares runtime PM
> > for a client device just before a driver is about to be bound to it.
> > Devices that are not bound to any driver are not prepared for runtime PM.
> 
> Acked-by: Mark Brown <broonie@linaro.org>

Thanks!

> I would be able to have this and the other patch in the SPI tree in case
> it overlaps with other work - I'm not sure what the plan will be for
> merging this stuff but if there were a branch which I could merge into
> the SPI tree that'd be good.

I think these two can go via your SPI tree as they shouldn't have
dependencies to the I2C tree.

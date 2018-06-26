From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 0/7] i2c: Add FSI-attached I2C master algorithm
Date: Tue, 26 Jun 2018 11:39:41 +0900
Message-ID: <20180626023940.zn4zin6idrgcf2zx@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 13, 2018 at 02:36:12PM -0500, Eddie James wrote:
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
> 
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.

Thanks for this series and your patience.

While I can see why it also helps reviewing to send it as a series of
multiple patches, I consider applying the driver itself as just one
hunk. I am not decided on this yet.

I have a few comments, especially about recovery. I replied to the
relevant patches with more detail.

Also, are you (or someone from your company) willing to maintain the
driver? Then, an addition to MAINTAINERS would be much appreciated.

Thanks,

   Wolfram

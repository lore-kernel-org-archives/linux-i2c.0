From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v10 0/7] i2c: Add FSI-attached I2C master algorithm
Date: Mon, 18 Jun 2018 14:23:11 +0930
Message-ID: <CACPK8XcA7RmerPbK_5pCh_NJQqZ_5pAVD4najW9e4rf1FYL4SQ@mail.gmail.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

On 14 June 2018 at 05:06, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.

Looks good Eddie. I had a read over what you have, and I would be
happy to see this merged in 4.19.

Reviewed-By: Joel Stanley <joel@jms.id.au>

Also, I have merged this into the 4.17 based openbmc tree for testing
while we wait for it to be merged upstream.

Cheers,

Joel

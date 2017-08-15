From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v5 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Tue, 15 Aug 2017 08:36:59 +0200
Message-ID: <f324da3b-7c9e-3dc1-0cdc-91576c7a50b8@axentia.se>
References: <1501089198-10356-1-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr20095.outbound.protection.outlook.com ([40.107.2.95]:22656
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752824AbdHOGhL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Aug 2017 02:37:11 -0400
In-Reply-To: <1501089198-10356-1-git-send-email-eajames@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, cbostic@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>

On 2017-07-26 19:13, Eddie James wrote:
> From: "Edward A. James" <eajames@us.ibm.com>
> 
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
> 
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.

Hmmm, AFAIU fsi is a bus, and on this bus you have some "client" device that
happens to be an i2c master, and this is a driver for that "client". Is it
totally inconceivable to have some other client device in the future that is
implementing an i2c master differently, but still using the fsi bus?

With that in mind, is it wise to pick the driver name from the bus that the
device is connected to, and nothing else without further qualification?

I don't see any "i2c-usb" driver, but I think there are a couple of i2c master
drivers that communicate via usb.

Cheers,
Peter

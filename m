From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v5 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Tue, 15 Aug 2017 17:40:38 +0930
Message-ID: <CACPK8XexFdz63t4y5uO1GzoWrx=wnkqBxbYKGtuFq0JupeLNHQ@mail.gmail.com>
References: <1501089198-10356-1-git-send-email-eajames@linux.vnet.ibm.com> <f324da3b-7c9e-3dc1-0cdc-91576c7a50b8@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35300 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdHOILB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Aug 2017 04:11:01 -0400
In-Reply-To: <f324da3b-7c9e-3dc1-0cdc-91576c7a50b8@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Eddie James <eajames@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>, Christopher Bostic <cbostic@linux.vnet.ibm.com>, "Edward A. James" <eajames@us.ibm.com>

On Tue, Aug 15, 2017 at 4:06 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2017-07-26 19:13, Eddie James wrote:
>> From: "Edward A. James" <eajames@us.ibm.com>
>>
>> This series adds an algorithm for an I2C master physically located on an FSI
>> slave device. The I2C master has multiple ports, each of which may be connected
>> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>>
>> Due to the multi-port nature of the I2C master, the driver instantiates a new
>> I2C adapter for each port connected to a slave. The connected ports should be
>> defined in the device tree under the I2C master device.
>
> Hmmm, AFAIU fsi is a bus, and on this bus you have some "client" device that
> happens to be an i2c master, and this is a driver for that "client". Is it
> totally inconceivable to have some other client device in the future that is
> implementing an i2c master differently, but still using the fsi bus?
>
> With that in mind, is it wise to pick the driver name from the bus that the
> device is connected to, and nothing else without further qualification?
>
> I don't see any "i2c-usb" driver, but I think there are a couple of i2c master
> drivers that communicate via usb.

You make a fair point. When I did a prototype of this driver I called
it i2c-cfam, as it is part of the CFAM hardware unit inside of the
Power8/Power9 processors.

The documentation does call it FSI_I2CM, so that's an argument for the
current name.

I'm not sure how accurate that name is. Chris, Eddie, do you have any
other suggestions?

Cheers,

Joel

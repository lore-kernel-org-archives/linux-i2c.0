From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Mon, 17 Jul 2017 23:46:18 +0930
Message-ID: <CACPK8XfeMLA5vUEkxVO_U=rN49gvGZ4zfdBJbxX44yTiUy27yw@mail.gmail.com>
References: <1499711882-12918-1-git-send-email-eajames@linux.vnet.ibm.com> <20170717141123.GA13295@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717141123.GA13295@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Eddie James <eajames@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>, Christopher Bostic <cbostic@linux.vnet.ibm.com>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 17, 2017 at 11:41 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 10, 2017 at 01:37:56PM -0500, Eddie James wrote:
>> From: "Edward A. James" <eajames@us.ibm.com>
>>
>> This series adds an algorithm for an I2C master physically located on an FSI
>> slave device. The I2C master has multiple ports, each of which may be connected
>> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>>
>> Due to the multi-port nature of the I2C master, the driver instantiates a new
>> I2C adapter for each port connected to a slave. The connected ports should be
>> defined in the device tree under the I2C master device.
>>
>> Changes since v1:
>
> I have 2 "v2" series in my inbox, and they are different :(
>
> Please resend a "v4" so I know exactly which ones to pick up...

Hi Greg,

This is a driver for the i2c bus master, so I would expect the patches
to be reviewed and applied through Wolfram's i2c tree?

Eddie, regardless can you please send a v4 so we know which version to
be reviewing.

Cheers,

Joel

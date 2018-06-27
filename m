From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 0/7] i2c: Add FSI-attached I2C master algorithm
Date: Wed, 27 Jun 2018 08:53:26 -0500
Message-ID: <f7d0da3d-9bbd-2417-00eb-56b3a40025e2@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023940.zn4zin6idrgcf2zx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626023940.zn4zin6idrgcf2zx@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 06/25/2018 09:39 PM, Wolfram Sang wrote:
> On Wed, Jun 13, 2018 at 02:36:12PM -0500, Eddie James wrote:
>> This series adds an algorithm for an I2C master physically located on an FSI
>> slave device. The I2C master has multiple ports, each of which may be connected
>> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>>
>> Due to the multi-port nature of the I2C master, the driver instantiates a new
>> I2C adapter for each port connected to a slave. The connected ports should be
>> defined in the device tree under the I2C master device.
> Thanks for this series and your patience.
>
> While I can see why it also helps reviewing to send it as a series of
> multiple patches, I consider applying the driver itself as just one
> hunk. I am not decided on this yet.
>
> I have a few comments, especially about recovery. I replied to the
> relevant patches with more detail.
>
> Also, are you (or someone from your company) willing to maintain the
> driver? Then, an addition to MAINTAINERS would be much appreciated.

Thanks for the review Wolfram! I addressed your comments about recovery, 
please let me know what you think. I will fix the email for the dt patch 
and make an addition to MAINTAINERS for the next version.

Thanks,
Eddie

>
> Thanks,
>
>     Wolfram
>

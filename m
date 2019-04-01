From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
Date: Mon, 1 Apr 2019 14:43:17 -0700
Message-ID: <0b97cacd-9bf4-135a-b2ee-1d51ab380b1c@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-7-ray.jui@broadcom.com> <20190327222439.GC15396@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327222439.GC15396@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 3/27/2019 3:24 PM, Wolfram Sang wrote:
> 
>> Update iProc I2C binding document to add new compatible string
>> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
>> also added that allows configuration of the host view into the APE's
>> address for "brcm,iproc-nic-i2c"
> 
> I don't know the platform, but wouldn't it be more DT-like to describe
> the APE in DT and derive the mask from that information? Custom bindings
> with values which are directly poked into a register usually raise my
> eyebrow.
> 

Note APE is a co-processor that is not visible from the Linux running
from the host processor.

"brcm,iproc-nic-i2c" here is introduced to allow the I2C port from APE
to be completely owned by the host CPU, to meet the requirement of
certain use cases. At the same time, the control of the I2C port from
APE will be disabled.

The "brcm,ape-hsls-addr-mask" defines the address translation and be
programmed into some configuration registers to allow the host to
directly access the I2C registers of APE. Note those configuration
registers are owned by the host, and that address is not APE's address
space nor the host is intending to take over the control of APE.

Therefore, I think it makes way more sense to use an address mask type
of DT property here.

Thanks,

Ray

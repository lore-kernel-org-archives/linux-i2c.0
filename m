From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v1 1/1] i2c: iproc: Add i2c repeated start capability
Date: Tue, 24 Sep 2019 10:23:12 -0700
Message-ID: <5ab79d0e-eb54-8fe1-1ca3-e763a17c6426@broadcom.com>
References: <1565150941-27297-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190830125626.GC2870@ninjato>
 <3e70fa7e-de13-4edd-2e17-b7c56e91d220@broadcom.com>
 <20190831094940.GA1138@kunai>
 <540c4e2d-0dd5-5260-30b2-e1589b279d71@broadcom.com>
 <20190904213745.GG23608@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904213745.GG23608@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Lori Hikichi <lori.hikichi@broadcom.com>, Icarus Chau <icarus.chau@broadcom.com>, Shivaraj Shetty <sshetty1@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 9/4/19 2:37 PM, Wolfram Sang wrote:
> 
>> I think you are right that the controller does not seem to support
>> additional I2C features in addition to SMBUS.
>>
>> However, my concern of switching to the smbus_xfer API is:
>>
>> 1) Some customers might have used I2C_RDWR based API from i2cdev. Changing
>> from master_xfer to smbus_xfer may break the existing applications that are
>> already developed.
> 
> Well, given that you add new quirks in the original patch here, you are
> kind of breaking it already. Most transfers which are not SMBus-alike
> transfers would now be rejected. For SMBus-alike transfers which are
> sent via I2C_RDWR (which is ugly), I have to think about it.
> 
>> 2) The sound subsystem I2C regmap based implementation seems to be using
>> i2c_ based API instead of smbus_ based API. Does this mean this will also
>> break most of the audio codec drivers with I2C regmap API based usage?
> 
> I don't think so. If you check regmap_get_i2c_bus() then it checks the
> adapter functionality and chooses the best transfer option then. I may
> be missing something but I would wonder if the sound system does
> something special and different.
> 

We did more investigation on this.

First of all, like you said, there's no concern on regmap based API, the 
smbus_xfer only based approach should just work.

Secondly, for most i2ctools like i2cget, i2cset, i2cdump, there's no 
concern either, given that they already use I2C_SMBUS based IOCTL.

However, for i2ctransfer or any customer applications that use I2C_RDWR 
IOCTL, i2c_transfer (master_xfer) is the only supported function. And we 
can confirm we do have at least one customer using i2ctransfer for 
EEPROM access on their system, e.g.,  i2ctransfer 1 w2@0x50 0x00 0x00 r64.

In my opinion, it's probably better to continue to support master_xfer 
in our driver (with obvious limitations), in order to allow i2ctransfer 
(or any apps that use I2C RDWR) to continue to work.

What do you think?

Regards,

Ray

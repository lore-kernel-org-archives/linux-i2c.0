From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v6 0/9] iProc I2C slave mode and NIC mode
Date: Wed, 3 Apr 2019 13:56:54 -0700
Message-ID: <a34e914a-ac8e-421e-f75c-f595bc678219@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
 <20190403204423.btgtke3tmt7pkr3j@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403204423.btgtke3tmt7pkr3j@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 4/3/2019 1:44 PM, Wolfram Sang wrote:
> On Tue, Apr 02, 2019 at 06:18:21PM -0700, Ray Jui wrote:
>> This patch series adds the following support to the iProc I2C driver:
>> - Increase maximum read transfer size to 255 bytes
>> - I2C slave mode
>> - Polling mode
>> - NIC I2C mode
>>
>> This patch series is based on kernel v5.1-rc3 and available at:
>> https://github.com/Broadcom/arm64-linux.git
>> branch: i2c-slave-v6
>>
>> Changes from v5:
>>  - Address various comments from Wolfram
> 
> In the future, please write in detail what you changed. I review so many
> patches that I can't recall all my comments on every patch.
> 

Sure will do next time.

> That being said, all patches applied to for-next, thanks!
> 

Thanks!

> Can be fixed incrementally, my code checkers complain about:
> 
>     CPPCHECK
> drivers/i2c/busses/i2c-bcm-iproc.c:720:14: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>     val |= 1 << M_TX_WR_STATUS_SHIFT;
>              ^
> drivers/i2c/busses/i2c-bcm-iproc.c:847:13: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>  val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
>             ^
> drivers/i2c/busses/i2c-bcm-iproc.c:998:13: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>  val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
> 

I'll submit an incremental patch to fix the above warnings. I think we
can convert all '1 << XXX' syntax in this driver to 'BIT(XXX)'. It will
fix all of the above warnings and make the code more readable.

Thanks,

Ray

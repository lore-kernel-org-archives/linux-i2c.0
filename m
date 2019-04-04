From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v6 0/9] iProc I2C slave mode and NIC mode
Date: Thu, 4 Apr 2019 09:28:28 -0700
Message-ID: <64e40004-61e9-eff4-07a1-d41323f056c7@gmail.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
 <20190403204423.btgtke3tmt7pkr3j@ninjato>
 <06dff712-151b-f188-d154-3130d56d01d8@gmail.com>
 <20190404061601.c7sbti2zyu6tsoyw@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404061601.c7sbti2zyu6tsoyw@katana>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <ray.jui@broadcom.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 4/3/19 11:16 PM, Wolfram Sang wrote:
> On Wed, Apr 03, 2019 at 03:20:14PM -0700, Florian Fainelli wrote:
>> On 4/3/19 1:44 PM, Wolfram Sang wrote:
>>> On Tue, Apr 02, 2019 at 06:18:21PM -0700, Ray Jui wrote:
>>>> This patch series adds the following support to the iProc I2C driver:
>>>> - Increase maximum read transfer size to 255 bytes
>>>> - I2C slave mode
>>>> - Polling mode
>>>> - NIC I2C mode
>>>>
>>>> This patch series is based on kernel v5.1-rc3 and available at:
>>>> https://github.com/Broadcom/arm64-linux.git
>>>> branch: i2c-slave-v6
>>>>
>>>> Changes from v5:
>>>>  - Address various comments from Wolfram
>>>
>>> In the future, please write in detail what you changed. I review so many
>>> patches that I can't recall all my comments on every patch.
>>>
>>> That being said, all patches applied to for-next, thanks!
>>
>> OK, I will drop patch #9 from my queue then, thanks.
> 
> Sorry, I meant patches 1-8 applied, assuming patch 9 was already taken.
> I usually don't pick up DTS patches, so I'd be happy if you could keep
> #9 in your tree.

Now applied and pushed out, not a problem, thanks!
-- 
Florian

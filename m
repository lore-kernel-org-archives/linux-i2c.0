From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
Date: Mon, 1 Apr 2019 14:44:07 -0700
Message-ID: <c6d1e148-fe2b-9c50-10e1-3052fd971361@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190327222712.GD15396@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327222712.GD15396@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 3/27/2019 3:27 PM, Wolfram Sang wrote:
> On Thu, Feb 14, 2019 at 09:57:17AM -0800, Ray Jui wrote:
>> This patch series adds the following support to the iProc I2C driver:
>> - Increase maximum read transfer size to 255 bytes
>> - I2C slave mode
>> - Polling mode
>> - NIC I2C mode
>>
>> This patch series is based on kernel v5.0-rc3 and available at:
>> https://github.com/Broadcom/arm64-linux.git
> 
> So, I had a high level look at these patches and made a few comments. For
> the details, I trust you (being the maintainer :))
> 

Thanks for the feedback, Wolfram. We'll reply and address your comments.

Ray

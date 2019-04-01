From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 1/8] i2c: iproc: Extend I2C read up to 255 bytes
Date: Mon, 1 Apr 2019 14:35:16 -0700
Message-ID: <f89a0e5f-14f1-b9a2-44f6-67ff0eaf761c@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-2-ray.jui@broadcom.com> <20190327221732.GB15396@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327221732.GB15396@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Shreesha Rajashekar <shreesha@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 3/27/2019 3:17 PM, Wolfram Sang wrote:
> 
>> +		if (!((readl(iproc_i2c->base +
>> +		M_FIFO_CTRL_OFFSET) >>
>> +		M_FIFO_RX_CNT_SHIFT) &
>> +		M_FIFO_RX_CNT_MASK))
> 
> Don't be too strict with the 80 char limit. I think the above is hardly
> readable...
> 

Right, that makes sense. Will change to make it more readable than
trying to be compliant to the < 80 chars rule.

>> +			break;
>> +
>> +		msg->buf[iproc_i2c->rx_bytes] =
>> +			(readl(iproc_i2c->base + M_RX_OFFSET) >>
>> +			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> 
> ... this here is MUCH better.
> 
> Rest looks good.
> 

Thanks,

Ray

From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 2/8] i2c: iproc: Add slave mode support
Date: Mon, 1 Apr 2019 14:33:47 -0700
Message-ID: <c67178db-9459-b424-a29a-23bb0e0c5ca9@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-3-ray.jui@broadcom.com> <20190327221452.GA15396@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327221452.GA15396@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Michael Cheng <ccheng@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram/Rayagonda,

On 3/27/2019 3:14 PM, Wolfram Sang wrote:
> 
>> +static void bcm_iproc_i2c_slave_init(
>> +	struct bcm_iproc_i2c_dev *iproc_i2c, bool need_reset)
>> +{
>> +	u32 val;
>> +
>> +	if (need_reset) {
>> +		/* put controller in reset */
>> +		val = readl(iproc_i2c->base + CFG_OFFSET);
>> +		val |= BIT(CFG_RESET_SHIFT);
>> +		writel(val, iproc_i2c->base + CFG_OFFSET);
>> +
>> +		/* wait 100 usec per spec */
>> +		udelay(100);
>> +
>> +		/* bring controller out of reset */
>> +		val &= ~(BIT(CFG_RESET_SHIFT));
>> +		writel(val, iproc_i2c->base + CFG_OFFSET);
>> +	}
>> +
>> +	/* flush TX/RX FIFOs */
>> +	val = (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
>> +	writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);
> 
> Will flushing FIFOs work when a slave is register while a master
> transfer is on-going at the same time?
> 

Okay, as you pointed out in a subsequent email, this can't happen.

>> +
>> +	/* RANDOM SLAVE STRETCH time - 20ms*/
> 
> What is a "random stretch time"? 20ms sounds like a lot. Also, missing
> space before comment terminator.
> 

Rayagonda,

Could you please help to comment on the choice of the 20 ms to allow
clock stretch from the slave? In probably all cases, the slave should
not need more than 1 ms? 20 ms does seem way too long as Wolfram pointed
out.

Will fix the missing space before comment terminator.

>> @@ -224,22 +473,25 @@ static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
>>  
>>  	/* put controller in reset */
>>  	val = readl(iproc_i2c->base + CFG_OFFSET);
>> -	val |= 1 << CFG_RESET_SHIFT;
>> -	val &= ~(1 << CFG_EN_SHIFT);
>> +	val |= BIT(CFG_RESET_SHIFT);
>> +	val &= ~(BIT(CFG_EN_SHIFT));
>>  	writel(val, iproc_i2c->base + CFG_OFFSET);
>>  
>>  	/* wait 100 usec per spec */
>>  	udelay(100);
>>  
>>  	/* bring controller out of reset */
>> -	val &= ~(1 << CFG_RESET_SHIFT);
>> +	val &= ~(BIT(CFG_RESET_SHIFT));
>>  	writel(val, iproc_i2c->base + CFG_OFFSET);
>>  
>>  	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
>> -	val = (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
>> +	val = (BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT));
>>  	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
>>  	/* disable all interrupts */
>> -	writel(0, iproc_i2c->base + IE_OFFSET);
>> +	val = readl(iproc_i2c->base + IE_OFFSET);
>> +	val &= ~(IE_M_ALL_INTERRUPT_MASK <<
>> +			IE_M_ALL_INTERRUPT_SHIFT);
>> +	writel(val, iproc_i2c->base + IE_OFFSET);
> 
> This block looks unrelated, but I won't be too strict here...
> 
>> +	case M_CMD_STATUS_FIFO_UNDERRUN:
>> +		dev_dbg(iproc_i2c->device, "FIFO under-run\n");
>> +		return -ENXIO;
>> +
>> +	case M_CMD_STATUS_RX_FIFO_FULL:
>> +		dev_dbg(iproc_i2c->device, "Master Rx FIFO full > 10ms\n");
>> +		return -ETIMEDOUT;
>> +
> 
> ... however, this looks really unrelated to me. This is about master
> transmission, or?

This should be submitted in a separate commit. Will do that in the next
iteration of patch series.

> 
> Rest looks OK.
> 

Thanks,

Ray

From: George Cherian <gcherian@caviumnetworks.com>
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
Date: Tue, 27 Feb 2018 10:41:06 +0530
Message-ID: <a2016717-82b1-2802-877b-f947f349f792@caviumnetworks.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
 <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,


On 02/27/2018 10:30 AM, George Cherian wrote:
> Hi Wolfram,
> 
> Thanks for the review.
> 
> On 02/27/2018 01:52 AM, Wolfram Sang wrote:
>>
>> On Thu, Jan 18, 2018 at 05:39:24AM +0000, George Cherian wrote:
>>> I2C bus enters the STOP condition after the DATA_DONE interrupt is 
>>> raised.
>>> Essentially the driver should be checking the bus state before sending
>>> the next transaction.
>>
>> Yes.
>>
>>> In case the next transaction is initiated while the
>>> bus is busy, the prior transactions stop condition is not achieved.
>>
>> I didn't fully get why you can't check the BUSY bit and wait a little
>> just before you push out the next message?
> Yes, I am checking for the BUSY bit and looping.
> Here for reference
> 
> +    while (last_msg && busy_timeout) {
> +        status = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_STATUS);
> +        if ((status & XLP9XX_I2C_STATUS_BUSY) == 0)
> +            break;
> +
> +        busy_timeout--;
> +        udelay(1);
> +    }
> +
> +    if (!busy_timeout) {
> +        dev_dbg(priv->dev, "i2c bus busy for too long after transfer\n");
> +        return -EIO;
> +    }
> 
> Did you mean to eliminate the udelay and use msleep?
> In any case I will re-post another version of the patch, since
> I have found some more issues and need to be fixed.

Since you raised concern on the patch I thought of reworking this patch.
But I can see that this patch is already applied for i2c/for-next.
Kindly let me know whether I should be sending follow-up patches on top
of i2c/for-next ?
> 
>>
>>> Add the check to make sure the bus is not busy before next transaction.
>>>
> 
> Regards,
> -George

Regards,
-George

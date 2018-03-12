From: Abhishek Sahu <absahu@codeaurora.org>
Subject: Re: [PATCH 06/12] i2c: qup: proper error handling for i2c error in
 BAM mode
Date: Mon, 12 Mar 2018 18:04:40 +0530
Message-ID: <b485110614fd77e15c319b8b3f00e69e@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-7-git-send-email-absahu@codeaurora.org>
 <20180227225856.GG20901@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227225856.GG20901@hector.attlocal.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-02-28 04:28, Andy Gross wrote:
> On Sat, Feb 03, 2018 at 01:28:11PM +0530, Abhishek Sahu wrote:
> 
> <snip>
> 
>> @@ -841,20 +856,12 @@ static int qup_i2c_bam_do_xfer(struct 
>> qup_i2c_dev *qup, struct i2c_msg *msg,
>>  			goto desc_err;
>>  		}
>> 
>> -		if (rx_buf)
>> -			writel(QUP_BAM_INPUT_EOT,
>> -			       qup->base + QUP_OUT_FIFO_BASE);
>> -
>> -		writel(QUP_BAM_FLUSH_STOP, qup->base + QUP_OUT_FIFO_BASE);
>> -
>>  		qup_i2c_flush(qup);
>> 
>>  		/* wait for remaining interrupts to occur */
>>  		if (!wait_for_completion_timeout(&qup->xfer, HZ))
>>  			dev_err(qup->dev, "flush timed out\n");
>> 
>> -		qup_i2c_rel_dma(qup);
>> -
> 
> So this really only works due to the previous patch that adds the 
> flush/eot tags
> to all of the read messages.  If the answer to the previous question is 
> that
> only the last read message gets the eot/flush, then this code needs to 
> remain in
> place.  Otherwise, it's fine.
> 
> 
> Andy

   Thanks Andy,

   We need to schedule EOT/FLUSH after last message.
   For following transfer

   READ, READ, WRITE (FLUSH + EOT tags after that)

   In this case, FLUSH will clear all the descriptors till WRITE and 
trigger TX
   completion. EOT will be copied in RX FIFO and trigger RX completion.

   Thanks,
   Abhishek

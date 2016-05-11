From: Abhishek Sahu <absahu@codeaurora.org>
Subject: RE: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
Date: Wed, 11 May 2016 23:04:17 +0530
Message-ID: <934365f2bd30f242d8548e2a27483679@codeaurora.org>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
 <000701d1ab9d$df9b3100$9ed19300$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56384 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcEKReT (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 13:34:19 -0400
In-Reply-To: <000701d1ab9d$df9b3100$9ed19300$@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan <sricharan@codeaurora.org>
Cc: agross@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wsa@the-dreams.de

On 2016-05-11 21:27, Sricharan wrote:
> Hi,
> 
>> 1. Current QCOM I2C driver hangs when sending data to address 
>> 0x03-0x07
>> in some scenarios. The QUP controller generates invalid write in this
>> case,
>> since these addresses are reserved for different bus formats.
>> 
>> 2. Also, the error handling is done by I2C QUP ISR in the case of DMA
>> mode.
>> The state need to be RESET in case of any error for clearing the 
>> available
>> data in FIFO, which otherwise leaves the BAM DMA controller in hang 
>> state.
>> 
>> This patch fixes the above two issues by clearing the error bits from 
>> I2C
>> and
>> QUP status in ISR in case of I2C error, QUP error and resets the QUP 
>> state
>> to
>> clear the FIFO data.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qup.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qup.c 
>> b/drivers/i2c/busses/i2c-qup.c
>> index
>> 23eaabb..8c2f1bc 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -213,14 +213,16 @@ static irqreturn_t qup_i2c_interrupt(int irq, 
>> void
>> *dev)
>>  	bus_err &= I2C_STATUS_ERROR_MASK;
>>  	qup_err &= QUP_STATUS_ERROR_FLAGS;
>> 
>> -	if (qup_err) {
>> -		/* Clear Error interrupt */
>> +	/* Clear the error bits in QUP_ERROR_FLAGS */
>> +	if (qup_err)
>>  		writel(qup_err, qup->base + QUP_ERROR_FLAGS);
>> -		goto done;
>> -	}
>> 
>> -	if (bus_err) {
>> -		/* Clear Error interrupt */
>> +	/* Clear the error bits in QUP_I2C_STATUS */
>> +	if (bus_err)
>> +		writel(bus_err, qup->base + QUP_I2C_STATUS);
>> +
>> +	/* Reset the QUP State in case of error */
>> +	if (qup_err || bus_err) {
>>  		writel(QUP_RESET_STATE, qup->base + QUP_STATE);
>>  		goto done;
>>  	}
>        In qup_i2c_xfer and qup_i2c_xfer_v2 state is set to RESET at the 
> end, when
>        there is no error. So would it be fine if we do it there 
> unconditionally ?
> 
> Regards,
>  Sricharan

RESET the QUP state wouldn't create any issue in the case of multiple 
calls.
The existing code also RESET the QUP state for bus_err but it is not 
clearing
status bits.

-- 
Abhishek Sahu

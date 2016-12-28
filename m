From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v5 2/7] i2c: designware: refactoring of the i2c-designware
Date: Wed, 28 Dec 2016 15:30:51 +0000
Message-ID: <21f7135c-7848-0c4c-7188-b1b389c9a168@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
 <0dbbce3bb2ffd47d5a78ea49f992b48d7ea2f35d.1482934380.git.lolivei@synopsys.com>
 <1482937968.9552.159.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:43260 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbcL1Pa6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Dec 2016 10:30:58 -0500
In-Reply-To: <1482937968.9552.159.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 28-Dec-16 15:12, Andy Shevchenko wrote:
> On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
>> - Factor out all _master() part of code from i2c-designware-core
>>   and i2c-designware-platdrv to separate functions.
>> - Standardize all code related with MASTER mode.
>> - I have to take off DW_IC_INTR_TX_EMPTY from DW_IC_INTR_DEFAULT_MASK
>>   because it is master specific.
>>
>> The purpose of this is to prepare the controller to have is I2C MASTER
>> flow in a separate driver. To do this first all the
>> functions/definitions related to the MASTER flow were identified.
> 
> Thanks for an update.
> Some style related comments below (For the code related is up to you, my
> tag still stands).
> 
>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> ---
>> Changes V4->V5: (ACK by Andy)
> 
> When you get an Ack, or other tag (Reviewed-by, Tested-by, etc), and you
> send new version, include this tag to your commit message (it applies to
> all affected patches in your series).
> 

Thank you. I didn't knew.

> It would be also good to have some high level changelog in the cover
> letter, from this series I don't see, for example, which base you did
> use (i2c-next? linux-next? v4.9? v4.10-rc1?).
> 
>> +       dev_dbg(dev->dev,
>> +               "%s: enabled=%#x stat=%#x\n", __func__, enabled,
> stat);
> 
> I hope you can fit format string on the first line. __func__ is
> redundant when you are using debug printing (Dynamic Debug would include
> it if asked for).

I will check that.

> 
>> +static void i2c_dw_configure_master(struct platform_device *pdev)
>> +{
>> +	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> 
> By the way, does it make sense to pass struct dw_i2c_dev * as a
> parameter of the function?
> 

Yes, by looking at it now I think I can pass just the struct dw_i2c_dev
to this function. And probably the same with the i2c_dw_configure_slave.

>> +
>> +	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE
>> |
>> +			  DW_IC_CON_RESTART_EN;
>> +
>> +	dev_dbg(&pdev->dev, "I am registed as a I2C Master!\n");
>> +
>> +	switch (dev->clk_freq) {
>> +	case 100000:
>> +		dev->master_cfg |= DW_IC_CON_SPEED_STD;
>> +		break;
>> +	case 3400000:
>> +		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
>> +		break;
>> +	default:
>> +		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
>> +	}
>> +}
>> +
>>
> 
> 

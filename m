From: arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [v1] i2c: busses: i2c-designware-pcidrv:- Handle return NULL
 error from pcim_iomap_table
Date: Thu, 22 Dec 2016 22:41:12 +0530
Message-ID: <b2999ca1-f4eb-f482-ed53-796b39798ab1@gmail.com>
References: <1482406759-13094-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1482417309.9552.128.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36809 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762052AbcLVRLS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Dec 2016 12:11:18 -0500
In-Reply-To: <1482417309.9552.128.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jarkko.nikula@linux.intel.com, wsa@the-dreams.de
Cc: mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Yes, It will not fail. Sorry for the noise.

Thanks
-Arvind

On Thursday 22 December 2016 08:05 PM, Andy Shevchenko wrote:
> On Thu, 2016-12-22 at 17:09 +0530, Arvind Yadav wrote:
>> Here, If pcim_iomap_table will fail. It will return NULL.
>> Kernel can run into a NULL-pointer dereference.
>> This error check will avoid NULL pointer dereference.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-pcidrv.c |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
>> b/drivers/i2c/busses/i2c-designware-pcidrv.c
>> index d6423cf..6a1907d 100644
>> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
>> @@ -235,6 +235,10 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>>   	dev->controller = controller;
>>   	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>>   	dev->base = pcim_iomap_table(pdev)[0];
>> +	if (!dev->base) {
>> +		dev_err(&pdev->dev, "I/O map table allocation
>> failed\n");
>> +		return -ENOMEM;
>> +	}
> NAK.
>
>

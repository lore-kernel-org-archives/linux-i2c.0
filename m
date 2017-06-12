From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: ismt: fix wrong device address when unmap the data
 buffer
Date: Mon, 12 Jun 2017 11:28:29 +0200
Message-ID: <3d211ade-77e8-0ec7-582b-085686ddd4c1@axentia.se>
References: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
 <CAHp75VewOMddhFDYim1kBF1XpxZGbVA557wTpBg10LYewf2Otg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:45412
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751984AbdFLJ2i (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Jun 2017 05:28:38 -0400
In-Reply-To: <CAHp75VewOMddhFDYim1kBF1XpxZGbVA557wTpBg10LYewf2Otg@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Song liwei <liwei.song@windriver.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 2017-06-12 11:11, Andy Shevchenko wrote:
> On Mon, Jun 12, 2017 at 6:42 AM, Song liwei <liwei.song@windriver.com> wrote:
>> From: Liwei Song <liwei.song@windriver.com>
>>
> 
>> Fix the following calltrace:
> 
> No, you don't fix a call trace, you are fixing a bug.
> 
>> This happen When run "i2cdetect -y 0" detect SMBus iSMT adapter.
>>
>> After finished I2C block read/write, when unmap the data buffer,
>> a wrong device address was pass to dma_unmap_single(),
> 
> 
>> the right
>> device address should be "dev" not "&adap->dev", the relation is
>> *(&adap->dev) == dev.
> 
> This is confusing. You are telling that there are two copies of struct
> device here?

Yes, there are two copies. There's the local dev variable that is like
this:
	struct device *dev = &priv->pci_dev->dev;

And then there's the adapter device in adap->dev (inlined in adap, so
the explanation that the relations is "*(&adap->dev) == dev" is doubly
wrong).

The bug is that the first argument to dma_unmap_single is not the
same as the first argument to dma_map_single that appears a few lines
up. I cannot tell if that argument should be "dev" or "&adap->dev"
though, but the two calls must refer to the same struct device *.

Cheers,
peda

> Otherwise if one is a pointer to the real struct device, there
> shouldn't be a problem.
> 
>>  When come into Intel IOMMU routine, the wrong
>> devices address was operated.
> 
> This basically duplicates what you have said previously.
> 
>> To fix this, give dma_unmap_single() the "dev" parameter, just like
>> what dma_map_single() does, then unmap can find the right devices.
> 
> Fix per se looks good, explanation is confusing.
> 
>>
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>> ---
>>  drivers/i2c/busses/i2c-ismt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
>> index 1db3e0d..605d44e 100644
>> --- a/drivers/i2c/busses/i2c-ismt.c
>> +++ b/drivers/i2c/busses/i2c-ismt.c
>> @@ -585,7 +585,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
>>
>>         /* unmap the data buffer */
>>         if (dma_size != 0)
>> -               dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
>> +               dma_unmap_single(dev, dma_addr, dma_size, dma_direction);
>>
>>         if (unlikely(!time_left)) {
>>                 dev_err(dev, "completion wait timed out\n");
>> --
>> 2.7.4
>>
> 
> 
> 

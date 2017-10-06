From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v3 4/4] i2c: designware: add i2c gpio recovery option
Date: Fri, 6 Oct 2017 13:56:35 +0800
Message-ID: <d4432f21-c5f2-429d-5078-1e9b592a89b9@electromag.com.au>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
 <1504073857-122449-5-git-send-email-preid@electromag.com.au>
 <ec3abe75-ff3d-8e19-3f7b-08f822e654e4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:52838 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750732AbdJFF4h (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 6 Oct 2017 01:56:37 -0400
In-Reply-To: <ec3abe75-ff3d-8e19-3f7b-08f822e654e4@linux.intel.com>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On 28/09/2017 21:21, Jarkko Nikula wrote:
> On 08/30/2017 09:17 AM, Phil Reid wrote:
>> From: Tim Sander <tim@krieglstein.org>
>>
>> This patch contains much input from Phil Reid and has been tested
>> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
>> SCL and SDA GPIO's. I am still a little unsure about the recover
>> in the timeout case (i2c-designware-core.c:770) as i could not
>> test this codepath.
>>
>> Signed-off-by: Tim Sander <tim@krieglstein.org>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>   drivers/i2c/busses/i2c-designware-common.c | 11 ++++--
>>   drivers/i2c/busses/i2c-designware-core.h   |  1 +
>>   drivers/i2c/busses/i2c-designware-master.c | 57 ++++++++++++++++++++++++++++++
>>   3 files changed, 66 insertions(+), 3 deletions(-)
>>
> While taking into account Andy's comments please modify the last sentence in the above commit log - i2c-designware-core.c doesn't exist anymore. Maybe better is 
> to have the uncertainty documented as a "REVISIT:" comment in the code etc.
> 
>> @@ -254,9 +258,10 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
>>       for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
>>           dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
>> -    if (abort_source & DW_IC_TX_ARB_LOST)
>> +    if (abort_source & DW_IC_TX_ARB_LOST) {
>> +        i2c_recover_bus(&dev->adapter);
> 
> Are you sure about doing recovery for arbitration lost case? To me it seems wrong to do it if another master is accessing the bus.
> 
yes I think your right.

-- 
Regards
Phil Reid

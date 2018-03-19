From: Abhishek Sahu <absahu@codeaurora.org>
Subject: Re: [PATCH v2 01/13] i2c: qup: fix copyrights and update to SPDX
 identifier
Date: Mon, 19 Mar 2018 11:51:26 +0530
Message-ID: <15dd51f21a42504bdff810704adb97ac@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <1520860502-14886-2-git-send-email-absahu@codeaurora.org>
 <20180317203349.gfgwex3x3jaswuo5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180317203349.gfgwex3x3jaswuo5@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-18 02:03, Wolfram Sang wrote:
> On Mon, Mar 12, 2018 at 06:44:50PM +0530, Abhishek Sahu wrote:
>> The file has been updated from 2016 to 2018 so fixed the
>> copyright years.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qup.c | 13 ++-----------
>>  1 file changed, 2 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qup.c 
>> b/drivers/i2c/busses/i2c-qup.c
>> index 08f8e01..ac5edfa 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -1,17 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>> - * Copyright (c) 2009-2013, The Linux Foundation. All rights 
>> reserved.
>> + * Copyright (c) 2009-2013, 2016-2018, The Linux Foundation. All 
>> rights reserved.
> 
> Can we do this? I know that CodeAurora is hosted by LF, but can you
> extend their copyright when working for Qualcomm?
> 

  Thanks Wolfram.

  Qualcomm does not uses its own copyright for open source and uses
  LF copyright only.

  Following is the downstream version available in CAF
  for the same i2c-qup.c file in which the LF copyright has
  already extended.

  
https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-msm/tree/drivers/i2c/busses/i2c-qup.c?h=eggplant

  Regards,
  Abhishek


>>   * Copyright (c) 2014, Sony Mobile Communications AB.
>>   *
>> - *
>> - * This program is free software; you can redistribute it and/or 
>> modify
>> - * it under the terms of the GNU General Public License version 2 and
>> - * only version 2 as published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>>   */
>> 
>>  #include <linux/acpi.h>
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member of Code Aurora Forum, hosted by The Linux Foundation
>> 

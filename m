From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: Accelometer data not changes
Date: Mon, 22 May 2017 09:34:07 +0200
Message-ID: <57c772a7-8e59-c2a7-2c9e-91674f51bf35@gmail.com>
References: <b9234130-1af6-738f-a174-379d441caedf@gmail.com>
 <eb2166ea-ba3a-635c-49bc-583ebc9cb4dd@gmail.com>
 <18bd3103-c560-9a87-4df7-b1786ce91f8c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35862 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdEVHeM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 03:34:12 -0400
Received: by mail-lf0-f68.google.com with SMTP id h4so4525058lfj.3
        for <linux-i2c@vger.kernel.org>; Mon, 22 May 2017 00:34:12 -0700 (PDT)
In-Reply-To: <18bd3103-c560-9a87-4df7-b1786ce91f8c@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, lorenzo.pieralisi@arm.com
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, srinivas.pandruvada@intel.com, linux-i2c@vger.kernel.org, ard.biesheuvel@linaro.org, wsa@the-dreams.de

Hi

On 22.05.2017 08:47, Jarkko Nikula wrote:
> Hi
>
> On 05/21/2017 07:06 PM, Arek Burdach wrote:
>> Hi Lorenzo,
>>
>> I wanted to check if your newest fix
>> 9d6408433019bfae15e2d0d5f4498c4ff70b86c0 resolved my problem but it
>> looks like it breaks i2c devices on yoga 910 at all.
>>
>> One thing that I see in dmesg is:
>> [    5.443582] i2c_designware i2c_designware.1: controller timed out
>> [    5.443601] i2c_hid i2c-SYNA2B31:00: hid_descr_cmd failed
>> [    6.595650] i2c_designware i2c_designware.2: controller timed out
>> [    6.595673] i2c_hid i2c-ITE8186:00: hid_descr_cmd failed
>>
>> More details you can see in mentioned isssue.
>> BTW maybe you have an idea what is the root of my problem. I've attached
>> i2c_hid logs for previous version.
>>
> Commit 9d6408433019 ("i2c: designware: don't infer timings described 
> by ACPI from clock rate") had issue with uninitialized variables that 
> show up when ACPI platform doesn't provide timing parameters for the 
> I2C but fortunately that was caught quickly.
>
> Could you try does a patch from Jan Kiszka fix the issue you are seeing?
>
> https://lkml.org/lkml/2017/5/22/24
I've tried and it looks like it removed this regression but still all of 
this changes didn't helped for my problem with missing changes from 
accelometer.

Maybe you can take a look at isc_hid log after all of those changes: 
https://bugzilla.kernel.org/attachment.cgi?id=256651 and tell me if you 
see something worrying?

BTW sorry for invalid mailing list - changed

Cheers,
Arek

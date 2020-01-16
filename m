From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 26/26] docs: i2c: rename sections so the overall picture
 is clearer
Date: Thu, 16 Jan 2020 11:38:19 +0100
Message-ID: <7809c0c2-1d83-cc95-b258-644ea8315f86@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200106074905.14438-1-luca@lucaceresoli.net>
 <20200116104907.3f2de4d0@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35416 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgAPKiX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Jan 2020 05:38:23 -0500
In-Reply-To: <20200116104907.3f2de4d0@endymion>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org

Hi Jean, Peter,

thanks both for your reviews.

On 16/01/20 10:49, Jean Delvare wrote:
> On Mon,  6 Jan 2020 08:49:05 +0100, Luca Ceresoli wrote:
>> Some of the section names are not very clear. Reading those names in the
>> index.rst page does not help much in grasping what the content is supposed
>> to be.
>>
>> Rename those sections to clarify their content, especially when reading
>> the index page.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Acked-by: Peter Rosin <peda@axentia.se>
>> ---
>>
>> Note: here checkpatch complains:
>>
>>   WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>>
>> Thas's because those files have no license line. I would gladly add a
>> proper license line, but what it the correct license here? Should I ask the
>> authors? GPLv2-only as the kernel default?
>>
>> I'd appreciate a guidance here, thanks in advance.
> 
> I don't think we need a license for such documentation files, so I
> would just ignore checkpatch.

That's OK for me.

>> diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
>> index fc69d9567d9d..ae3bbb9fd8f1 100644
>> --- a/Documentation/i2c/summary.rst
>> +++ b/Documentation/i2c/summary.rst
>> @@ -1,6 +1,6 @@
>> -=============
>> -I2C and SMBus
>> -=============
>> +==============================
>> +Introductions to I2C and SMBus
>> +==============================
> 
> I would use "Introduction", singular.

Me too! Fix queued for v2.

Peter, I assume I can keep your Acked-by in v2 with this small change.

-- 
Luca

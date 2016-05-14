From: Crestez Dan Leonard <cdleonard@gmail.com>
Subject: Re: [PATCH i2c-tools] i2cget: Add support for i2c block data
Date: Sat, 14 May 2016 14:30:02 +0300
Message-ID: <93dcb82b-b04e-4b3c-1868-2a4fe4a086c8@gmail.com>
References: <044b3af6a47dfa92e047f0ff57e39a5b61e00058.1463165295.git.leonard.crestez@intel.com>
 <5736738D.3020909@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34044 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbcENLaG (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 14 May 2016 07:30:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so8489196wmn.1
        for <linux-i2c@vger.kernel.org>; Sat, 14 May 2016 04:30:05 -0700 (PDT)
In-Reply-To: <5736738D.3020909@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Crestez Dan Leonard <leonard.crestez@intel.com>, linux-i2c@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>

On 05/14/2016 03:38 AM, Guenter Roeck wrote:
> On 05/13/2016 11:54 AM, Crestez Dan Leonard wrote:
>> This adds mode 'i' for I2C_SMBUS_I2C_BLOCK_DATA. This is the same mode
>> letter from i2cdump.
>>
>> Length is optional and defaults to 32 (maximum).
>>
>> The indended use is debugging i2c devices with shell commands.
>>
> How does this differ from the 'i' option of i2cdump ?

Apparently i2cdump doesn't support a range in "i" mode. I considered 
adding a range to i2cdump in all modes but:
- i2cdump code is a more complicated
- Not all devices interpret i2c bulk read as a register range. Reading X 
bytes from register Y can be different from reading registers from X to X+Y.

-- 
Regards,
Leanard

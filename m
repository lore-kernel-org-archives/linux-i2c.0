From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH i2c-tools] i2cget: Add support for i2c block data
Date: Mon, 16 May 2016 14:39:17 +0300
Message-ID: <5739B165.50801@intel.com>
References: <044b3af6a47dfa92e047f0ff57e39a5b61e00058.1463165295.git.leonard.crestez@intel.com>
 <5736738D.3020909@roeck-us.net>
 <93dcb82b-b04e-4b3c-1868-2a4fe4a086c8@gmail.com>
 <57373FD5.5070603@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:19293 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbcEPLjm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 May 2016 07:39:42 -0400
In-Reply-To: <57373FD5.5070603@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>

On 05/14/2016 06:10 PM, Guenter Roeck wrote:
> On 05/14/2016 04:30 AM, Crestez Dan Leonard wrote:
>> On 05/14/2016 03:38 AM, Guenter Roeck wrote:
>>> On 05/13/2016 11:54 AM, Crestez Dan Leonard wrote:
>>>> This adds mode 'i' for I2C_SMBUS_I2C_BLOCK_DATA. This is the same mode
>>>> letter from i2cdump.
>>>>
>>>> Length is optional and defaults to 32 (maximum).
>>>>
>>>> The indended use is debugging i2c devices with shell commands.
>>>>
>>> How does this differ from the 'i' option of i2cdump ?
>>
>> Apparently i2cdump doesn't support a range in "i" mode. I considered
>> adding a range to i2cdump in all modes but:
>> - i2cdump code is a more complicated
> 
> Maybe, but it already supports the command.
> 
>> - Not all devices interpret i2c bulk read as a register range. Reading
>> X bytes from register Y can be different from reading registers from X
>> to X+Y.
>>
> Not sure I understand what that has to do with supporting i2c block data.
> Both commands call i2c_smbus_read_i2c_block_data(). Please explain.

I just found it easier to implement this as an extension to i2cget
rather than add range support to i2cdump 'i' mode. I also think it's a
better fit for i2cget because the "length" parameter doesn't always
imply a register range.

As to how this is useful: I have an i2c sensor where new data can come
in while the driver is still reading and this will prevent further
interrupts. I can confirm this by issuing a command like:

    i2cget -f -y 0 0x18 0xa8 i 6

This bulk read of 6 bytes will unlock the driver for a short while.

This can't be done with current i2cdump's 'i' mode because that just
dumps all registers. i2cdump's byte/word modes issue multiple reads
which is not fast enough.

-- 
Regards,
Leonard

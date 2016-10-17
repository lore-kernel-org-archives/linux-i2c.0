From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Mon, 17 Oct 2016 15:38:06 +0300
Message-ID: <63a30963-9ac4-15df-5130-bb72e74d7f51@linux.intel.com>
References: <20161011131327.0eabd227@endymion>
 <eb3c0e91-5744-3b49-515e-dd68ed5d88aa@linux.intel.com>
 <20161011202045.43787f2e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:64722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934840AbcJQMiJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 17 Oct 2016 08:38:09 -0400
In-Reply-To: <20161011202045.43787f2e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi

On 10/11/2016 09:20 PM, Jean Delvare wrote:
>>> Jarkko, still no information about this from your Windows or hardware
>>> folks?
>>
>> No update, in fact some of the contacts have left the company :-(
>
> What do we do then? Without this patch, I2C Block Read doesn't work at
> all on recent chipsets. I don't think it can be worse with the patch.
> And it works fine on the few machines I tested on. So I would like this
> patch to go upstream.
>
> My coverage is limited though. Did anyone at Intel test this patch on
> other (recent) systems?
>
Sorry the delay. I have only handful of machine that have on-board 
EEPROM connected to SMBUS in our lab and they are relatively new so only 
limited testing from my side.

In fact those had the SPD Write Disable set so attempt to use kernel's 
at24 driver didn't register the EEPROM at all without your patch since 
one-byte test read in drivers/misc/eeprom/at24.c: at24_probe() failed.

echo "24c02 0x56" >/sys/bus/i2c/devices/i2c-0/new_device

With your patch at24 probes and I can dump the 0xff content (I guess 
it's unprogrammed) with the hexdump:

hexdump -C /sys/bus/i2c/devices/i2c-0/0-0056/eeprom

I think we are better to have this patch as we know it makes things 
better. I'll add my tested-by to your patch with one comment.

-- 
Jarkko

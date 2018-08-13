From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/2] i2c: core: ACPI: Properly set status byte to 0 for
 multi-byte writes
Date: Mon, 13 Aug 2018 10:44:27 +0200
Message-ID: <e7cb34af-4e4d-866e-996f-07d3eb490ed6@redhat.com>
References: <20180812105321.2668-1-hdegoede@redhat.com>
 <9d9abf08-7112-5eb9-f5e8-493baba17034@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <9d9abf08-7112-5eb9-f5e8-493baba17034@axentia.se>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 12-08-18 22:39, Peter Rosin wrote:
> On 2018-08-12 12:53, Hans de Goede wrote:
>> acpi_gsb_i2c_write_bytes() returns i2c_transfer()'s return value, which
>> is the number of transfers executed on success, so 1.
>>
>> The ACPI code expects us to store 0 in gsb->status for success, not 1.
>>
>> Specifically this breaks the following code in the Thinkpad 8 DSDT:
>>
>>              ECWR = I2CW = ECWR /* \_SB_.I2C1.BAT0.ECWR */
>>              If ((ECST == Zero))
>>              {
>>                  ECRD = I2CR /* \_SB_.I2C1.I2CR */
>>              }
>>
>> Before this commit we set ECST to 1, causing the read to never happen
>> breaking battery monitoring on the Thinkpad 8.
>>
>> This commit makes acpi_gsb_i2c_write_bytes() return 0 when i2c_transfer()
>> returns 1, so the single write transfer completed successfully, and
>> makes it return -EIO on for other (unexpected) return values >= 0.
> 
> I'm wondering if this might be fallout from one of
> 35cd67a0caf7 ("i2c: viperboard: return message count on master_xfer success")
> de9a8634f1cb ("i2c: pmcmsp: return message count on master_xfer success")

No, these are using the designware driver, so these commits are not
the cause, this simply is a long standing bug.

Regards,

Hans

From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/2] i2c: core: ACPI: Properly set status byte to 0 for
 multi-byte writes
Date: Sun, 12 Aug 2018 22:39:33 +0200
Message-ID: <9d9abf08-7112-5eb9-f5e8-493baba17034@axentia.se>
References: <20180812105321.2668-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180812105321.2668-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-08-12 12:53, Hans de Goede wrote:
> acpi_gsb_i2c_write_bytes() returns i2c_transfer()'s return value, which
> is the number of transfers executed on success, so 1.
> 
> The ACPI code expects us to store 0 in gsb->status for success, not 1.
> 
> Specifically this breaks the following code in the Thinkpad 8 DSDT:
> 
>             ECWR = I2CW = ECWR /* \_SB_.I2C1.BAT0.ECWR */
>             If ((ECST == Zero))
>             {
>                 ECRD = I2CR /* \_SB_.I2C1.I2CR */
>             }
> 
> Before this commit we set ECST to 1, causing the read to never happen
> breaking battery monitoring on the Thinkpad 8.
> 
> This commit makes acpi_gsb_i2c_write_bytes() return 0 when i2c_transfer()
> returns 1, so the single write transfer completed successfully, and
> makes it return -EIO on for other (unexpected) return values >= 0.

I'm wondering if this might be fallout from one of
35cd67a0caf7 ("i2c: viperboard: return message count on master_xfer success")
de9a8634f1cb ("i2c: pmcmsp: return message count on master_xfer success")

But I have no idea what i2c driver these Thinkpads are using, so it is not
unlikely that I'm way off...

Cheers,
Peter

> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Modify the value which acpi_gsb_i2c_write_bytes() returns instead of
>  checking + modifying the return value in its caller

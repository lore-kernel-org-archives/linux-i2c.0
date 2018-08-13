From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/2] i2c: core: ACPI: Properly set status byte to 0
 for multi-byte writes
Date: Mon, 13 Aug 2018 12:38:37 +0300
Message-ID: <20180813093837.GY2343@lahna.fi.intel.com>
References: <20180812105321.2668-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180812105321.2668-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Aug 12, 2018 at 12:53:20PM +0200, Hans de Goede wrote:
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
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

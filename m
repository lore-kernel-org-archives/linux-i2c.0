From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: core: ACPI: Properly set status byte to 0 for
 multi-byte writes
Date: Fri, 10 Aug 2018 15:35:24 +0300
Message-ID: <20180810123524.GU2343@lahna.fi.intel.com>
References: <20180810122714.690-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810122714.690-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 10, 2018 at 02:27:14PM +0200, Hans de Goede wrote:
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
> breaking battery monitoring on the Thinkpad 8. Note the Thinkpad 8 also
> has some unrelated issues where i2c transfers are unreliable.
> 
> This commit sets status to 0 if it was bigger then 0 (so success),
> mirroring the multi-byte read path, fixing this.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

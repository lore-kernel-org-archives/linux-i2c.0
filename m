From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: don't infer timings described by ACPI
 from clock rate
Date: Fri, 19 May 2017 13:01:24 +0300
Message-ID: <ab57959e-7c00-7f92-8631-5204685c719c@linux.intel.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16932 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdESKB2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 May 2017 06:01:28 -0400
In-Reply-To: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, lorenzo.pieralisi@arm.com
Cc: linux-arm-kernel@lists.infradead.org

On 05/19/2017 11:56 AM, Ard Biesheuvel wrote:
> Commit bd698d24b1b57 ("i2c: designware: Get selected speed mode
> sda-hold-time via ACPI") updated the logic that reads the timing
> parameters for various I2C bus rates from the DSDT, to only read
> the timing parameters for the currently selected mode.
>
> This causes a WARN_ON() splat on platforms that legally omit the clock
> frequency from the ACPI description, because in the new situation, the
> core I2C designware driver still accesses the fields in the driver
> struct that we no longer populate, and proceeds to calculate them from
> the clock frequency. Since the clock frequency is unspecified, the
> driver complains loudly using a WARN_ON().
>
> So revert back to the old situation, where the struct fields for all
> timings are populated, but retain the new logic which chooses the SDA
> hold time from the timing mode that is currently in use.
>
> Fixes: bd698d24b1b57 ("i2c: designware: Get selected speed mode ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
Thanks, this is ok to me. Let's add also kudos to Lorenzo:

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

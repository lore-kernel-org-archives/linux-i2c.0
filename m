From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/2] i2c: designware: Never suspend i2c-busses used for
 accessing the system PMIC
Date: Thu, 9 Mar 2017 16:24:22 +0200
Message-ID: <728a5859-c4fe-b22c-0dd2-94c48e131134@linux.intel.com>
References: <20170308084713.4815-1-hdegoede@redhat.com>
 <20170308084713.4815-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25956 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754816AbdCIOZL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 09:25:11 -0500
In-Reply-To: <20170308084713.4815-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

On 03/08/17 10:47, Hans de Goede wrote:
> Currently we are already setting a pm_runtime_disabled flag and disabling
> runtime-pm for i2c-busses used for accessing the system PMIC on x86.
> But this is not enough, there are ACPI opregions which may want to access
> the PMIC during late-suspend and early-resume, so we need to completely
> disable pm to be safe.
>
> This commit renames the flag from pm_runtime_disabled to pm_disabled and
> adds the following new behavior if the flag is set:
>
> 1) Call dev_pm_syscore_device(dev, true) which disables normal suspend /
>    resume and remove the pm_runtime_disabled check from dw_i2c_plat_resume
>    since that will now never get called. This fixes suspend_late handlers
>    which use ACPI PMIC opregions causing errors like these:
>
>   PM: Suspending system (freeze)
>   PM: suspend of devices complete after 1127.751 msecs
>   i2c_designware 808622C1:06: timeout waiting for bus ready
>   ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>   acpi 80860F14:02: Failed to change power state to D3hot
>   PM: late suspend of devices failed
>
> 2) Set IRQF_NO_SUSPEND irq flag. This fixes resume_early handlers which
>    handlers which use ACPI PMIC opregions causing errors like these:
>
>   PM: resume from suspend-to-idle
>   i2c_designware 808622C1:06: controller timed out
>   ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c |  2 +-
>  drivers/i2c/busses/i2c-designware-core.c     | 11 +++++++++--
>  drivers/i2c/busses/i2c-designware-core.h     |  4 ++--
>  drivers/i2c/busses/i2c-designware-platdrv.c  | 10 ++++------
>  4 files changed, 16 insertions(+), 11 deletions(-)
>

Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit PMIC bus semaphore code
Date: Thu, 18 Oct 2018 10:38:10 +0200
Message-ID: <1830775.U1JO56g8nO@aspire.rjw.lan>
References: <20180923144510.4564-1-hdegoede@redhat.com> <CAJZ5v0iu5eikTw3wOK7wHOVe+xHTv5xPTnQELEyA2oF8sL3S=g@mail.gmail.com> <3f72c40f-9751-f74e-2e71-7f9edc7bc115@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f72c40f-9751-f74e-2e71-7f9edc7bc115@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, October 18, 2018 10:34:57 AM CEST Hans de Goede wrote:
> Hi,
> 
> On 18-10-18 09:29, Rafael J. Wysocki wrote:
> > On Sun, Sep 23, 2018 at 4:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> On some BYT/CHT systems the SoC's P-Unit shares the I2C bus with the
> >> kernel. The P-Unit has a semaphore for the PMIC bus which we can take to
> >> block it from accessing the shared bus while the kernel wants to access it.
> >>
> >> Currently we have the I2C-controller driver acquiring and releasing the
> >> semaphore around each I2C transfer. There are 2 problems with this:
> >>
> >> 1) PMIC accesses often come in the form of a read-modify-write on one of
> >> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
> >> between the read and the write. If the P-Unit modifies the register during
> >> this window?, then we end up overwriting the P-Unit's changes.
> >> I believe that this is mostly an academic problem, but I'm not sure.
> >>
> >> 2) To safely access the shared I2C bus, we need to do 3 things:
> >> a) Notify the GPU driver that we are starting a window in which it may not
> >> access the P-Unit, since the P-Unit seems to ignore the semaphore for
> >> explicit power-level requests made by the GPU driver
> >> b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
> >> C6/C7 while we hold the semaphore hangs the SoC
> >> c) Finally take the P-Unit's PMIC bus semaphore
> >> All 3 these steps together are somewhat expensive, so ideally if we have
> >> a bunch of i2c transfers grouped together we only do this once for the
> >> entire group.
> >>
> >> Taking the read-modify-write on a PMIC register as example then ideally we
> >> would only do all 3 steps once at the beginning and undo all 3 steps once
> >> at the end.
> >>
> >> For this we need to be able to take the semaphore from within e.g. the PMIC
> >> opregion driver, yet we do not want to remove the taking of the semaphore
> >> from the I2C-controller driver, as that is still necessary to protect many
> >> other code-paths leading to accessing the shared I2C bus.
> >>
> >> This means that we first have the PMIC driver acquire the semaphore and
> >> then have the I2C controller driver trying to acquire it again.
> >>
> >> To make this possible this commit does the following:
> >>
> >> 1) Move the semaphore code from being private to the I2C controller driver
> >> into the generic iosf_mbi code, which already has other code to deal with
> >> the shared bus so that it can be accessed outside of the I2C bus driver.
> >>
> >> 2) Rework the code so that it can be called multiple times nested, while
> >> still blocking I2C accesses while e.g. the GPU driver has indicated the
> >> P-Unit needs the bus through a iosf_mbi_punit_acquire() call.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > If there are no objections or concerns regarding this patch, I'm
> > inclined to take the entire series including it.
> 
> In that case let me send out a v4, with the following chunk added to the
> 2nd patch:
> 
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -515,7 +515,7 @@ config CRC_PMIC_OPREGION
> 
>   config XPOWER_PMIC_OPREGION
>          bool "ACPI operation region support for XPower AXP288 PMIC"
> -       depends on MFD_AXP20X_I2C
> +       depends on MFD_AXP20X_I2C && IOSF_MBI
>          help
>            This config adds ACPI operation region support for XPower AXP288 PMIC.
> 
> This is necessary to avoid compilation issues on non x86 systems (where the
> asm/iosf_mbi.h header is not available) and on x86 systems in case
> IOSF_MBI support is not enabled there.  Note that the AXP288 PMIC is
> connected through the LPSS i2c controller, so either we have IOSF_MBI support
> selected through the X86_INTEL_LPSS option, or we have a kernel where the
> opregion will never work anyways.

I'd prefer to get an incremental patch for that at this point.

Thanks,
Rafael

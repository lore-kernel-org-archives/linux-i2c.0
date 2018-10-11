From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/3] x86: baytrail/cherrytrail: Rework and move P-Unit PMIC semaphore handling
Date: Thu, 11 Oct 2018 16:29:08 +0200
Message-ID: <20181011142911.13750-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

Changes in v3:
-Fix iosf_mbi_punit_mutex not being unlocked in error exit path
-Add a big comment describing the what-and-why of
 iosf_mbi_block_punit_i2c_access()

Changes in v2:
-Move mutex_unlock(&iosf_mbi_punit_mutex); to the callers of
 iosf_mbi_reset_semaphore()
-Use PCI_DEVICE_DATA() to pass the driver_data

See the commit message of the first patch for the why and what of this
series.

Also the whole purpose of posting this series for now is just to get the
first patch reviewed and merged, the others are more of a RFC until that
happens.

Once the first patch is merged we can look at using the new
iosf_mbi_[un]block_punit_i2c_access() functions in various drivers for the
AXP288 PMIC (and the TI dollarcove PMIC) to only take the P-Unit semaphore
once around a group of I2C accesses to the PMIC. The second patch is an
example of this.

The third patch is some trivial cleanup to the i2c-designware driver which
becomes possible after the first patch is merged. As mentioned in the commit
message of the first patch, that patch deliberately saves that cleanup for
later, so that it only touches i2c-designware-baytrail.c and not the main
i2c-designware*.c files, so that it can be merged through the x86 tree
without conflicts.

Wolfram can we have your ack for merging the i2c-designware-baytrail.c
changes through the x86 tree (assuming you are ok with moving all the
iosf_mbi magic out of that file into arch/x86/platform/intel/iosf_mbi.c)?

Regards,
 
Hans

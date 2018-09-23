From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] x86: baytrail/cherrytrail: Rework and move P-Unit PMIC semaphore handling
Date: Sun, 23 Sep 2018 16:45:07 +0200
Message-ID: <20180923144510.4564-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

See the commit message of the first patch for the why and what of this
series.

Also the whole purpose of posting this series for now is just to get the
first patch reviewed and merged.

Once the first patch is merged we can look at using the new
iosf_mbi_[un]block_punit_i2c_access() functions in various drivers for the
AXP288 PMIC (and the TI dollarcove PMIC) to only take the P-Unit semaphore
once around a group of i2c accesses to the PMIC. The second patch is an
example of this.

The third patch is some trivial cleanup to the i2c-designware driver which
becomes possible after the first patch is merged. As mentioned in the commit
message of the first patch, that patch deliberately saves that cleanup for
later, so that it only touches i2c-designware-baytrail.c and not the main
i2c-designware*.c files, so that it can be merged through the x86 tree
without conflicts.

Regards,

Hans

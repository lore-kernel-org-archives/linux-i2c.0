From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/5] x86/io: Rely on asm-generic/io.h
Date: Fri, 30 Jun 2017 20:09:29 +0300
Message-ID: <20170630170934.83028-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49047 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbdF3RJk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 30 Jun 2017 13:09:40 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@spreadtrum.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, intel-gfx@lists.freedesktop.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The series brings a bit of order to arch/x86/include/asm/io.h by re-using
definitions in the generic header.

The series has been tested on Intel Broxton hardware in 32- and 64-bit modes.

Since v2:
- add cleanup patches in accordance to re-use what's defined in generic header
- split to few patches
- hopefully nail down an issue kbuild bot complained about
- append tags (Wolfram)

Andy Shevchenko (5):
  x86/io: Define IO accessors by preprocessor
  x86/io: Include asm-generic/io.h to architectural code
  x86/io: Remove mem*io() duplications
  x86/io: Remove xlate_dev_kmem_ptr() duplication
  x86/io: Make readq() / writeq() API consistent

 arch/x86/include/asm/io.h | 98 +++++++++++++++++++++++------------------------
 include/asm-generic/io.h  | 27 +++++++++++++
 2 files changed, 74 insertions(+), 51 deletions(-)

-- 
2.11.0

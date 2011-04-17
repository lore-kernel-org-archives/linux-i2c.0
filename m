From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] i2c fixes for 2.6.39
Date: Sun, 17 Apr 2011 11:01:36 +0200
Message-ID: <20110417110136.71b78b85@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/algos/i2c-algo-bit.c |   22 +++++++++++++++++++---
 drivers/i2c/i2c-core.c           |    6 ++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

---------------

Alex Deucher (1):
      i2c-algo-bit: Call pre/post_xfer for bit_test

Jean Delvare (1):
      i2c: Improve deprecation warnings

Thanks,
-- 
Jean Delvare

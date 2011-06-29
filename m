From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PULL] i2c fixes for 3.0
Date: Wed, 29 Jun 2011 13:13:22 +0200
Message-ID: <20110629131322.20bf7c5f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/busses/i2c-taos-evm.c |    8 ++++----
 drivers/i2c/muxes/pca954x.c       |    7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

---------------

Jean Delvare (1):
      i2c-taos-evm: Fix log messages

Petri Gynther (1):
      i2c/pca954x: Initialize the mux to disconnected state

Thanks,
-- 
Jean Delvare

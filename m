From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 00/18] i2c: make creation of 8 bit addresses consistent
Date: Sun,  3 Apr 2016 20:44:43 +0200
Message-ID: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51888 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbcDCSpP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:15 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

This series addresses two things which have come up in the past:

* document that I2C_M_RD is bit 0. It is not good coding style but some
  drivers (and userspace) silently assume so anyhow. To avoid regressions,
  let's make that explicit.

* use one function to generate an 8 bit address (7 bit address + RW bit)
  from a struct msg. People did this in various ways, sometimes overly
  brave and sometimes overly anxious with the operator precedence. That
  was partly not nice to read and partly triggering code checkers.

The new function was tested using a Renesas Lager board with the i2c-sh_mobile
driver. Buildbot was happy with the series, too. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/8bit_macro

I'd really appreciate more tests on real HW. Also happy for other comments,
reviews...

Thanks,

   Wolfram


Wolfram Sang (18):
  i2c: guarantee that I2C_M_RD will be 0x0001 forever
  i2c: introduce helper function to get 8 bit address from a message
  i2c: core: use new 8 bit address helper function
  i2c: i2c-bcm-iproc: use new 8 bit address helper function
  i2c: i2c-bcm-kona: use new 8 bit address helper function
  i2c: i2c-brcmstb: use new 8 bit address helper function
  i2c: i2c-cpm: use new 8 bit address helper function
  i2c: i2c-ibm_iic: use new 8 bit address helper function
  i2c: i2c-img-scb: use new 8 bit address helper function
  i2c: i2c-iop3xx: use new 8 bit address helper function
  i2c: i2c-lpc2k: use new 8 bit address helper function
  i2c: i2c-mt65xx: use new 8 bit address helper function
  i2c: i2c-ocores: use new 8 bit address helper function
  i2c: i2c-powermac: use new 8 bit address helper function
  i2c: i2c-qup: use new 8 bit address helper function
  i2c: i2c-sh_mobile: use new 8 bit address helper function
  i2c: i2c-sirf: use new 8 bit address helper function
  i2c: i2c-st: use new 8 bit address helper function

 drivers/i2c/busses/i2c-bcm-iproc.c |  2 +-
 drivers/i2c/busses/i2c-bcm-kona.c  |  5 +----
 drivers/i2c/busses/i2c-brcmstb.c   |  4 +---
 drivers/i2c/busses/i2c-cpm.c       |  4 +---
 drivers/i2c/busses/i2c-ibm_iic.c   |  2 +-
 drivers/i2c/busses/i2c-img-scb.c   |  4 +---
 drivers/i2c/busses/i2c-iop3xx.c    |  5 +----
 drivers/i2c/busses/i2c-lpc2k.c     |  4 +---
 drivers/i2c/busses/i2c-mt65xx.c    |  5 +----
 drivers/i2c/busses/i2c-ocores.c    |  5 +----
 drivers/i2c/busses/i2c-powermac.c  |  4 +---
 drivers/i2c/busses/i2c-qup.c       |  2 +-
 drivers/i2c/busses/i2c-sh_mobile.c |  3 +--
 drivers/i2c/busses/i2c-sirf.c      |  4 +---
 drivers/i2c/busses/i2c-st.c        |  3 +--
 drivers/i2c/i2c-core.c             |  2 +-
 include/linux/i2c.h                |  5 +++++
 include/uapi/linux/i2c.h           | 13 +++++++------
 18 files changed, 28 insertions(+), 48 deletions(-)

-- 
2.7.0

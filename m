From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] at24 fixes for 4.15
Date: Thu, 30 Nov 2017 12:12:22 +0100
Message-ID: <20171130111222.11887-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42169 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdK3LMv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 06:12:51 -0500
Received: by mail-wm0-f67.google.com with SMTP id l141so12299288wmg.1
        for <linux-i2c@vger.kernel.org>; Thu, 30 Nov 2017 03:12:50 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Wolfram,

please consider pulling the following fixes for v4.15. While it doesn't
fix any regression introduced in the v4.15 merge window, we have a
feature in at24 since linux v4.8 - reading the mac address block from
at24mac series - which turned out to be not working.

This pull request contains changes that fix it together with a patch
that hardens the read and write argument sanitization with
out-of-bounds checks that were missing.

----------------------------------------------------------------

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-4.15-fixes-for-wolfram

for you to fetch changes up to d9bcd462daf34aebb8de9ad7f76de0198bb5a0f0:

  eeprom: at24: check at24_read/write arguments (2017-11-29 16:05:37 +0100)

----------------------------------------------------------------
AT24 fixes for v4.15

----------------------------------------------------------------
Bartosz Golaszewski (1):
      eeprom: at24: correctly set the size for at24mac402

Heiner Kallweit (2):
      eeprom: at24: fix reading from 24MAC402/24MAC602
      eeprom: at24: check at24_read/write arguments

 drivers/misc/eeprom/at24.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

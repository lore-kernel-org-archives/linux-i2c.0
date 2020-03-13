From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] at24: fix for v5.6-rc6
Date: Fri, 13 Mar 2020 16:12:46 +0100
Message-ID: <20200313151246.12356-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMPMw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 Mar 2020 11:12:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id b2so6315123wrj.10
        for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2020 08:12:49 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Wolfram,

please pull the following fix for a bug introduced during the last merge
window.

Thanks,
Bartosz

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git at24-fixes-for-v5.6-rc6

for you to fetch changes up to 58d6fee50e67bb1c69977f1a534ccb17bf58b0f1:

  misc: eeprom: at24: fix regulator underflow (2020-03-12 09:02:34 +0100)

----------------------------------------------------------------
at24 fixes for v5.6-rc6

- fix regulator underflow bug introduced during the v5.6 merge window

----------------------------------------------------------------
Michael Auchter (1):
      misc: eeprom: at24: fix regulator underflow

 drivers/misc/eeprom/at24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

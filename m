From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] at24: updates for v5.7
Date: Tue, 24 Mar 2020 09:12:53 +0100
Message-ID: <20200324081253.881-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35059 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgCXIM7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Mar 2020 04:12:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so7887909wrn.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2020 01:12:57 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Wolfram,

please pull the following change in at24 for v5.7. This time it's just
a single new ACPI ID.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-updates-for-v5.7

for you to fetch changes up to 4837621cd61e6b81a182098889143c6c9a06b0f3:

  eeprom: at24: add TPF0001 ACPI ID for 24c1024 device (2020-02-10 11:03:39 +0100)

----------------------------------------------------------------
at24 updates for v5.7

- add a new ACPI ID for 24c1024

----------------------------------------------------------------
Markus Pietrek (1):
      eeprom: at24: add TPF0001 ACPI ID for 24c1024 device

 drivers/misc/eeprom/at24.c | 1 +
 1 file changed, 1 insertion(+)

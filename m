From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] at24: updates for v5.6
Date: Fri, 24 Jan 2020 17:46:44 +0100
Message-ID: <20200124164644.20020-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40902 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbgAXQqu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Jan 2020 11:46:50 -0500
Received: by mail-wm1-f42.google.com with SMTP id t14so94181wmi.5
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jan 2020 08:46:49 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Wolfram,

I'm sorry for the late PR. I was (still am actually) OoO for family
reasons. I hope you can still pull this for the next merge window.

This time the release is pretty big for this driver. We have moved the
support for write-protect pin control into the core nvmem library so that
all nvmem users can use it automatically. All nvmem changes were acked by
Srinivas and have been in next for some time. The DT binding document for
at25 was updated and the patch was acked by Greg KH. The driver also now
supports regulator control and has suspend/resume callbacks.

Best regards,
Bartosz

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git at24-updates-for-v5.6

for you to fetch changes up to cd5676db0574cc1c0b234bc3b17565b07290aa72:

  misc: eeprom: at24: support pm_runtime control (2020-01-23 12:52:57 +0100)

----------------------------------------------------------------
at24 updates for linux v5.6

- minor maintenance: update the license tag, sort headers
- move support for the write-protect pin into nvmem core
- add a reference to the new wp-gpios property in nvmem to at25 bindings
- add support for regulator and pm_runtime control

----------------------------------------------------------------
Bartosz Golaszewski (3):
      eeprom: at24: update the license tag
      eeprom: at24: sort headers alphabetically
      nvmem: fix a 'makes pointer from integer without a cast' build warning

Bibby Hsieh (2):
      dt-binding: eeprom: at24: add vcc-supply property
      misc: eeprom: at24: support pm_runtime control

Khouloud Touil (5):
      dt-bindings: nvmem: new optional property wp-gpios
      nvmem: add support for the write-protect pin
      dt-bindings: at24: make wp-gpios a reference to the property defined by nvmem
      eeprom: at24: remove the write-protect pin support
      dt-bindings: at25: add reference for the wp-gpios property

 Documentation/devicetree/bindings/eeprom/at24.yaml |  9 +--
 Documentation/devicetree/bindings/eeprom/at25.txt  |  2 +
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 11 ++++
 drivers/misc/eeprom/at24.c                         | 72 +++++++++++++++-------
 drivers/nvmem/core.c                               | 19 +++++-
 drivers/nvmem/nvmem.h                              |  2 +
 include/linux/nvmem-provider.h                     |  3 +
 7 files changed, 91 insertions(+), 27 deletions(-)

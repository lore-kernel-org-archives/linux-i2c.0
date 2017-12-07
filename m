From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL REQUEST] at24 fixes for 4.15-rc3
Date: Thu,  7 Dec 2017 15:32:36 +0100
Message-ID: <20171207143236.3228-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38553 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbdLGOcm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Dec 2017 09:32:42 -0500
Received: by mail-wr0-f193.google.com with SMTP id o2so7708296wro.5
        for <linux-i2c@vger.kernel.org>; Thu, 07 Dec 2017 06:32:41 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Hi Wolfram,

the following pull request contains two fixes for 4.15-rc3. Sakari
fixed a regression introduced during the 4.15 merge window and David
submitted a fix for an issue that has existed in at24 since introducing
nvmem.

----------------------------------------------------------------

The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-4.15-rc3-fixes-for-wolfram

for you to fetch changes up to 7f6d2ecd3d7acaf205ea7b3e96f9ffc55b92298b:

  eeprom: at24: change nvmem stride to 1 (2017-12-06 11:22:04 +0100)

----------------------------------------------------------------
AT24 fixes for 4.15-rc3

----------------------------------------------------------------
David Lechner (1):
      eeprom: at24: change nvmem stride to 1

Sakari Ailus (1):
      eeprom: at24: fix I2C device selection for runtime PM

 drivers/misc/eeprom/at24.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

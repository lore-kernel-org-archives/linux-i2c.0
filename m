From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Additional ACPI updates for v5.6-rc1
Date: Fri, 7 Feb 2020 11:36:02 +0100
Message-ID: <CAJZ5v0iWhN=pxnedntPn5kriN-uEULvTjHADtJj59a5W14a4sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32945 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGKgN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 7 Feb 2020 05:36:13 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.6-rc1-3

with top-most commit dec0a81a7814c8a876e663e0627468e6b1a7d2fb

 i2c: designware: Add ACPI HID for Hisilicon Hip08-Lite I2C controller

on top of commit ffda81b69fce50f2543be99ef2d7c77dffc1ebc1

 Merge tag 'acpi-5.6-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.6-rc1.

These add Hisilicon Hip08-Lite I2C controller clock frequency
support to the ACPI driver for AMD SoCs (APD) and to the Designware
I2C driver (Hanjun Guo).

Thanks!


---------------

Hanjun Guo (2):
      ACPI / APD: Add clock frequency for Hisilicon Hip08-Lite I2C controller
      i2c: designware: Add ACPI HID for Hisilicon Hip08-Lite I2C controller

---------------

 drivers/acpi/acpi_apd.c                     | 6 ++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 2 files changed, 7 insertions(+)

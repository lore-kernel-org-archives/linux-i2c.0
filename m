From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 0/2] i2c: brcmstb: Add support for BMIPS_GENERIC
Date: Fri, 15 Jul 2016 12:45:07 +0900
Message-ID: <20160715034509.58148-1-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36259 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcGODpv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Jul 2016 23:45:51 -0400
Received: by mail-pa0-f66.google.com with SMTP id ez1so2072923pab.3
        for <linux-i2c@vger.kernel.org>; Thu, 14 Jul 2016 20:45:51 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Hi all,

This patch series adds support for Broadcom BCM7xxx MIPS based SoCs, and a fix.

Changes in v2:
 * Rebase on lastest driver
 * Remove already applied patches

Jaedon Shin (2):
  i2c: brcmstb: Make the driver buildable on BMIPS_GENERIC
  i2c: brcmstb: Remove superfluous size check

 drivers/i2c/busses/Kconfig       | 2 +-
 drivers/i2c/busses/i2c-brcmstb.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.9.0

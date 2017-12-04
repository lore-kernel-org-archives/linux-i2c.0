From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v3 0/1] at24: support eeproms that do not auto-rollover reads.
Date: Mon, 4 Dec 2017 10:36:17 -0500
Message-ID: <1512401778-20366-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.arcx.com ([184.94.50.18]:47747 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbdLDPgW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 10:36:22 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: svendev@arcx.com, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, david@lechnology.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Sven Van Asbroeck <svenv@arcx.com>

From: Sven Van Asbroeck <svenv@arcx.com>

v3:
	rebased against at24 maintainer's devel staging branch:
	git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git at24/devel
	clarified some of the comments and wording

v2:
	kbuild test robot feedback: correct
		"warning: comparison of distinct pointer types lacks a cast"
	build warning on some compilers / architectures.

v1:
	original patch

Sven Van Asbroeck (1):
  at24: support eeproms that do not auto-rollover reads.

 .../devicetree/bindings/eeprom/eeprom.txt          |  5 +++
 drivers/misc/eeprom/at24.c                         | 37 +++++++++++++++-------
 include/linux/platform_data/at24.h                 |  2 ++
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
1.9.1

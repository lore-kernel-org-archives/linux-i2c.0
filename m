Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAF9C001E0
	for <linux-i2c@archiver.kernel.org>; Thu, 10 Aug 2023 12:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjHJMQK (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 10 Aug 2023 08:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjHJMQJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 10 Aug 2023 08:16:09 -0400
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7F196;
        Thu, 10 Aug 2023 05:16:07 -0700 (PDT)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 464392F20236; Thu, 10 Aug 2023 11:56:50 +0000 (UTC)
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
        by air.basealt.ru (Postfix) with ESMTPSA id 846782F20245;
        Thu, 10 Aug 2023 11:56:30 +0000 (UTC)
From:   Alexander Ofitserov <oficerovas@altlinux.org>
To:     oficerovas@altlinux.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/3] Add support for Intel Alder Lake PCH
Date:   Thu, 10 Aug 2023 14:56:21 +0300
Message-Id: <20230810115624.3740622-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

This patch series enables support of i2c bus for Intel Alder Lake PCH-P and PCH-M
on kernel version 5.10. These patches add ID's of Alder lake platform in these
drivers: i801, intel-lpss, pinctrl. ID's were taken from linux kernel version 5.15.

Alexander Ofitserov (3):
  i2c: i801: Add support for Intel Alder Lake PCH
  mfd: intel-lpss: Add Alder Lake's PCI devices IDs
  pinctrl: tigerlake: Add Alder Lake-P ACPI ID

 drivers/i2c/busses/i2c-i801.c             |  8 +++++
 drivers/mfd/intel-lpss-pci.c              | 41 +++++++++++++++++++++++
 drivers/pinctrl/intel/pinctrl-tigerlake.c |  1 +
 3 files changed, 50 insertions(+)

-- 
2.33.8


Return-Path: <SRS0=7hwG=7A=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251F5C433DF
	for <linux-i2c@archiver.kernel.org>; Mon, 18 May 2020 11:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABD520756
	for <linux-i2c@archiver.kernel.org>; Mon, 18 May 2020 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589802140;
	bh=zkaR4rGWJ6Eo08De7GTjsnn0me1CHxH7dvta/6Dwdr4=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=cHP6MsAsHISjcvYm3yQrUu2E566bDEFtT4Ex4TEtRnkZ8Mb5npn4EolFtIbRGSmYv
	 zimOAweUjQatCzmaeKwrfxAb926fUanNkbTUJL1G+Hq8uyN8gTmdbJUEZmF7o3gYMy
	 Pki+ynci7VOBATJsmytizaoKTyx3OS9CJsNbeJ6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgERLmT (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 18 May 2020 07:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgERLmT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 18 May 2020 07:42:19 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71C6206D4;
        Mon, 18 May 2020 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589802139;
        bh=zkaR4rGWJ6Eo08De7GTjsnn0me1CHxH7dvta/6Dwdr4=;
        h=From:To:Cc:Subject:Date:From;
        b=ekSL6Tpn2qFrfaI+NdPSvJ6JeDdcFaHrf80AuMUnOe//zqMeiSAQ/b1JXFvEk8TMo
         5/NieHXzNibheuudlqW/EJ1BWq2k3dkL+W8cWwQ/WMK+Rkb5hHtxsRwalPkZZWrAqn
         vKXFWRaNNdCyi1Q/9UtmTmswV3Jbrdyd04kAVDJc=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jae9w-00CSso-4E; Mon, 18 May 2020 13:42:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stefan Roese <sr@denx.de>, Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        linux-i2c@vger.kernel.org, Max Staudt <max@enpas.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 0/3] Fix dependencies for ACPI drivers with OpRegion settings
Date:   Mon, 18 May 2020 13:42:09 +0200
Message-Id: <cover.1589801950.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

In order for drivers to work properly with OpRegion, there are some
requirements:

	- The I2C core should be builtin;
	- The I2C designware driver should be builtin;
	- The driver itself should also be buildin;
	- The I2C core should be build with support for ACPI OpRegion.

-

v3:
    - Added Hans reviewed-by for the first two patches
    - Added a third patch fixing dependencies for axp20x driver

Mauro Carvalho Chehab (3):
  mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
  mfd: Kconfig: fix help texts for drivers that depends on I2C=y
  mfd: ensure that AXP20X_I2C will have the right deps on X86

 drivers/acpi/Kconfig       |  3 ++-
 drivers/i2c/busses/Kconfig |  4 ++--
 drivers/mfd/Kconfig        | 40 +++++++++++++++++++++++++-------------
 drivers/mfd/Makefile       |  8 +++++---
 4 files changed, 36 insertions(+), 19 deletions(-)

-- 
2.26.2



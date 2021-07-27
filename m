Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF5C4338F
	for <linux-i2c@archiver.kernel.org>; Tue, 27 Jul 2021 11:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5619A619F5
	for <linux-i2c@archiver.kernel.org>; Tue, 27 Jul 2021 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhG0LQJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 27 Jul 2021 07:16:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:40282 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhG0LQI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Jul 2021 07:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627384569; x=1658920569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DfQKmyg7ucgYUAgLLQ7ExUKOKdgz4Ph5a423Jvn9x+4=;
  b=IMqwFVLYUsU6+dRtlbIt13UknJnONHgcidaUG0KpZCTnLtPHgJ+lVjjs
   3BcOZkmL1XowjMV6dc4Yl2xnYYSRxcf2xLrhgFqkcJoHIWaYpbhnpZi07
   0v0MEj8R/vw8rYVxea9F16FgJqvRX/Hg6e/gQ+uRzXScziBpdeuXRk9q/
   UCccJux2m2EZY3gWDK4WHMkkfIoZj+Z8lHKu8PRz1nzgWh52zk7yvjLsm
   K9O19j5ey7zq0s9zAhlKH3Q6LQMznT2KkrmlMy64nzpxPkkpp89hPE0Rl
   sfENDvFjviH93p+QHNz7VZtc1C2v3L3Tc5sbfrvd61GlbOjxoarq7zotq
   w==;
IronPort-SDR: 7BCS3i5wqv4UwHG+CddaiascHKYzEJwHzS908JF1dmdGAASz4kDii7ftXi3mYyoW/4MOc7AB5t
 cYM23VaNhjzysI2jd2thjvL8Nx9axkaonJRRYZZiASy5gNRZ37GYreskdGyGedhyPoaMNvg0k9
 CabawKxrfWNF8IQJClYa1P7I4vK78SYEEQ96wdjtL2fi8rPOs2DCymxlT8DWErcsOK1+eOCDhJ
 KaUH9S5vzQ14kKmH/OWYr50RFsw15lKCsFTvlqzxq3/OSNEjm+ZUCk3U0Zl5gVMUgyRVLpTuu3
 GDXQPrVW7c21jPIpr80gCG+e
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="63728626"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 04:16:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 04:16:08 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Jul 2021 04:16:05 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <andrew@sanpeople.com>,
        <mhoffman@lightlink.com>, <khali@linux-fr.org>, <wsa@kernel.org>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 0/3] i2c: at91: Fixes and updates
Date:   Tue, 27 Jul 2021 14:15:51 +0300
Message-ID: <20210727111554.1338832-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

This patchset adds some fixes and updates, mostly for SAMA5D4, but other
platforms will still benefit.

The first patch is mostly a prerequisite for the second one. It only
moves the i2c_recover_bus() out of the actual transfer function. This
helps the second patch disable the controller before using GPIO
recovery. The second patch will keep the controller enabled when a
transfer occurs. Before using GPIO recovery, the controller must be
disabled, to ignore potential glitches. However, the controller must be
enabled for HW recovery (bus CLEAR command). The third and last patch
adds advanced digital filtering support for SAMA5D4. The TWI IP found in
SAMA5D4 supports advanced digital filtering, even if, at the moment of
this patch, the SAMA5D4 datasheet does not mention it.

Codrin Ciubotariu (3):
  i2c: at91: move i2c_recover_bus() outside of at91_do_twi_transfer()
  i2c: at91: keep the controller disabled when it is not used
  i2c: at91: add advanced digital filtering support for SAMA5D4

 drivers/i2c/busses/i2c-at91-core.c   |  1 +
 drivers/i2c/busses/i2c-at91-master.c | 53 ++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.30.2


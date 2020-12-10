Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F67C4361B
	for <linux-i2c@archiver.kernel.org>; Thu, 10 Dec 2020 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAF423C82
	for <linux-i2c@archiver.kernel.org>; Thu, 10 Dec 2020 16:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbgLJQwI (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 10 Dec 2020 11:52:08 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42280 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392242AbgLJQwG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 10 Dec 2020 11:52:06 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@nvidia.com)
        with SMTP; 10 Dec 2020 18:51:15 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0BAGpFT0032299;
        Thu, 10 Dec 2020 18:51:15 +0200
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH i2c-next 0/3] i2c: mlxcpld: Extend driver functionality and update license
Date:   Thu, 10 Dec 2020 18:51:10 +0200
Message-Id: <20201210165113.6130-1-vadimp@nvidia.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The patch set adds new features for the Mellanox/Nvidia systems and
updates module license.

Patch #1 - changes license to SPDX-License.
Patch #2 - changes polling time.
Patch #3 - allows I2C bus frequency setting according to the platform
	   configuration.

Vadim Pasternak (3):
  i2c: mlxcpld: Update module license
  i2c: mlxcpld: Decrease polling time for performance improvement
  i2c: mlxcpld: Add support for I2C bus frequency setting

 drivers/i2c/busses/i2c-mlxcpld.c | 96 +++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 31 deletions(-)

-- 
2.11.0


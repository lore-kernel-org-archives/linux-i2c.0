Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB5C6FA90
	for <linux-i2c@archiver.kernel.org>; Tue, 20 Sep 2022 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiITRr5 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiITRrv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Sep 2022 13:47:51 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5C016A4B0
        for <linux-i2c@vger.kernel.org>; Tue, 20 Sep 2022 10:47:48 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 20 Sep 2022 20:47:44 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 28KHlfvb015181;
        Tue, 20 Sep 2022 13:47:41 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 28KHlcLI009926;
        Tue, 20 Sep 2022 13:47:38 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>, robh@kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v5 0/8] i2c: i2c-mlxbf.c: bug fixes and new feature support
Date:   Tue, 20 Sep 2022 13:47:28 -0400
Message-Id: <20220920174736.9766-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

This is a series of patches fixing several bugs and implementing
new features.

Bug fixes:
1) Fix the frequency calculation
2) Fix incorrect base address passed during io write
3) prevent stack overflow in mlxbf_i2c_smbus_start_transaction()
4) Support lock mechanism to avoid race condition between entities
   using the i2c bus

Cleanup:
5) remove IRQF_ONESHOT flag as it is no longer needed.

Features:
6) Support multi slave functionality
7) Support BlueField-3 SoC
8) Update binding devicetree

What has changed from v4->v5:
Fix build error in the mellanox i2c device tree documentation

Asmaa Mnebhi (8):
  i2c: i2c-mlxbf.c: Fix frequency calculation
  i2c: i2c-mlxbf.c: remove IRQF_ONESHOT
  i2c: i2c-mlxbf.c: incorrect base address passed during io write
  i2c: i2c-mlxbf: prevent stack overflow in
    mlxbf_i2c_smbus_start_transaction()
  i2c: i2c-mlxbf.c: support lock mechanism
  i2c: i2c-mlxbf: add multi slave functionality
  i2c: i2c-mlxbf.c: support BlueField-3 SoC
  i2c: i2c-mlxbf.c: Update binding devicetree

 .../bindings/i2c/mellanox,i2c-mlxbf.yaml      |  48 +-
 MAINTAINERS                                   |   1 +
 drivers/i2c/busses/i2c-mlxbf.c                | 862 ++++++++++--------
 3 files changed, 521 insertions(+), 390 deletions(-)

-- 
2.30.1


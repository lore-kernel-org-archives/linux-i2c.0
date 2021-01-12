Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2583AC072AF
	for <linux-i2c@archiver.kernel.org>; Tue, 12 Jan 2021 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59802333B
	for <linux-i2c@archiver.kernel.org>; Tue, 12 Jan 2021 15:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404671AbhALPN6 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:13:58 -0500
Received: from www.zeus03.de ([194.117.254.33]:42692 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404302AbhALPNQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Jan 2021 10:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=2Cy/op28MBjMIxcLIh/qixCdPjU
        PCT4ZoaT5Q6V2oLw=; b=ai36Zenh2uOY59Et9EltV1WQOpbrds9Bk8wt21XUw84
        LDaD2f+ZWB6ewj4EJzA0dL2FC9swwHhki+uA58rn+kr/NO94BF3zKybwywTej6Ia
        ncm27K1A3H9gYDyKaFvBd9ZjuJKphXy8MXJXfC9xRzQBKNORj5y03Sjd3HAbVBfQ
        =
Received: (qmail 2786133 invoked from network); 12 Jan 2021 16:12:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jan 2021 16:12:35 +0100
X-UD-Smtp-Session: l3s3148p1@AubTc7W4dL4gAwDPXwxzAXsl+VVkdePs
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] i2c: smbus: small cleanups in emulation function
Date:   Tue, 12 Jan 2021 16:12:28 +0100
Message-Id: <20210112151230.46518-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

To prepare for some bigger refactoring, remove those two minor nuisances
first.

Wolfram Sang (2):
  i2c: smbus: don't abuse loop variable
  i2c: smbus: improve naming in i2c_smbus_xfer_emulated()

 drivers/i2c/i2c-core-smbus.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

-- 
2.29.2


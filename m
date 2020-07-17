Return-Path: <SRS0=/45J=A4=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EBAC433E3
	for <linux-i2c@archiver.kernel.org>; Fri, 17 Jul 2020 09:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9322F207FB
	for <linux-i2c@archiver.kernel.org>; Fri, 17 Jul 2020 09:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aTYRu6Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQJCK (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgGQJCK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Jul 2020 05:02:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CB4C08C5C0
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2020 02:02:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z15so10165780wrl.8
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2020 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UnjoNpdodzX7PZWMpGc2XxyIkrG22+hxSEEF2NRUIqo=;
        b=aTYRu6Wq43Tp/39GoKIOYNLuuNS3uBZb8KPaKWyrImAEbbjA8UT45QNx46/RD1Ky+u
         kkq5/kJA95MU/n+zBO4aQqiQ64OORCAbmwuwTsCEcDzaum//aTJFCpz7Be+9LywJpLnR
         js/1MpoJ1V8D3dmuueDYnMUw/KiLs9Q03KmpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UnjoNpdodzX7PZWMpGc2XxyIkrG22+hxSEEF2NRUIqo=;
        b=LOkyXXbkG489wCf/mofgp2dagXiNaP5qrw8Up3Luu/ZVS5QzHo0mcZqrna6EoOWHhP
         53DfP4snzTgn6JsFiXnk70mN5Jh8zZVe+ARQBSVz8Fax+tWCiVYrcDuIUPkkuarB1HLe
         NvZcTcJ4eQ02nIH6qCeSLmKdWnoSq5WflvMRIoRamza/vB6S4rW1RQ/IeJV3Sf7/hymr
         +HdhRQ0C9eMTLTCFgyYQuelJV7Z470Uoghag/YOwIgOpNZqZK1LBwJ8dYJzA4q61n2ef
         FqwBrSYgbOR4cDwuPD1NW1SIFJK/VPr0BETc+5cObmvTL3WlSKMk026VrCvDy0IL1Qft
         CPGw==
X-Gm-Message-State: AOAM533qbUIkCLggXYqGHlI40+lBmq6Gokq7PAamf+XhbxaYzi5dhbIF
        60IG+QIz6rGoIUpU2U5pjA+KYsnWsHM=
X-Google-Smtp-Source: ABdhPJxEonsfrDX0Dd91odQ0lshO6H7U+LzQjtWP+J4Jzo+XWVGZPBnxRsSwTZg2eUmSQaJs6M7Jtw==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr9414650wrm.121.1594976528383;
        Fri, 17 Jul 2020 02:02:08 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w7sm12360705wmc.32.2020.07.17.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 02:02:07 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        Robert Richter <rrichter@marvell.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 0/2] add PEC support on slave side
Date:   Fri, 17 Jul 2020 14:31:53 +0530
Message-Id: <20200717090155.10383-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

This patch set adds support for PEC on Slave side.

Changes from v1:
 -Address review comments from Andy Shevchenko
  Update commit message,
  Rewrite bcm_iproc_smbus_check_slave_pec() to remove local
  variable ret and type casting,
  Use positive condition.

Rayagonda Kokatanur (2):
  i2c: add PEC error event
  i2c: iproc: add slave pec support

 drivers/i2c/busses/i2c-bcm-iproc.c | 49 +++++++++++++++++++++++++++---
 include/linux/i2c.h                |  1 +
 2 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.17.1


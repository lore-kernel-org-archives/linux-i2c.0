Return-Path: <SRS0=qDtE=CU=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0785C43461
	for <linux-i2c@archiver.kernel.org>; Fri, 11 Sep 2020 07:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B8221D81
	for <linux-i2c@archiver.kernel.org>; Fri, 11 Sep 2020 07:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="2pz/Ez+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgIKHRP (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:17:15 -0400
Received: from www.zeus03.de ([194.117.254.33]:56908 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgIKHRO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Sep 2020 03:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=s9Wsi71ptI+z1i5AsHQ0CG9Cd01
        KjmxpN6hXVoKxUa8=; b=2pz/Ez+sZ+jXhN8tMYJtyEc7z7xjck5lJ+tk7vpuGu6
        OcIehgGxyPTFUrUQDB0L3d4ceosrL/2a7WmniK8MungMvimEv2MEKF+o1Q+R3NPG
        3RP3FL4qXsS5gp17HP1YQF+MEmTFktshz+4Hz57kQR4x8L/66I7RaHWlel6eG9lY
        =
Received: (qmail 914084 invoked from network); 11 Sep 2020 09:17:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Sep 2020 09:17:09 +0200
X-UD-Smtp-Session: l3s3148p1@IYgUeQSvzqsgAwDPXwg3AOu94Zz7tvsj
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Alain Volmat <alain.volmat@st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] i2c: add slave testunit driver
Date:   Fri, 11 Sep 2020 09:16:57 +0200
Message-Id: <20200911071658.13966-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Motivated by a series by Alain Volmat which implements SMBus Host Notify
support as a slave backend (already upstream), I wondered how I could
actually test it. Then, I picked up my old idea of a "custom remote
device" and implemented it as another slave backend. This is the outcome
and it works quite well on my Renesas Lager board where I connected two
I2C busses where both I2C controllers are master and slave. One slave is
the testunit, one slave is the HostNotify listener.

As mentioned elsewhere, support for SMBus Alert and I2C_M_RECV_LEN are
already planned. But I guess you can do much more.

Ideas and comments welcome!

Happy hacking,

   Wolfram

Wolfram Sang (1):
  i2c: add slave testunit driver

 Documentation/i2c/slave-testunit-backend.rst |  66 +++++++
 drivers/i2c/Kconfig                          |   8 +
 drivers/i2c/Makefile                         |   1 +
 drivers/i2c/i2c-slave-testunit.c             | 175 +++++++++++++++++++
 4 files changed, 250 insertions(+)
 create mode 100644 Documentation/i2c/slave-testunit-backend.rst
 create mode 100644 drivers/i2c/i2c-slave-testunit.c

-- 
2.20.1


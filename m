Return-Path: <SRS0=ekoI=CX=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C21DC2BC11
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Sep 2020 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE51217BA
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Sep 2020 07:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Jr/+zwrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgINHR7 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 14 Sep 2020 03:17:59 -0400
Received: from www.zeus03.de ([194.117.254.33]:48144 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgINHRo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Sep 2020 03:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=xJbhDh/H5UG36lNOTJCHnhf5scb
        lxKNX/3BgTNy9fJ8=; b=Jr/+zwrrioT1U1FTEeslwE2y4XVv1kggJjk3r3euMiK
        +G4KinVOPNapr2HKuk/YuLvvNz5Ga5nrfxSvgTqcNza1exmIVmdnj6hJ2J0gCwDx
        VkyB6cFSIu1lerFi1AjWUjqgpASzzogNEkD3yWUMZSJT64zx02qA8L/CE4I4okV8
        =
Received: (qmail 1770395 invoked from network); 14 Sep 2020 09:17:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2020 09:17:41 +0200
X-UD-Smtp-Session: l3s3148p1@4V971ECvluAgAwDPXwXYAPlEQEA0NVnc
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Alain Volmat <alain.volmat@st.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/1] i2c: add slave testunit driver
Date:   Mon, 14 Sep 2020 09:17:36 +0200
Message-Id: <20200914071737.6354-1-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/i2c-slave-testunit.c             | 174 +++++++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 Documentation/i2c/slave-testunit-backend.rst
 create mode 100644 drivers/i2c/i2c-slave-testunit.c

-- 
2.20.1


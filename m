Return-Path: <SRS0=0Bbp=7J=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F657C433E0
	for <linux-i2c@archiver.kernel.org>; Wed, 27 May 2020 11:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA81A208B6
	for <linux-i2c@archiver.kernel.org>; Wed, 27 May 2020 11:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="sUF1W1M4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgE0Lat (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 27 May 2020 07:30:49 -0400
Received: from www.zeus03.de ([194.117.254.33]:51796 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgE0Lat (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 27 May 2020 07:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=RPqfp5JAjnlhA1hGxeYIBkakIEm
        4RB79RU0WY6O57b8=; b=sUF1W1M4UQZsSRy0Dfl2sjIgnJA8O+QHjUOpqZAGvPz
        4CgF33p4F2cHPPgkd+Oc51dcovWDhvdlO2MLkQW4utvWykL5IzeWgf8bDetatExa
        Jlmepsv72o7q5XjqJNm9+DCw6dCPpcXdAFeWg0ib2EibFCyR9SXg+QfkLhalwiFw
        =
Received: (qmail 3135896 invoked from network); 27 May 2020 13:30:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 May 2020 13:30:47 +0200
X-UD-Smtp-Session: l3s3148p1@RUwci5+m9IggAwDPXwcUAGXYC40/aiEi
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
Subject: [PATCH] i2c: add 'single-master' property to generic bindings
Date:   Wed, 27 May 2020 13:30:39 +0200
Message-Id: <20200527113039.5380-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

It is useful to know if we are the only master on a given bus. Because
this is a HW description of the bus, add it to the generic bindings.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
---

We added 'multi-master' back then because most busses are single-master
and 'multi-master' was the exception. In hindsight, however, this was a
bad choice because 'multi-master' should be the default, i.e. if you
know nothing, you should assume there could be another master.

So, we can't deduce that a missing 'multi-master' property automatically
means 'single-master'. That's why we need this new property.

I am a bit tempted to mark 'multi-master' as deprecated because the
default should be multi-master. However, it might also be a bit more
descriptive to let "no property" still mean "we don't know". I'd be
thankful for more opinions here.

Thanks and happy hacking,

   Wolfram

 Documentation/devicetree/bindings/i2c/i2c.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index 819436b48fae..438ae123107e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -70,7 +70,12 @@ wants to support one of the below features, it should adapt these bindings.
 - multi-master
 	states that there is another master active on this bus. The OS can use
 	this information to adapt power management to keep the arbitration awake
-	all the time, for example.
+	all the time, for example. Can not be combined with 'single-master'.
+
+- single-master
+	states that there is no other master active on this bus. The OS can use
+	this information to detect a stalled bus more reliably, for example.
+	Can not be combined with 'multi-master'.
 
 Required properties (per child device)
 --------------------------------------
-- 
2.20.1


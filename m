Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A1C77B75
	for <linux-i2c@archiver.kernel.org>; Mon,  8 May 2023 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjEHOTC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 8 May 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjEHOSr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 8 May 2023 10:18:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E446AD;
        Mon,  8 May 2023 07:18:45 -0700 (PDT)
Received: from meterpeter.fritz.box ([93.196.140.197]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVMuN-1pohhE12MJ-00SKFE; Mon, 08 May 2023 16:18:43 +0200
From:   Christian Heusel <christian@heusel.eu>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Heusel <christian@heusel.eu>
Subject: [PATCH] i2c: Fix spelling mistake "innacurate" -> "inaccurate"
Date:   Mon,  8 May 2023 16:18:01 +0200
Message-Id: <20230508141801.88507-1-christian@heusel.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:++DIp72EtaRQ/6nJjS3s55l3mQIS2ve+3gZqKOdUagl4Gp11lLb
 OoOACp2/DEOo8SQ2Zq0v9629CvbXIYWI8jzDmpYvBVNhykQ+tHtZX61ZaMP2FTEQfDaqadL
 xrnKXJZq4058ZYKXUuIPf57eJfzfWD0GsvqhGxel72VJaPzCgOvmrg1VzKltRMZrgDK7AI0
 880lXBqYRa4dmdNhVsD4Q==
UI-OutboundReport: notjunk:1;M01:P0:7MvGWf67XZA=;XiFf0eUOVoE91PA0FxZFlC+RD7O
 F5w+v/X3bNpsLm6x3Et5D4vHautClyyg+ZFNuYML39OMWXZdhjMCZhw58oj7qrD1uYsJxLAnX
 6ErnWRXv3MQAThNdoC2hjKjXh1K6Fj//d059nd+yMM+kT9Q/4fjvdP+f3G1ZrpmInK3uGj+4w
 BIr7GDW2FPkbtwaZ6U5CNDkVRJOy/pHbW2mdQwuke+PeWH6bGjn+K817+14zaW12ipU7vLrw8
 +ZTg/YpFHam+E8FvebdyjJQPqWWrK/621oiqvcJzHEo51ggORVjmjrok3rU4GAvHmO2S3Dvzw
 Gn+yme1yB3tp6F0hOHNne75VG+MgVLcW2SouDkcX9JPAL+Ir88Eu875UPFD+NvgAx2BvLnh71
 IesP8gK9JFfm2wiudKWLyxz4nw5UTYURhmAZ1lF94/n9iQuYt2BzFpLkh/Cpkxj98uuyKXhPh
 L9p+ewgP63oj02E6pVr/cjDZSf4hjN4GYxJ+654+y+EhnUgwwPijsbx1jjZof4W0SW47tzSZX
 Y5IqgFYPME5HTll+eX9Aft//TyvE8tB0tlJ9LPLhhBzSYOSOr2MHt5jFHmnajMFbR7BazTSNa
 ynz26mUgP1TWS+UQiOMh39UG0bKya35SmGVoSIr/uoxyZBTJfda5r8yLzuWIOMY4Nr04syLE2
 IFp+nb/Qu+QXZdLCTEd1u8lIkLuKVuiJC58eOrDQEA==
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

There is a spelling mistake in a comment. Fix it.

Signed-off-by: Christian Heusel <christian@heusel.eu>
---
 drivers/i2c/busses/i2c-img-scb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 8e987945ed45..39c479f96eb5 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -257,7 +257,7 @@
 #define IMG_I2C_TIMEOUT			(msecs_to_jiffies(1000))
 
 /*
- * Worst incs are 1 (innacurate) and 16*256 (irregular).
+ * Worst incs are 1 (inaccurate) and 16*256 (irregular).
  * So a sensible inc is the logarithmic mean: 64 (2^6), which is
  * in the middle of the valid range (0-127).
  */
-- 
2.40.1


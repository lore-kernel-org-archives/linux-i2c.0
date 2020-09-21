Return-Path: <SRS0=xDOk=C6=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43680C43466
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Sep 2020 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086D82311D
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Sep 2020 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600699404;
	bh=E0ekg5aWtYtk64cRZDogsmPhWOTt7xCyRrKTdmYg2Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NxGDLQoRlekN5zL/E7lhuWlqBz7DcngcYTXF6iHZmSSxFvEwOqFO2JcI2l/oCJBjG
	 nC7ZslN2H9pbCrYbfM4cPrtfCl8vZkA1nVVjppFhmUUuHut/x9pd7K1rNimCHrBeUm
	 Ff8EUGckpIV0KutKcEBdbvSq8QtYfgeEBWD0/yrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIUOnL (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgIUOku (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 21 Sep 2020 10:40:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0841223447;
        Mon, 21 Sep 2020 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600699249;
        bh=E0ekg5aWtYtk64cRZDogsmPhWOTt7xCyRrKTdmYg2Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSu8lmECLBsVICvMBwyxmylO6v2mI9Ok1CiHtLMebKAD2Zs3YwEUX1tfbgEabjaef
         fPl3ryjvZkjDR0MIWY2OsqVT9pvk+RyJBxJejDPOBclyxZZ1+Bw3xXyIAt2FPgrSb1
         6rlz41m82wMamCQFOvJqI3AmXiKkzCp15QT58YAk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 17/20] i2c: core: Call i2c_acpi_install_space_handler() before i2c_acpi_register_devices()
Date:   Mon, 21 Sep 2020 10:40:24 -0400
Message-Id: <20200921144027.2135390-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921144027.2135390-1-sashal@kernel.org>
References: <20200921144027.2135390-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 21653a4181ff292480599dad996a2b759ccf050f ]

Some ACPI i2c-devices _STA method (which is used to detect if the device
is present) use autodetection code which probes which device is present
over i2c. This requires the I2C ACPI OpRegion handler to be registered
before we enumerate i2c-clients under the i2c-adapter.

This fixes the i2c touchpad on the Lenovo ThinkBook 14-IIL and
ThinkBook 15 IIL not getting an i2c-client instantiated and thus not
working.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1842039
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 4f09d4c318287..7031393c74806 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1336,8 +1336,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	/* create pre-declared device nodes */
 	of_i2c_register_devices(adap);
-	i2c_acpi_register_devices(adap);
 	i2c_acpi_install_space_handler(adap);
+	i2c_acpi_register_devices(adap);
 
 	if (adap->nr < __i2c_first_dynamic_bus_num)
 		i2c_scan_static_board_info(adap);
-- 
2.25.1


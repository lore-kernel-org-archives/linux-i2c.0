Return-Path: <SRS0=fqt/=7W=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D9AC433DF
	for <linux-i2c@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B4E206C3
	for <linux-i2c@archiver.kernel.org>; Tue,  9 Jun 2020 00:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662980;
	bh=bFUuWf7lEhjrgELh7Ay8Q+iXglie08ZUdzhs4xcPd48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DmoUenGBMCYQJQQgndVBivvdSNulczs44nXLB1z0NrruQ0bHCIRzgU4BrvazVTsSa
	 asro7kumz35XSaraAYyMDRs6KeCu928QxkCwmxhUSdxQZMoJIEyLUNdNnAEpGH3Fl+
	 9PuOtIGR1xDRzdg2ZnXLKj+fjF1Sb9Hg2waZ9I44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgFHXOJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgFHXOH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D4020C09;
        Mon,  8 Jun 2020 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658047;
        bh=bFUuWf7lEhjrgELh7Ay8Q+iXglie08ZUdzhs4xcPd48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ER4giVg/SI+NAzNFnWXX/6wCurrMSmL5JWI7ziungK8Ye+mdtrVAFzyVSlpEQEh1j
         z4VIFKYe4WwjLm88Up+dxPT1eHnaZBS8kyla4XC/f4ZcElMWdkSuMsXA5WhlGdgfzJ
         sMpc7uLZZQFlvm/o864fSwFDjttmIOJbZJDDK0Qs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 096/606] i2c: mux: demux-pinctrl: Fix an error handling path in 'i2c_demux_pinctrl_probe()'
Date:   Mon,  8 Jun 2020 19:03:41 -0400
Message-Id: <20200608231211.3363633-96-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e9d1a0a41d4486955e96552293c1fcf1fce61602 ]

A call to 'i2c_demux_deactivate_master()' is missing in the error handling
path, as already done in the remove function.

Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 0e16490eb3a1..5365199a31f4 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -272,6 +272,7 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 err_rollback_available:
 	device_remove_file(&pdev->dev, &dev_attr_available_masters);
 err_rollback:
+	i2c_demux_deactivate_master(priv);
 	for (j = 0; j < i; j++) {
 		of_node_put(priv->chan[j].parent_np);
 		of_changeset_destroy(&priv->chan[j].chgset);
-- 
2.25.1


Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E10C433F5
	for <linux-i2c@archiver.kernel.org>; Sun,  9 Oct 2022 10:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJIKYS (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 9 Oct 2022 06:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJIKYR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 9 Oct 2022 06:24:17 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4822D764
        for <linux-i2c@vger.kernel.org>; Sun,  9 Oct 2022 03:24:15 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id B83A75FCE7;
        Sun,  9 Oct 2022 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1665310599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AQcp51uRXNcfooZTEfbZbxQLHbIh+KufIsSkzNM91/U=;
        b=vcRGXu57F0J/7EXjfbzQdp6vRzWkXWyxefuNjO8/eLdfMiDRylZOLUQcN+r7d6KyN1s120
        OZaFLTfm9f2SgTgghlZvsEY6gt1tYzxMm49tDEhdRNBGGr71+nsDfUfWsixnBC9nOxGIss
        PWp4/qdiVh19DT8PHdEfurYUtC7xI9w=
Received: from frank-G5.. (fttx-pool-217.61.145.235.bambit.de [217.61.145.235])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id E44EC1005FA;
        Sun,  9 Oct 2022 10:16:38 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Qii Wang <qii.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add mt7986 i2c support
Date:   Sun,  9 Oct 2022 12:16:29 +0200
Message-Id: <20221009101631.82380-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 6f6f32f3-2929-45fb-a491-600517718096
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This series changes binding and driver for supporting i2c on mt7986.

Frank Wunderlich (2):
  dt-bindings: i2c: update bindings for mt7986 soc
  i2c: mediatek: add mt7986 support

 .../devicetree/bindings/i2c/i2c-mt65xx.yaml        |  1 +
 drivers/i2c/busses/i2c-mt65xx.c                    | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.34.1


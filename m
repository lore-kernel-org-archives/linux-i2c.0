Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85386C1B0D8
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Dec 2020 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553512064C
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Dec 2020 12:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439177AbgLNMow (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:44:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9442 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439101AbgLNMoq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Dec 2020 07:44:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cvgzl4b7yzhr6M;
        Mon, 14 Dec 2020 20:43:31 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 20:43:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Wolfram Sang <wsa@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] dt-bindings: i2c: dw: cancel mandatory requirements for "#address-cells" and "#size-cells"
Date:   Mon, 14 Dec 2020 20:43:46 +0800
Message-ID: <20201214124347.2120-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

v1 --> v2:
Update the subject and description.


Zhen Lei (1):
  dt-bindings: i2c: dw: cancel mandatory requirements for
    "#address-cells" and "#size-cells"

 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 8 --------
 1 file changed, 8 deletions(-)

-- 
1.8.3



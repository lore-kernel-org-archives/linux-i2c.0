From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/4] dt-bindings: i2c-mt6577: Rename file to reflect bindings
Date: Mon, 22 May 2017 11:40:19 +0200
Message-ID: <20170522094021.7837-2-matthias.bgg@gmail.com>
References: <20170522094021.7837-1-matthias.bgg@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36009 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757641AbdEVJkp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 05:40:45 -0400
In-Reply-To: <20170522094021.7837-1-matthias.bgg@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com
Cc: wsa@the-dreams.de, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>

The i2c-mt6577.txt actually holds the bindings for all mediatek supported i2c
controller. Change the name to i2c.mtk.txt to reflect that.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/i2c/{i2c-mt6577.txt => i2c-mtk.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/i2c/{i2c-mt6577.txt => i2c-mtk.txt} (100%)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
similarity index 100%
rename from Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
rename to Documentation/devicetree/bindings/i2c/i2c-mtk.txt
-- 
2.12.0

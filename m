From: Romain Perier <romain.perier@free-electrons.com>
Subject: [PATCH 3/3] dt-bindings: i2c: pxa: Update the documentation for the Armada 3700
Date: Tue,  8 Nov 2016 16:15:06 +0100
Message-ID: <20161108151506.1131-4-romain.perier@free-electrons.com>
References: <20161108151506.1131-1-romain.perier@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:49303 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752626AbcKHPPf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 8 Nov 2016 10:15:35 -0500
In-Reply-To: <20161108151506.1131-1-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

This commit documents the compatible string to have the compatibility for
the I2C unit found in the Armada 3700.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
index 12b78ac..b1b995c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
@@ -7,6 +7,7 @@ Required properties :
    compatible processor, e.g. pxa168, pxa910, mmp2, mmp3.
    For the pxa2xx/pxa3xx, an additional node "mrvl,pxa-i2c" is required
    as shown in the example below.
+   For the Armada 3700, the compatible should be "marvell,armada-3700".
 
 Recommended properties :
 
-- 
2.9.3

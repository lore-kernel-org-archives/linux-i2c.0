From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] dt-bindings: deprecate and move i2c/trivial-devices.txt
Date: Thu, 26 Jan 2017 23:55:42 +0100
Message-ID: <20170126225544.5431-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47811 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752373AbdAZW4N (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Jan 2017 17:56:13 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, robh+dt@kernel.org, Wolfram Sang <wsa@the-dreams.de>

trivial-devices is cruft and a maintenance pain. I'd like to deprecate it and
suggest refactoring. More details in the patch descriptions.

Let me know what you think.

Thanks,

   Wolfram


Wolfram Sang (2):
  dt-bindings: deprecate trivial-devices.txt for i2c
  dt-bindings: move trivial devices out of i2c subdir

 .../{i2c/trivial-devices.txt => i2c-trivial-devices.txt}       | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/{i2c/trivial-devices.txt => i2c-trivial-devices.txt} (98%)

-- 
2.10.2

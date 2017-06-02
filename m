From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v9 0/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri,  2 Jun 2017 01:45:58 -0700
Message-ID: <20170602084603.30811-1-brendanhiggins@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35565 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdFBIqL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Jun 2017 04:46:11 -0400
Received: by mail-oi0-f44.google.com with SMTP id l18so83875484oig.2
        for <linux-i2c@vger.kernel.org>; Fri, 02 Jun 2017 01:46:11 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, ryan_chen@aspeedtech.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

Addressed comments from:
  - Ben in: http://www.spinics.net/lists/devicetree/msg179006.html

Changes since previous update:
  - Fairly minimal changes in master support patch, all else is the same

As before, tested on Aspeed 2500 evaluation board and a real platform with an
Aspeed 2520.

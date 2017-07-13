From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v1 0/1] i2c: aspeed: add proper support for 24xx clock params
Date: Thu, 13 Jul 2017 15:30:51 -0700
Message-ID: <20170713223052.8387-1-brendanhiggins@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, benh@kernel.crashing.org, joel@jms.id.au
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Joel, Ben, our g5 device tree has I2C bus compatibility strings for the 24xx;
this will need to be changed because the clock is no longer programmed the same
way for the 24xx and the 25xx. I have a patch that fixes this; I will send it to
the OpenBMC list once this patch gets accepted.

Tested on an Aspeed 2400 and an Aspeed 2500.

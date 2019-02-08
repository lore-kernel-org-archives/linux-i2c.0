From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 0/5]
Date: Fri, 8 Feb 2019 17:11:56 +0100
Message-ID: <20190208161201.7860-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This patch set provides improvements to the i2c-ocore driver.

[V2 -> V3]
- fix error condition on platform_get_irq(). Copied from
  https://patchwork.ozlabs.org/patch/1038409/

[V1 -> V2]
- replaced usleep_range() with udelay() so that the polling version can be
  used in atomic context.
- added dedicated patch for minor style issues
- fixed delay computation
- use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is always
  necessary and a trylock would generate an extra interrupt for nothing
- make the driver ready for an eventual master_xfer_irqless()

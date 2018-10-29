From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH V2 0/5] i2c:ocores: improvements
Date: Mon, 29 Oct 2018 15:50:46 +0100
Message-ID: <20181029145051.31984-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, federico.vaga@cern.ch
List-Id: linux-i2c@vger.kernel.org

This patch set provides improvements to the i2c-ocore driver.

[V1 -> V2]
- replaced usleep_range() with udelay() so that the polling version can be
  used in atomic context.
- added dedicated patch for minor style issues
- fixed delay computation
- use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is always
  necessary and a trylock would generate an extra interrupt for nothing
- make the driver ready for an eventual master_xfer_irqless()

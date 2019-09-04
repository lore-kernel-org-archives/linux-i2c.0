From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 28/36] i2c: designware: Synchronize IRQs when unregistering slave client
Date: Wed,  4 Sep 2019 12:01:14 -0400
Message-ID: <20190904160122.4179-28-sashal@kernel.org>
References: <20190904160122.4179-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904160122.4179-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Krzysztof Adamski <krzysztof.adamski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit c486dcd2f1bbdd524a1e0149734b79e4ae329650 ]

Make sure interrupt handler i2c_dw_irq_handler_slave() has finished
before clearing the the dev->slave pointer in i2c_dw_unreg_slave().

There is possibility for a race if i2c_dw_irq_handler_slave() is running
on another CPU while clearing the dev->slave pointer.

Reported-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reported-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-slave.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index ea9578ab19a15..fccf936f4b9b5 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -206,6 +206,7 @@ static int i2c_dw_unreg_slave(struct i2c_client *slave)
 
 	dev->disable_int(dev);
 	dev->disable(dev);
+	synchronize_irq(dev->irq);
 	dev->slave = NULL;
 	pm_runtime_put(dev->dev);
 
-- 
2.20.1

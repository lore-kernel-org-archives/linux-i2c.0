From: michaelsh@mellanox.com
Subject: [PATCH v1 - resent 5/5] i2c: busses: Add capability register description to documentation
Date: Tue, 27 Mar 2018 14:01:26 +0000
Message-ID: <1522159286-41779-6-git-send-email-michaelsh@mellanox.com>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

It adds capability register description to documentation.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 Documentation/i2c/busses/i2c-mlxcpld | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-mlxcpld b/Documentation/i2c/busses/i2c-mlxcpld
index 4e46c44..925904a 100644
--- a/Documentation/i2c/busses/i2c-mlxcpld
+++ b/Documentation/i2c/busses/i2c-mlxcpld
@@ -20,6 +20,10 @@ The next transaction types are supported:
  - Write Byte/Block.
 
 Registers:
+CPBLTY		0x0 - capability reg.
+			Bits [6:5] - transaction length. b01 - 72B is supported,
+			36B in other case.
+			Bit 7 - SMBus block read support.
 CTRL		0x1 - control reg.
 			Resets all the registers.
 HALF_CYC	0x4 - cycle reg.
-- 
2.1.4

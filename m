From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 12/26] docs: i2c: smbus-protocol: properly name start and stop conditions
Date: Sun,  5 Jan 2020 23:49:58 +0100
Message-ID: <20200105225012.11701-12-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

In I2C there is no such thing as a "start bit" or a "stop bit". Use the
proper naming: "start condition" and "stop condition".

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/smbus-protocol.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
index 1600b09ec0be..8510eeda1dd0 100644
--- a/Documentation/i2c/smbus-protocol.rst
+++ b/Documentation/i2c/smbus-protocol.rst
@@ -35,8 +35,8 @@ Key to symbols
 ==============
 
 =============== =============================================================
-S     (1 bit) : Start bit
-P     (1 bit) : Stop bit
+S             : Start condition
+P             : Stop condition
 Rd/Wr (1 bit) : Read/Write bit. Rd equals 1, Wr equals 0.
 A, NA (1 bit) : Accept and reverse accept bit.
 Addr  (7 bits): I2C 7 bit address. Note that this can be expanded as usual to
-- 
2.24.1

From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 043/199] Documentation/i2c/busses/i2c-ali1563: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:11 +0200
Message-ID: <1274644605-25181-15-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Rudolf Marek <r.marek@assembler.cz>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Documentation/i2c/busses/i2c-ali1563:21: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/i2c/busses/i2c-ali1563 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-ali1563 b/Documentation/i2c/busses/i2c-ali1563
index 99ad4b9..5469169 100644
--- a/Documentation/i2c/busses/i2c-ali1563
+++ b/Documentation/i2c/busses/i2c-ali1563
@@ -18,7 +18,7 @@ For an overview of these chips see http://www.acerlabs.com
 The M1563 southbridge is deceptively similar to the M1533, with a few
 notable exceptions. One of those happens to be the fact they upgraded the
 i2c core to be SMBus 2.0 compliant, and happens to be almost identical to
-the i2c controller found in the Intel 801 south bridges. 
+the i2c controller found in the Intel 801 south bridges.
 
 Features
 --------
-- 
1.7.1.251.gf80a2


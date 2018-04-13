From: Sam Hansen <hansens@google.com>
Subject: [PATCH v3 3/3] Documentation/i2c: adopt kernel commenting style in examples
Date: Fri, 13 Apr 2018 10:42:57 -0700
Message-ID: <20180413174257.139182-3-hansens@google.com>
References: <20180413174257.139182-1-hansens@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413174257.139182-1-hansens@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Sam Hansen <hansens@google.com>, wsa@the-dreams.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The example I2C code is rewritten to adopt the preferred kernel block
commenting style.

Signed-off-by: Sam Hansen <hansens@google.com>
---
Changes from v2:
  1. only the block comment is updated.
  2. one-line comments are reverted to prior form.

 Documentation/i2c/dev-interface | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index f92ee1f59914..fbed645ccd75 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -67,8 +67,10 @@ the device supports them. Both are illustrated below.
     /* res contains the read word */
   }
 
-  /* Using I2C Write, equivalent of
-     i2c_smbus_write_word_data(file, reg, 0x6543) */
+  /*
+   * Using I2C Write, equivalent of
+   * i2c_smbus_write_word_data(file, reg, 0x6543)
+   */
   buf[0] = reg;
   buf[1] = 0x43;
   buf[2] = 0x65;
-- 
2.17.0.484.g0c8726318c-goog

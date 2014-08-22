From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 0/3] R-Car I2C driver: some cleanups
Date: Fri, 22 Aug 2014 18:21:26 +0400
Message-ID: <32018817.zX4x1fdR4T@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello.

   Here's the set of 3 patches against Wolfram Sang's 'linux.git' repo's
'i2c/for-next' branch.

[1/3] i2c-rcar: simplify check for last message
[2/3] i2c-rcar: make rcar_i2c_prepare_msg() *void*
[3/3] i2c-rcar: make rcar_i2c_irq_recv() *void*

WBR, Sergei


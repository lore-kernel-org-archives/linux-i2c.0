From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 0/3] R-Car I2C driver: some cleanups
Date: Mon, 15 Sep 2014 00:12:46 +0400
Message-ID: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

   Here's the set of 3 patches against Wolfram Sang's 'linux.git' repo's
'i2c/for-next' branch.

[1/3] i2c-rcar: simplify check for last message
[2/3] i2c-rcar: make rcar_i2c_prepare_msg() *void*
[3/3] i2c-rcar: make rcar_i2c_irq_recv() *void*

WBR, Sergei

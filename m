From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: [PATCH v2 0/3] Fix issues reported by Coccinelle
Date: Tue, 17 Sep 2019 22:57:58 +0530
Message-ID: <20190917172758.GA11926@SD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, markus.elfring@web.de
List-Id: linux-i2c@vger.kernel.org

Using cocciecheck to ensure there are no semantic issues in
i2c-qup driver.

Refer below links for more information.
http://coccinelle.lip6.fr
https://bottest.wiki.kernel.org/coccicheck

Changes in v2:
* Updated changelog as suggested by Markus Elfring.

v1:
https://patchwork.ozlabs.org/cover/1163043/

Saiyam Doshi (3):
  i2c: qup: remove explicit conversion to boolean
  i2c: qup: Remove dev_err() log after platform_get_irq*() failure
  i2c: qup: Use devm_platform_ioremap_resource helper

 drivers/i2c/busses/i2c-qup.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

--
2.20.1

From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] i2c-dev: Fine-tuning for four function implementations
Date: Fri, 23 Sep 2016 21:42:49 +0200
Message-ID: <cedc3865-a884-a10e-6c93-0163fd36af92@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 23 Sep 2016 21:38:21 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Use kmalloc_array() in i2cdev_ioctl_rdwr()
  Improve another size determination in i2cdev_ioctl_rdwr()
  Rename jump labels in i2cdev_attach_adapter()
  Adjust checks for null pointers in three functions

 drivers/i2c/i2c-dev.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.10.0

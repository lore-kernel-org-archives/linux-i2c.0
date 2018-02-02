From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] i2c-sh7760: Adjustments for sh7760_i2c_probe()
Date: Fri, 2 Feb 2018 15:20:43 +0100
Message-ID: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:18:29 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-sh7760.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.16.1


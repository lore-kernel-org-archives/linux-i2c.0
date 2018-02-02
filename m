From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] i2c-puv3: Adjustments for puv3_i2c_probe()
Date: Fri, 2 Feb 2018 16:00:07 +0100
Message-ID: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:65467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752391AbeBBPAU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Feb 2018 10:00:20 -0500
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:54:32 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-puv3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.16.1

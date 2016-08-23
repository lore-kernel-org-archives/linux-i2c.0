From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v4 0/4] i2c: designware: improve performance for transfers
Date: Tue, 23 Aug 2016 19:18:52 -0300
Message-ID: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54479 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753085AbcHWWTC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 Aug 2016 18:19:02 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Diff from v3:

    - Fix over 80chars in one place

    - Move check for adapter being able to dynamically update TAR to be done
      on probe time rather than init as requested by Jarkko

For the previous version, Christian had added:

Tested-by: Christian Ruppert <christian.ruppert@alitech.com>
on TB101 with Linux-4.7

And Jarkko added his Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
on patches 1 and 3 (now 4).

There's a new patch #2 as a preparatory work to move the check
mentioned above to i2c_dw_probe().

v3 of "i2c: designware: do not disable adapter after transfer". Differences
are:

    - Now there's a first patch that does not depend on IC_TAR being dynamically
      enabled/disabled: it just doesn't wait for the state change when not needed.

    - We added a patch that allows detecting if HW supports the dynamic TAR updates

    - In the last patch the bits were changed as suggested by Jarkko.

    - This is tested on BayTrail and CherryTrail, both of them returning true for
      "dynamically update TAR"

José Roberto de Souza (1):
  i2c: designware: wait for disable/enable only if necessary

Lucas De Marchi (3):
  i2c: designware: add common functions for locking
  i2c: designware: detect when dynamic tar update is possible
  i2c: designware: do not disable adapter after transfer

 drivers/i2c/busses/i2c-designware-core.c | 162 +++++++++++++++++++++----------
 drivers/i2c/busses/i2c-designware-core.h |   1 +
 2 files changed, 111 insertions(+), 52 deletions(-)

-- 
2.7.4

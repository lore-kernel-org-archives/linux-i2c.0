From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v3 0/3] i2c: designware: improve performance for transfers
Date: Thu, 28 Jul 2016 19:03:41 -0300
Message-ID: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4317 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbcG1WDu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 18:03:50 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: christian.ruppert@alitech.com, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com

This can be considered a v3 of "i2c: designware: do not disable adapter=
 after
transfer". Differences are:

    - Now there's a first patch that does not depend on IC_TAR being dy=
namically
      enabled/disabled: it just doesn't wait for the state change when =
not needed.

    - We added a patch that allows detecting if HW supports the dynamic=
 TAR updates

    - In the last patch the bits were changed as suggested by Jarkko.

    - This is tested on BayTrail and CherryTrail, both of them returnin=
g true for
      "dynamically update TAR"

Jos=C3=A9 Roberto de Souza (1):
  i2c: designware: wait for disable/enable only if necessary

Lucas De Marchi (2):
  i2c: designware: detect when dynamic tar update is possible
  i2c: designware: do not disable adapter after transfer

 drivers/i2c/busses/i2c-designware-core.c | 103 +++++++++++++++++++++--=
--------
 drivers/i2c/busses/i2c-designware-core.h |   1 +
 2 files changed, 72 insertions(+), 32 deletions(-)

--=20
2.7.4

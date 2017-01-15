From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.10
Date: Sun, 15 Jan 2017 13:19:10 +0100
Message-ID: <20170115121906.5xnatgszvhnmuk3r@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:44226 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbdAOMTO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 15 Jan 2017 07:19:14 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Linus,

here is a pull request with bugfixes for I2C. Mostly core this time
which is a bit unusual but nothing really scary in there.

Also, this is the first public test run of my git-request-pull
enhancement to give credits to people taking part in quality assurance
(like reviewing and testing). I think we are lacking in this department
and this is my take on fixing it. I'll post about it on LKML seperately
later today.

Please pull.

Thanks,

   Wolfram


The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 701dc207bf551d9fe6defa36e84a911e880398c3:

  i2c: piix4: Avoid race conditions with IMC (2017-01-12 20:52:12 +0100)

----------------------------------------------------------------
Colin Ian King (1):
      i2c: fix spelling mistake: "insufficent" -> "insufficient"

Dmitry Torokhov (1):
      i2c: do not enable fall back to Host Notify by default

John Garry (1):
      i2c: print correct device invalid address

Ricardo Ribalda Delgado (1):
      i2c: piix4: Avoid race conditions with IMC

Vlad Tsyrklevich (1):
      i2c: fix kernel memory disclosure in dev interface


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: piix4: Avoid race conditions with IMC

Benjamin Tissoires (1):
      (Test) i2c: do not enable fall back to Host Notify by default

Vladimir Zapolskiy (1):
      (Rev.) i2c: print correct device invalid address

 Documentation/devicetree/bindings/i2c/i2c.txt |  8 ++++++++
 drivers/i2c/busses/i2c-piix4.c                | 22 ++++++++++++++++++++++
 drivers/i2c/i2c-core.c                        | 21 ++++++++++-----------
 drivers/i2c/i2c-dev.c                         |  2 +-
 include/linux/i2c.h                           |  1 +
 5 files changed, 42 insertions(+), 12 deletions(-)

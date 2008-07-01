From: Ben Dooks <ben-linux@fluff.org>
Subject: i2c pull request for s3c24xx driver
Date: Tue, 1 Jul 2008 15:49:30 +0100
Message-ID: <20080701144929.GA19449@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757774AbYGAOu2@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Pull request for i2c driver fixes to the S3C24XX i2c driver
suitable for applying to the current kernel.

Linus please take this unless Jean wants to pull this into
his own i2c tree.

The following changes since commit e1441b9a41c33aa9236008a7cfe49a8e723fb397:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-fix

Ben Dooks (3):
      I2C: S3C2410: Check ACK on byte transmission
      I2C: S3C2410: Fixup error codes returned rom a transfer.
      I2C: S3C2410: Add MODULE_ALIAS() for s3c2440 device.

 drivers/i2c/busses/i2c-s3c2410.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

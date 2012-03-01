From: Wolfram Sang <w.sang@pengutronix.de>
Subject: (unknown)
Date: Thu, 1 Mar 2012 11:33:32 +0100
Message-ID: <20120301103332.GA30156@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux-2.6.git i2c-embedded/for-3.3

for you to fetch changes up to 844990daa2e69a4258049ba9c2bae1180657dac3:

  i2c: mxs: only flag completion when queue is completely done (2012-02-24 22:28:27 +0100)

----------------------------------------------------------------
Wolfram Sang (1):
      i2c: mxs: only flag completion when queue is completely done

 drivers/i2c/busses/i2c-mxs.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

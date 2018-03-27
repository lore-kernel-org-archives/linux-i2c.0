From: michaelsh@mellanox.com
Subject: [PATCH v1 - resent 0/5] Add capabilities to i2c-mlxcpld
Date: Tue, 27 Mar 2018 14:01:21 +0000
Message-ID: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

This series is resent (original series has been sent at 5/3/2018).

PATCH1
  It adds support for extended length of read and write transactions.

PATCH2
  It adds support for smbus block read transaction.

PATCH3
  Fix report about supported functionality.

PATCH4
  It allows mlxcpld driver to be connected to pre-defined adapter number.

PATCH5
  It adds capability register description to documentation.

Michael Shych (5):
  i2c: busses: Add support for extended transaction length for
    i2c-mlxcpld
  i2c: busses: Add support for smbus block read transaction
  i2c: busses: Fix adapter functionality support callback
  i2c: busses: Allow configurable adapter id for mlxcpld
  i2c: busses: Add capability register description to documentation

 Documentation/i2c/busses/i2c-mlxcpld |  4 +++
 drivers/i2c/busses/i2c-mlxcpld.c     | 68 +++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 9 deletions(-)

-- 
2.1.4

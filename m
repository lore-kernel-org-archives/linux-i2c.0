From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/2] i2c: move adapter locking ops to struct, constify
Date: Fri, 29 Jul 2016 10:17:55 +0200
Message-ID: <1469780277-31085-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30094.outbound.protection.outlook.com ([40.107.3.94]:62336
	"EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752172AbcG2Oug (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jul 2016 10:50:36 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

This allows the locking ops to be moved to .rodata, which is generally
desireable. It also feels good to change all ops with one assignment.

Cheers,
Peter

Peter Rosin (2):
  i2c: add i2c_trylock_bus wrapper, use it
  i2c: move locking operations to their own struct

 drivers/i2c/i2c-core.c | 15 +++++++++------
 drivers/i2c/i2c-mux.c  | 29 ++++++++++++++++++-----------
 include/linux/i2c.h    | 37 +++++++++++++++++++++++++++++++------
 3 files changed, 58 insertions(+), 23 deletions(-)

-- 
2.1.4

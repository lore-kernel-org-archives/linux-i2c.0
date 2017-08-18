From: Radu Rendec <radu.rendec@gmail.com>
Subject: [PATCH 0/2] i2c: ismt: align the DMA buffer to avoid parity errors
Date: Fri, 18 Aug 2017 17:01:26 +0100
Message-ID: <20170818160128.21228-1-radu.rendec@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37132 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdHRQBq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Aug 2017 12:01:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so4671672wmt.4
        for <linux-i2c@vger.kernel.org>; Fri, 18 Aug 2017 09:01:45 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Radu Rendec <radu.rendec@gmail.com>

Hello all,

I ran into an issue where write transfers were randomly failing with
"data parity" errors (bit 9 set in ERRSTS). This seems to be caused by a
hardware bug, probably the same as v3.12-rc2-5-gbf41691 addresses.

The problem appeared on an x86_64 kernel after enabling Xen support
(CONFIG_XEN), which appears to be completely unrelated but, as a side
effect, changed the alignment of the private structure (struct ismt_priv)
allocated at the beginning of ismt_probe().

On x86_64, addresses returned by kmalloc are guaranteed to be only 8-byte
aligned. However, i2c-ismt apparently was always getting a 16-byte
aligned address.

Since the hardware seems to have issues with unaligned DMA buffers (at
least in some revisions), I believe it is safer to always align the
buffer at the cost of 15 extra bytes of memory.

The first patch tackles this.

The second patch in the series adds a register dump at the end of
transactions (when debugging is enabled). This is not critical, but
probably helps debugging issues where some general/master registers are
changed as result of a failed transaction.

-Radu

Radu Rendec (2):
  i2c: ismt: 16-byte align the DMA buffer address
  i2c: ismt: dump registers at the end of transactions

 drivers/i2c/busses/i2c-ismt.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

-- 
2.9.5

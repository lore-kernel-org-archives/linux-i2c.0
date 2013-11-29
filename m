From: jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/4] i2c : i2c-ibm-iic : use interrupts to perform the data transfer
Date: Fri, 29 Nov 2013 17:53:31 +0100
Message-ID: <1385744015-21567-1-git-send-email-jean-jacques.hiblot@jdsu.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jean-jacques hiblot <jean-jacques.hiblot-qU79poH1Kb0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch set aims to improve the performance of the driver for the IBM iic
controller by implementing the data transfer in the interrupt handler.
Using interrupts to trigger the data transfer reduces and make more
deterministic the latencies between indivdual bytes, and consequently reduces
the total transfer time,

In our test environement with multiple masters, this significantly reduces the
rate of i2c errors.

Changes since v2:
 - cosmectics change (comments style, removed a hard-coded value)
 - moved some parts from one patch to another 
 
Changes since v1:
 - split the patch in 4 individual patches. The code has been refactored a bit
   to make the diff easier to read.
 - changed some dev_dbg in dev_err or dev_warn when more appropriate


jean-jacques hiblot (4):
  i2c: i2c-ibm-iic: cleanup.
  i2c: i2c-ibm-iic: perform the transfer in the interrupt handler
  i2c: i2c-ibm-iic: Implements transfer abortion
  i2c: i2c-ibm-iic: Implements a polling mode

 drivers/i2c/busses/i2c-ibm_iic.c | 490 +++++++++++++++++++++++----------------
 drivers/i2c/busses/i2c-ibm_iic.h |  20 +-
 2 files changed, 309 insertions(+), 201 deletions(-)

-- 
1.8.4.2

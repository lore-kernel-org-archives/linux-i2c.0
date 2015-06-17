From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 0/9] i2c: xiic: cleanups
Date: Wed, 17 Jun 2015 20:48:10 +0530
Message-ID: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a series of cleanups for the axi iic.
tested on zc702 and microblaze.

Changes from v1
Updated the commit message.
 

Shubhrajyoti Datta (9):
  i2c: xiic: Remove the disabling of interrupts
  i2c: xiic: move the xiic_process to thread context
  i2c: xiic: Do not reset controller before every transfer
  i2c: xiic: Remove the disabling of interrupts
  i2c: xiic: Remove busy loop while waiting for bus busy
  i2c: xiic: Add a debug msg in case of timeout
  i2c: xiic: Remove the Addressed as slave interrupt
  i2c: xiic: Service all interrupts in isr
  i2c: xiic: Do not continue in case of errors in Rx

 drivers/i2c/busses/i2c-xiic.c |   75 +++++++++++++++++++----------------------
 1 files changed, 35 insertions(+), 40 deletions(-)

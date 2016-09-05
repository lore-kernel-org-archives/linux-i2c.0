From: David Lechner <david@lechnology.com>
Subject: [PATCH 0/3] LEGO MINDSTORMS I2C support
Date: Mon,  5 Sep 2016 15:40:11 -0500
Message-ID: <1473108014-30787-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: David Lechner <david@lechnology.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I'm working on getting LEGO MINDSTORMS[1] support in the Linux kernel.

They have a system of modular sensors that are hot-plugable, some of which use
I2C communications. Unfortunately, these don't necessary follow standard I2C
conventions, but they do have a well-defined register layout, so they are
easy to detect.

This set of patches addresses the hot-plugability of the sensors.

[1]: http://mindstorms.lego.com


David Lechner (3):
  i2c: Add class for LEGO MINDSTORMS sensors
  i2c: Add special case for detecting LEGO devices
  i2c: expose adapter probe and remove probed functions

 drivers/i2c/i2c-core.c | 62 ++++++++++++++++++++++++++++++++++++++------------
 include/linux/i2c.h    |  4 ++++
 2 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.7.4

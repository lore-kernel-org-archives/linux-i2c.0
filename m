From: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] Small fix with i2c-ismt driver
Date: Tue, 16 Sep 2014 17:21:02 +0800
Message-ID: <1410859264-7118-1-git-send-email-fan.du@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org
Cc: fengyuleidian0615-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

This patcheset fix two issue with i2c ismt driver:

Patch1: Use only 2 descriptor for transfer and receive
Patch2: Only copy valid data when transfer


Fan Du (2):
  i2c-ismt: Use minimum descriptor size
  i2c-ismt: use correct length when copy buffer

 drivers/i2c/busses/i2c-ismt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.9.5

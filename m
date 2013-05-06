From: Libo Chen <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2]  i2c: fix two wrong mem release
Date: Mon, 6 May 2013 21:09:48 +0800
Message-ID: <5187AB9C.5020600@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Li Zefan <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


 fix two wrong mem release

Libo Chen (2):
  i2c: i2c-bfin-twi:don`t free peripheral before it`s init successful
  i2c: pxa: no need release_mem_region before request_mem_region
    successful

 drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c      |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

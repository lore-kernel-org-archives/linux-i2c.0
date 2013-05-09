From: Libo Chen <libo.chen@huawei.com>
Subject: [PATCH v2 0/2] i2c: fix two wrong mem release
Date: Thu, 9 May 2013 16:27:22 +0800
Message-ID: <1368088044-20408-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sonic.Zhang@analog.com, wsa@the-dreams.de
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lizefan@huawei.com, Libo Chen <libo.chen@huawei.com>
List-Id: linux-i2c@vger.kernel.org

fix two wrong mem release

* Changelog from v1:
  * exchange out_error_no_irq and out_error_pin_mux  suggested by Sonic <Sonic.Zhang@analog.com>  
  * add some new tag , make code cleanly

Libo Chen (2):
  i2c: i2c-bfin-twi: don`t free peripheral before it init successful
  i2c: pxa: no need release_mem_region before request_mem_region
    successful

 drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c      |   13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

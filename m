From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] macintosh: replace i2c_new_probed_device with an ERR_PTR variant
Date: Mon, 16 Dec 2019 13:29:38 +0100
Message-ID: <20191216122939.3411-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

In the on-going mission to let i2c_new_* calls return an ERR_PTR instead of
NULL, here is a series for this subsystem converting i2c_new_probed_device() to
the newly introduced i2c_new_scanned_device(). Based on v5.5-rc1 and build tested.
Please apply via your tree.

Thanks,

   Wolfram


Wolfram Sang (1):
  macintosh: convert to i2c_new_scanned_device

 drivers/macintosh/therm_windtunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

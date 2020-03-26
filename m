From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] x86: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:10:14 +0100
Message-ID: <20200326211015.13654-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, x86@kernel.org
List-Id: linux-i2c@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (1):
  x86/platform/intel-mid: convert to use i2c_new_client_device()

 arch/x86/platform/intel-mid/sfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

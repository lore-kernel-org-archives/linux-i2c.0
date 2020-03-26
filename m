From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] power: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:09:53 +0100
Message-ID: <20200326210954.12931-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (1):
  power: supply: bq24190_charger: convert to use i2c_new_client_device()

 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1

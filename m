From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] rtc: convert two drivers to devm_i2c_new_dummy_device()
Date: Tue, 20 Aug 2019 17:42:36 +0200
Message-ID: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I was about to simplify the call to i2c_unregister_device() when I
realized that converting to devm_i2c_new_dummy_device() will simplify
the drivers a lot. So I took this approach.

Only build tested, but visually reviewed multiple times.

Wolfram Sang (2):
  rtc: max77686: convert to devm_i2c_new_dummy_device()
  rtc: s35390a: convert to devm_i2c_new_dummy_device()

 drivers/rtc/rtc-max77686.c | 17 +++---------
 drivers/rtc/rtc-s35390a.c  | 54 +++++++++-----------------------------
 2 files changed, 17 insertions(+), 54 deletions(-)

-- 
2.20.1

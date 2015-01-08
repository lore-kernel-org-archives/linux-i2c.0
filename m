From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH wsa] i2c: dln2: dln2_i2c_quirks can be static
Date: Fri, 9 Jan 2015 02:02:00 +0800
Message-ID: <20150108180200.GA130854@lkp-sb04>
References: <201501090243.rmSyDkOe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201501090243.rmSyDkOe%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: kbuild-all@01.org, Octavian Purdila <octavian.purdila@intel.com>, Lee Jones <lee.jones@linaro.org>, Johan Hovold <johan@kernel.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

drivers/i2c/busses/i2c-dln2.c:184:27: sparse: symbol 'dln2_i2c_quirks' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 i2c-dln2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
index 3e47811..b6f9ba7 100644
--- a/drivers/i2c/busses/i2c-dln2.c
+++ b/drivers/i2c/busses/i2c-dln2.c
@@ -181,7 +181,7 @@ static const struct i2c_algorithm dln2_i2c_usb_algorithm = {
 	.functionality = dln2_i2c_func,
 };
 
-struct i2c_adapter_quirks dln2_i2c_quirks = {
+static struct i2c_adapter_quirks dln2_i2c_quirks = {
 	.max_read_len = DLN2_I2C_MAX_XFER_SIZE,
 	.max_write_len = DLN2_I2C_MAX_XFER_SIZE,
 };

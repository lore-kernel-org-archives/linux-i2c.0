From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH wsa] i2c: axxia: axxia_i2c_quirks can be static
Date: Fri, 9 Jan 2015 01:57:37 +0800
Message-ID: <20150108175737.GA33686@lkp-sb04>
References: <201501090118.jHaamxHl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201501090118.jHaamxHl%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: kbuild-all@01.org, Anders Berg <anders.berg@avagotech.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

drivers/i2c/busses/i2c-axxia.c:452:27: sparse: symbol 'axxia_i2c_quirks' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 i2c-axxia.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 2d35476..488c5d3 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -449,7 +449,7 @@ static const struct i2c_algorithm axxia_i2c_algo = {
 	.functionality = axxia_i2c_func,
 };
 
-struct i2c_adapter_quirks axxia_i2c_quirks = {
+static struct i2c_adapter_quirks axxia_i2c_quirks = {
 	.max_read_len = 255,
 	.max_write_len = 255,
 };

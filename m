From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH wsa] i2c: viperboard: vprbrd_quirks can be static
Date: Fri, 9 Jan 2015 02:07:53 +0800
Message-ID: <20150108180753.GA9361@lkp-sb04>
References: <201501090239.gPJgrJIE%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201501090239.gPJgrJIE%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

drivers/i2c/busses/i2c-viperboard.c:357:27: sparse: symbol 'vprbrd_quirks' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 i2c-viperboard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index f880f08..47e88ad 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -354,7 +354,7 @@ static const struct i2c_algorithm vprbrd_algorithm = {
 	.functionality	= vprbrd_i2c_func,
 };
 
-struct i2c_adapter_quirks vprbrd_quirks = {
+static struct i2c_adapter_quirks vprbrd_quirks = {
 	.max_read_len = 2048,
 	.max_write_len = 2048,
 };

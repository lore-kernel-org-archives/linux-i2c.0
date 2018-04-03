From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v7 3/4] i2c: add param sanity check to i2c_transfer()
Date: Tue,  3 Apr 2018 21:11:50 +0200
Message-ID: <20180403191151.14924-4-ard.biesheuvel@linaro.org>
References: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-i2c@vger.kernel.org

The API docs describe i2c_transfer() as taking a pointer to an array
of i2c_msg containing at least 1 entry, but leaves it to the individual
drivers to sanity check the msgs and num parameters. Let's do this in
core code instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/i2c/i2c-core-base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index c8bfe008f208..e2ca5c331ecb 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1845,6 +1845,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	unsigned long orig_jiffies;
 	int ret, try;
 
+	if (WARN_ON(!msgs || num <= 0))
+		return -EINVAL;
+
 	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
 		return -EOPNOTSUPP;
 
-- 
2.15.1

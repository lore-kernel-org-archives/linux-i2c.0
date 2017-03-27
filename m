From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v11 11/12] iio: multiplexer: fix unsigned check with less than zero
Date: Mon, 27 Mar 2017 14:17:48 +0200
Message-ID: <1490617069-13119-12-git-send-email-peda@axentia.se>
References: <1490617069-13119-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30115.outbound.protection.outlook.com ([40.107.3.115]:55773
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752995AbdC0MSb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Mar 2017 08:18:31 -0400
In-Reply-To: <1490617069-13119-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, Paul Gortmaker <paul.gortmaker@windriver.com>

Comparing a size_t with less than zero is always false as size_t
is unsigned. So, change the type of the variable to ssize_t and
replicate the size check from mux_configure_channel() into
mux_write_ext_info() thus ensuring that the size will fit in the
ssize_t variable.

Detected by CoverityScan, CID#1415278 ("Unsigned compared against 0")

Fixes: 1da8e16d2812 ("iio: multiplexer: new iio category and iio-mux driver")
Reported-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/multiplexer/iio-mux.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 94d40f9bef4c..bab9e6902090 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -21,7 +21,7 @@
 
 struct mux_ext_info_cache {
 	char *data;
-	size_t size;
+	ssize_t size;
 };
 
 struct mux_child {
@@ -206,6 +206,9 @@ static ssize_t mux_write_ext_info(struct iio_dev *indio_dev, uintptr_t private,
 	char *new;
 	ssize_t ret;
 
+	if (len >= PAGE_SIZE)
+		return -EINVAL;
+
 	ret = iio_mux_select(mux, idx);
 	if (ret < 0)
 		return ret;
-- 
2.1.4

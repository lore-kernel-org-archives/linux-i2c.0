Received: from vh06.kantert.net (vh06.kantert.net [5.75.216.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18F1F5842
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.216.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772190853; cv=none; b=cLgum05LgHWx/GVDSn6mGevm/MFZ3hVNJgEqCAwY1XrwFsAOFHHMCmw3UGbXotLeSGZbBBoYNAHiqrtJovB8xBrtGrHHNy9mow4bc37Fftd7LPMNridNJg4t4tijCjzetemqs520FMe67EKqMySWlJgr8ROV/UqthLWc6XWEpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772190853; c=relaxed/simple;
	bh=UksT+1ZpJ8dxACJ0CV8uegefYrT7fFGKgQhOPhEIgm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVdFQ10Seo1d3do50mpZCIp/1wkIf1b5Bom2R8V4c1wbIlk8y+DAoeRWLWgB+g5JX1mq2u8/8UnCtGNTHuUruaiUVy6nlrVUN2mV+R8cTSESl3verzjoo5YKdgBLLSnvR+ACOnGPubAWi3yJUekeRqrS+ABeWpsz5zita4jT/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kantert.net; spf=pass smtp.mailfrom=kantert.net; dkim=pass (2048-bit key) header.d=kantert.net header.i=@kantert.net header.b=A++q9Tec; dkim=permerror (0-bit key) header.d=kantert.net header.i=@kantert.net header.b=/QV2KTeg; arc=none smtp.client-ip=5.75.216.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kantert.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kantert.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kantert.net header.i=@kantert.net header.b="A++q9Tec";
	dkim=permerror (0-bit key) header.d=kantert.net header.i=@kantert.net header.b="/QV2KTeg"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=kantert.net; c=relaxed/relaxed;
	h=Message-Id:Date:Subject:To:From; t=1772190709; bh=xohdy1VecBXWSfTiTZDR4iX
	0PchP9QrVqX/03igd2tE=; b=A++q9Tecx3ZoevS3EM89c5YImwn79zpRwHgMZ59BHJuqC8No3H
	fqICcnB4vuaW2gGO3Axv0tjHKDhF695Rfw9AT1LAugc3oElm+4w/1IFF6r1A6MrJYCPEPvy3Bp9
	eDcFy49yq6h8gTIiwgiQ9LooDckzBfWzrEXX1sxk83Re8u4x/e1ZNMffTVlNBnsRr2LD5EGALu3
	aoUMp9nK48bGfCXqHO3O2c+Jwr8/v+D5c4xrhIIz7ZQ4RzwSL2xujN4KoNOPhgnF0EUNl2vXu82
	GbqRV59ZjmFe8u5GiOuinUUweb/OBgSOp33pCsBB6UUKzmXLsTKXZUTlmoj81ukTMHQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=kantert.net; c=relaxed/relaxed;
	h=Message-Id:Date:Subject:To:From; t=1772190709; bh=xohdy1VecBXWSfTiTZDR4iX
	0PchP9QrVqX/03igd2tE=; b=/QV2KTegiyIxmW1151AfvCZ4dck56aUpsW0GrMSnj8Houvh+jG
	Omr4OnovZdPRyg2fHUGun9aRPqpEsg0hMbCw==;
From: Jan Kantert <jan-kernel@kantert.net>
To: chris.packham@alliedtelesis.co.nz,
	linux-i2c@vger.kernel.org
Cc: Jan Kantert <jan-kernel@kantert.net>
Subject: [PATCH] i2c: rtl9300: add support for 50 kHz and 2.5 MHz bus speeds
Date: Fri, 27 Feb 2026 12:11:34 +0100
Message-Id: <20260227111134.2163701-1-jan-kernel@kantert.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SFP modules on certain switches (for example the ONTi ONT-S508CL-8S and
XikeStor SKS8300-8X) exhibit unreliable I2C communication at the currently
supported speeds. Add support for 50 kHz and 2.5 MHz I2C bus modes on the
RTL9300 to improve compatibility with these devices.

Signed-off-by: Jan Kantert <jan-kernel@kantert.net>
---
 drivers/i2c/busses/i2c-rtl9300.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 672cb978066d..67a5c4228fc9 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -11,10 +11,16 @@
 #include <linux/unaligned.h>
 
 enum rtl9300_bus_freq {
-	RTL9300_I2C_STD_FREQ,
-	RTL9300_I2C_FAST_FREQ,
+	RTL9300_I2C_STD_FREQ,			// 100kHz
+	RTL9300_I2C_FAST_FREQ,			// 400kHz
+	RTL9300_I2C_SUPER_FAST_FREQ,		// 2.5MHz
+	RTL9300_I2C_SLOW_FREQ,			// 50kHz
 };
 
+#define RTL9300_I2C_MAX_SUPER_FAST_FREQ		2500000
+#define RTL9300_I2C_MAX_SLOW_FREQ		50000
+
+
 struct rtl9300_i2c;
 
 struct rtl9300_i2c_chan {
@@ -433,6 +439,12 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
 		case I2C_MAX_FAST_MODE_FREQ:
 			chan->bus_freq = RTL9300_I2C_FAST_FREQ;
 			break;
+		case RTL9300_I2C_MAX_SUPER_FAST_FREQ:
+			chan->bus_freq = RTL9300_I2C_SUPER_FAST_FREQ;
+			break;
+		case RTL9300_I2C_MAX_SLOW_FREQ:
+			chan->bus_freq = RTL9300_I2C_SLOW_FREQ;
+			break;
 		default:
 			dev_warn(i2c->dev, "SDA%d clock-frequency %d not supported using default\n",
 				 sda_num, clock_freq);
-- 
2.34.1


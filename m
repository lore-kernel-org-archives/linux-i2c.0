Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694598;
	b=1fCjHLYWmg9gapwFZGlw0Wa/HExnbjEQkKeTfBTql5tbVO/T7ox6NhL8ESCaUyx4EmrF
	 Q2fIT1UfC9RFcgkKLzM76Blhxu4hQaMT56aPYytkYl/W/UhUJqZf4gQVW+lJa3WX+t9v8
	 6SWfnvSHfVcbnYmUlcRHkERKFYzlxe2Awr8lFgeZjHTuYraZIox9SYHO0PCpSlCGYfgF/
	 sfq4cZxlwqR1o9eM3Z8dqm0zhdiZO/i6X8OWKICoAMva7ILAjusbxbJHiAxP5eL8wd85m
	 erHVBBqMGMLeWKRQogb4MB1SwXEzigbdVF81pndLmDY0w2bl3fM2psF8pSvSSeg0ZQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694598;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=o3LJ0Hj1WCiPYc9EufOE1mRGFeHL/H8/8bQjlcMAaT0=;
	b=Sf6gd183/YAojtAK74DWZk73OAImU2p5uievFSHDYTwMdUX2z26UzedRJuGvV9w3/x0x
	 yD+lbpod9MaywYxINbYVnt+AuQS19ntTr/J/OauxbGwavu+Z6HVz2HbVi5r5t6zMiDNa6
	 sHhYu9srtQfx0lh/TBDf0q8xHIl1LCMh0sa4+i1ib016CqhteP/i8TczKs//m7OwsWb3c
	 +ZJTlczK1cRSUAzN62jafz7hQ94vwY48c7ug817IzKabHjqb3uGOBNZHtMThCHMmISvsq
	 RyT5Y5ThlYPTH/G1jNXogy8F1nFjOUvI40YXZxf+jn9QpedC70VGcXNx3ktpiRaKY/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B455606A326;
	Tue,  3 Nov 2026 08:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B455606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694602; x=1825230602;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EHNvnomPYWJp5Iwb8XgCJS4byDJYYpzu7MQG1ZHfDDs=;
  b=Q0+0hKhMJ71IPRMWt5usbU55EN3FnSg4MHJ7m8IPmmGIXbhTK1CyuhNc
   o4QIZUROHIzajYkCoyf0fzITrlAtzW98hyGw+hYvMpRD8fIj3T6u8hW20
   rYjgwRywcoaeJvd9EvNefanp6XWO4gNyVSMbLUFxUeoO5MX6mn7/XEfzR
   i6WIytGt0G65BtpPAqiW82+O/3CsQlVPjuy6SWwpA5FALMKg0otvooFtH
   xlFUjZhJPFS2Le1uWHQWclIA9TsYvTywlF7R1dlpBoVezxd5kmOsuHBRC
   rI4lptoym+FjWqlFuq8miEgAdW1JLnooAAW68+yF2R7A9tDltwZnRzjxB
   A==;
X-CSE-ConnectionGUID: mkHVKEemQYKyShKrAcDMuQ==
X-CSE-MsgGUID: 9ReKZA2BSwGantYAUKCrTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:29:54 +0200
X-CSE-ConnectionGUID: yzbgF8sjTtuqhosP4VXsfQ==
X-CSE-MsgGUID: PhbRgaCpRbupdCDZWfycYA==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 03 Nov 2026 10:37:33 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:46 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:37 +0200
Subject: [PATCH 1/8] i2c: nomadik: optimize struct layout, change unsigned
 char into u8
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-i2c-nomadik-fixes-v1-1-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

Change type of `tft` and `rft` fields of `nmk_i2c_dev` structure from
`unsigned char` to `u8` and `buffer` field of `i2c_nmk_client` structure
from `unsigned char *` to `u8 *`.

Put two bool variables `xfer_done` and `has_32b_bus` and two u8 variables
`tft` and `rft` together in order to reduce struct size wasted for padding.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index c3878670da9c..45b4815b0945 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -170,7 +170,7 @@ enum i2c_operating_mode {
 struct i2c_nmk_client {
 	unsigned short		slave_adr;
 	unsigned long		count;
-	unsigned char		*buffer;
+	u8			*buffer;
 	unsigned long		xfer_bytes;
 	enum i2c_operation	operation;
 };
@@ -187,13 +187,13 @@ struct i2c_nmk_client {
  * @clk_freq: clock frequency for the operation mode
  * @tft: Tx FIFO Threshold in bytes
  * @rft: Rx FIFO Threshold in bytes
+ * @xfer_done: xfer done boolean.
+ * @has_32b_bus: controller is on a bus that only supports 32-bit accesses.
  * @timeout_usecs: Slave response timeout
  * @sm: speed mode
  * @stop: stop condition.
  * @xfer_wq: xfer done wait queue.
- * @xfer_done: xfer done boolean.
  * @result: controller propogated result.
- * @has_32b_bus: controller is on a bus that only supports 32-bit accesses.
  */
 struct nmk_i2c_dev {
 	struct i2c_vendor_data		*vendor;
@@ -204,15 +204,15 @@ struct nmk_i2c_dev {
 	struct clk			*clk;
 	struct i2c_nmk_client		cli;
 	u32				clk_freq;
-	unsigned char			tft;
-	unsigned char			rft;
+	u8				tft;
+	u8				rft;
+	bool				xfer_done;
+	bool				has_32b_bus;
 	u32				timeout_usecs;
 	enum i2c_freq_mode		sm;
 	int				stop;
 	struct wait_queue_head		xfer_wq;
-	bool				xfer_done;
 	int				result;
-	bool				has_32b_bus;
 };
 
 /* controller's abort causes */

-- 
2.43.0


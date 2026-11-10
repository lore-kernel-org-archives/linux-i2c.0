Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316048;
	b=0pwLXc5xB8LjjDH0r9ZJCmmKmZkVK5UoPzy3tNPUDt3E7uA+MgcH6wMhhH7SOBnBwL96
	 XmuK8594qoFrKvByMh2j7T0nm8s+t0P8tHqGvTlHxu3t7iofnXwflVXQD6/beL3OEWiOf
	 6P1iH5ieQxpooUO7KDrTkxWhmzbN+dqkrYj0iPzem4fjvbXBRV1cTylMybE0LyVbxXNy8
	 nbJCQOj7xh8+Sr+wnMsc3YG5K8jP1S8Yq605ihV3Chy/gg7KAgSxGj2ZrLNjP8tNYnPTa
	 Dj6mcRkTcFc5ni1t6f9gvmjWtqlL5VLDydzNQKinPwHrjC6ykG4RvknPVLLNH80TApw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316048;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=ld7tlpB+QzKUKDfK4FSxy2dA1rDs18hbb1XMFoIOhuI=;
	b=VSf4fTZes0veiLZ5dc4CaPVUDvj/T52zqcJdWyL+czO9ivAxZlt+vRazgWNEjirwtbp3
	 TpCEEHOGq8iRS805SK83x46DpFb7+IcCKUJo6UzYUc+VCWk+lNQdr1IKGnenHyUIY48D/
	 2hkqhQRecyaO0c9EcpGNC0c6os1BsEWDqVErnX2BKtfG82QC5wpI9rV0PNmROKVA0HaOP
	 SO3cfsWiiB8FTdfZ4YbBV6mbRBEPqk4463DceDo48SBXvwYwFjS9HM5MyipaY2vYAVRjz
	 Y3X3BEWsAhvSxI0BbTZvcFSQnXFPNzGEPVVtUHdizQpPxoX5UhdMwJwjSAJerQIluOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90556606A33E;
	Tue, 10 Nov 2026 13:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90556606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794316052; x=1825852052;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=FZcWkIhdyH5Ehmankjtvhx6cnha9ocIFxpZgxmcPbeA=;
  b=QZcalDd8Mjf4tv7216mvRiZ7hk7+V1moeJd8xCME+NjZRvozihDHuCMr
   LmhpZaYEbfGybqHuc73mJjFdDF2BXZk9hhpIe7OG5vVKTx4tgEXK91BHV
   iLVTZ0jvto7TEm9KevBEZzaeDde3kGXqgxBxiwM43GQXYsAEQMHhQ/bNs
   /9FZmiyoSF2H0Ooo0we5RLbYdsFD06nEfCK+QsmIHrY3huv15TpUhXwx8
   jjEeroq0w5aKGIhzWaOddq6MsZy745z4/f08ZJP0if5ARAwQtQZ0etCxb
   L4bdClvHohugYbcxl0ddIv46703ENUTetA7euZCMnn+4Z68rmJsfaQ3YH
   w==;
X-CSE-ConnectionGUID: oz70YvFpTLmcpvIlRBAtVw==
X-CSE-MsgGUID: fNuTcHKpTeWL7Y0p/xkBOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 15:07:24 +0200
X-CSE-ConnectionGUID: pPHsg/CST7OIaJsAEVnfQQ==
X-CSE-MsgGUID: wg6sKAfvTLS91yli0OgcOw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 10 Nov 2026 15:15:11 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 10 Nov 2026 15:07:15 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 10 Nov 2026 15:06:16 +0200
Subject: [PATCH] i2c: nomadik: handle pm_runtime errors
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
Message-Id: <20261110-i2c-nomadik-handle-pm_errors-v1-1-ea1ac92af8f4@mobileye.com>
X-B4-Tracking: v=1; b=H4sIAMcW82oC/y2NQQrCMBAAv1L27EISmop+RUTSZKurNqmbVoTSv
 zdqjwPDzAyZhCnDsZpB6M2ZUyygdxX4m4tXQg6FwSjTaK0VsvEYU+8CP7AI4Uk49BcSSZKxPhj
 b2tpZtW+gJAahjj+//On85zy1d/Ljt7kZQq+pfMdNW5YVNuTAA5UAAAA=
X-Change-ID: 20261110-i2c-nomadik-handle-pm_errors-4925b54a5076
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

In nmk_i2c_xfer(), pm_runtime_get_sync() is called on start and then
the controller registers are accessed without checking the return value.
If pm_runtime_get_sync() fails, access to the register of the device that
was not correctly powered on may cause a bus fault or other unpredictable
system behavior.

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() that
always return 0 on success and automatically restores PM usage counter
on failure, and return immediately if it returns any error.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
This is fixed version of patch #6 in a set of fixes in i2c-nomadik
driver:

https://lore.kernel.org/linux-i2c/20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com/

Please replace that patch with this one.

Changes in this version of the patch:

- use pm_runtime_resume_and_get() instead of pm_runtime_get_sync() in
  order to automatically restore the usage counter on failure and always
get 0 on success (pm_runtime_get_sync() may also return 1 if the device
is already active).
- use variable `status` instead of `i` for its return value.
---
 drivers/i2c/busses/i2c-nomadik.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index c3878670da9c..74ecf188c9eb 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -713,12 +713,13 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 		struct i2c_msg msgs[], int num_msgs)
 {
-	int status = 0;
-	int i;
+	int status, i;
 	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
 	int j;
 
-	pm_runtime_get_sync(&priv->adev->dev);
+	status = pm_runtime_resume_and_get(&priv->adev->dev);
+	if (status)
+		return status;
 
 	/* Attempt three times to send the message queue */
 	for (j = 0; j < 3; j++) {

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-i2c-nomadik-handle-pm_errors-4925b54a5076

Best regards,
--  
Dmitry Guzman <Dmitry.Guzman@mobileye.com>


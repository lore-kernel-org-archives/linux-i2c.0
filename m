Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58AEADC
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735050; cv=none; b=o6VNs34bfBGQXwbLSdVrM9wyjd8sNLWd4ZtABbDyCqDTSt2XrRIaQYWMMSjck/07zIWtqBA6J148yjyzqH51j7wSJi/0N+TTPBLFLip9Rzd2cPCFZp7EZtfHGkG0rynBUs7NPv35IfX06t9TSdyo0lmADARzrlvjo3jtChygz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735050; c=relaxed/simple;
	bh=kGZ0tLwLnwzr7LxnHnrl3I3NK6euqcwdJ4ksABlfxEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHzoxk8zhTolyaDF7aV37peeEHofFDydlpf97thqnCSv0cYl9UbkdUayGMjssec7AwHZ11FwYcTsj8hCayMz2Isdxtp0xiefN4aEvHNc2AkSXHJw3PI1JXVCS9tIEyBPT+m0Mb47pR0elUi6Rz4PiWcaYS/JGuoePNnAp8OLTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay0jDLbB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay0jDLbB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso527324a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782735049; x=1783339849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HkTwtsCV5AvV8Jll6hL4RUUQZmIxHwSNCec69nQjhkg=;
        b=ay0jDLbB4Zoa3DqGguB/NvK+mD2W0M+3tch7fMRuUAeL+QeWqxGZSNHtvnxlmnNbUe
         D/dMe0uniCRXdbFioDvEkSIbxlPstzUhXTNDWysebRvq0OsDY9T11XLNIw+4dydv/LDU
         17Q1k/AqiPseZXk8c/a6nHIosW7ePSampg1KWj3LVmoq9b/uITPy8wXJCoqxrauVEV7o
         KysnBJW0/BnnMZsB3B1PAFowx/rYcSYYdSXGrdrdagbV55VuRLctma8SLs8tOHyv6050
         SgrLzI/b0XZq8kfya5AIgs/MEUGd50f7nuBMWy1OVq9y9ARAAFdDqA2WcYLbkk+G0roB
         BoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782735049; x=1783339849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkTwtsCV5AvV8Jll6hL4RUUQZmIxHwSNCec69nQjhkg=;
        b=jHXizHHx0kuc36aJSvmW8PLB+tQsDoiKwS66dCYHab49uLimKCeGki3hmbGDo9Gv1m
         tZVe8qVPa28jIKdRvkxzf1AXNDr9QztO28Y/uYs0zaMffCP7pnqdMlHYp17fFVWwndo0
         nBF152MqorW62tej8ObpamE69ZSMlxSodiluz1OOW2L01SZRmBuMwRGjv0/LpMexbE5r
         YCnpgd26HWjkRDsXbyA/WV679cF3tVtQxvtWulkmrGo1Dwy77YFRFDUKfrc6Q8esDAFt
         8G2x0+ZpgQsctWHQi/soJnvBq1dAzx1W5PhTk1Pyg5TvJkERYSg0J4nvRDzazoFijp+V
         zzfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqP4/r7jyAEume5E5u7NJXCHvDwJGUEs0ws+X+oGdsILPnufE3LCgoenbhCxXD28LcA25tn/bHfMEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYgZgYCM/uL5bsifbDEk4YpL56JHrO/ngDuQSJ/6Et6HfNh+e
	Mf2ToRnD6Tyx+CXtIxifAlVE4mtQclQZJa330yUE9tStkAf1ZpkbNA/qWAHd5A==
X-Gm-Gg: AfdE7cm24ZD8Qu15vGTix2pnCNpckJRQLJVbRdCCt+vUUUiv3hJvswj3mrR+TlwaAnl
	XSPCXuAIck23MAAykDi5TabMuimeP/URMLqAqsOIpYsz5oI7gHuw8VBhE8ni3JJp+ZnKNVPtcQX
	auMiH1b/JLb2PshRn0vd5exfQtI9MaodtsSRWjgp+2XDS45JsaHcWGPpg3EiCgRE5PbnPMy033S
	drDNgEn/OYuz2SMVKMLcvyA23GJTBwwCPBUN3m5TFvo5+kzyorzf++rrpy+YX4LKfBGk3snW/UF
	+tIDoImBtMAa6doEWLIBDP0sIdODA4/anM76MROBkeeqMRD4S1U8iN3Z0vr1iYdiIntrx0Qb3oL
	tMPncK1YgTbbwlEY53j66je5krZP5H/matJw+WjFpqadKgZf0zizQY6AD3I1ZfPRQ0TbkFyeeRL
	QNrB487+wJZxz2DN5aT1cej2EB85lgVsE0iQfj2Q==
X-Received: by 2002:a17:90b:3f8e:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-37fdb062536mr4606010a91.22.1782735048852;
        Mon, 29 Jun 2026 05:10:48 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e12c79443sm3955990a91.1.2026.06.29.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:10:48 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Jan Kandziora <jjj@gmx.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: ds28e17: reject an oversize length on an I2C block read
Date: Mon, 29 Jun 2026 20:10:43 +0800
Message-Id: <20260629121043.199487-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w1_f19_i2c_master_transfer() is the master_xfer for the DS28E17 1-Wire
to I2C bridge. On an I2C_M_RECV_LEN read, it takes the length from the
device. The downstream slave puts a length byte in buf[0]. The driver
then reads that many bytes into buf[1] with w1_f19_i2c_read().

buf[0] is controlled by the device and can be 0 to 255.
w1_f19_i2c_read() only rejects a zero count. The caller buffer is
I2C_SMBUS_BLOCK_MAX + 2, so 34 bytes. A length above 32 makes the read
run past it, up to about 222 bytes out of bounds.

The SMBus core does check buf[0] against I2C_SMBUS_BLOCK_MAX. That
check runs after master_xfer returns. By then the write is already
done. i2c-algo-bit rejects an oversize length before it copies, and
returns -EPROTO.

Reject a length above I2C_SMBUS_BLOCK_MAX at both RECV_LEN sites, the
same way i2c-algo-bit does.

Fixes: ebc4768ac497 ("add w1_ds28e17 driver for the DS28E17 Onewire to I2C master bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/w1/slaves/w1_ds28e17.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index e53bc41bde3ca..b638963d4b595 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -389,6 +389,10 @@ static int w1_f19_i2c_master_transfer(struct i2c_adapter *adapter,
 			 * another simple read in that case.
 			 */
 			if (msgs[i+1].flags & I2C_M_RECV_LEN) {
+				if (msgs[i+1].buf[0] > I2C_SMBUS_BLOCK_MAX) {
+					i = -EPROTO;
+					goto error;
+				}
 				result = w1_f19_i2c_read(sl, msgs[i+1].addr,
 					&(msgs[i+1].buf[1]), msgs[i+1].buf[0]);
 				if (result < 0) {
@@ -415,6 +419,10 @@ static int w1_f19_i2c_master_transfer(struct i2c_adapter *adapter,
 			 * another simple read in that case.
 			 */
 			if (msgs[i].flags & I2C_M_RECV_LEN) {
+				if (msgs[i].buf[0] > I2C_SMBUS_BLOCK_MAX) {
+					i = -EPROTO;
+					goto error;
+				}
 				result = w1_f19_i2c_read(sl,
 					msgs[i].addr,
 					&(msgs[i].buf[1]),
-- 
2.34.1


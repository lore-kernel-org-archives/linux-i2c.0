Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399844;
	b=29us8oewGIt4J7NxgE129d6G06Jf7tSkRKaSvbDfqMpQAg91K/zvL/Yv3pqsnwhOuKHU
	 3L+yvIRoCQFn8NmMp3xciAQXhUbE+28fLCCo8mw361I3rZ11yjh+wvyPDDTWUbTRCCnj+
	 FyrigIxT1SCkpC3j/yMGksfzgUrtbYj59USiMWJiJurfMIffGV/jPr5tUt8ybNvgr4FNa
	 3fgg+8TknfiRGnfMCMj2BEXb8fmUf0CwY+Q/XHM1+RMSOKq8gAQ5X+Gfwbjk+k2hyoShp
	 V1EssBjcA0PfxvQmhVWqIckwpDxn/077uVSw3vRzvLWc2+N2/hBPL4eqcZjtOgjOCkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bn9sP7pOkBKUuF5Aq7GK16TVx6Ldega12jAxTTo8a7Q=;
	b=dtfCfDMujH+v5/cvD7qqsVm3ppM0lS2bR9YjfAcoexoo/PhBndIoujuqyMpm4TjpkhqV
	 lSVPESStW5IWAhHBrDnqXqrPNxJkWkPtNCFSOaMWd5pdmzi4UFGC84nofC8OkI4x+5x4e
	 OX2c2LjgNamgcpgTC0eK1VHbYauQfE9m5/+ch/044EhgMH+Zl5dMbyxsR36jpex/5by12
	 ke2wC9PQsxAfh0Pr5XidYrhQMlaDHjvwsTEeVpcNJUFGXDdUB9i/CKUr4BLKABkZ1Joul
	 ltEATmbi7M5GVpmTcdA6Yj4cVqaOORGx3/fCoaLA2EbyYTV7dkGPWVEMwRkItkZFoLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pifx0fcG;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001B60A2636
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 22:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7001B60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pifx0fcG
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so12180405e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399843; x=1794004643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bn9sP7pOkBKUuF5Aq7GK16TVx6Ldega12jAxTTo8a7Q=;
        b=Pifx0fcGwSiAi84R/0GyOiDP/sPeKP90ZZvgVbVXOHsH2qGKD3XFyMbA174DfwERc9
         mG7RpOYhEBdiVa5MQwQ2Fme1LYeS+0lcFcOUFqtQpDpOYCbA7vCLiaioq+aSMxVYgozA
         rzPrC/wQHbzD+V5Cp4+6VP4QjFzLgAMclAXOYTOfc6wxUVIP1UfPLNDGVVgkv1Ubg97j
         KAnY2zewv1DCOTO6++QBv/5OWrFzyqKCWx/mzTjVjMBZ3iwvYKTUtg6Kn1BYIcn+OxYg
         9ewL3rsL+yLP/jmv2l3u23dQMWIrylSv2IiLB4ZboKEB340ga9xp7o/cgDHDPTkxy5mK
         CDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399843; x=1794004643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn9sP7pOkBKUuF5Aq7GK16TVx6Ldega12jAxTTo8a7Q=;
        b=E3leBeavtKi50+uu4OCm2HxnaFzClbnnsXeIa/16P9E6dbQSLdDelMhL+OdCdINBUS
         9IlqhTbG8ayJczDme0ISC9F/gfeBGB1D3VWi2SNqIZEoUgn4clxa1RnUEnxN7HQVFQrE
         nUzuqjEvAndttXA19OWaqwGxZsja3p+RdJzwB50IRL4J1PSrgCB1AgCSiJA/vZOU6ntb
         r6FUc9t6c5FJ1rlYFdcYeB3c7Z6f1P0J1tnAnpAnlyXqpSRaeHxFKJ4EmO8d9+FdE9U4
         JInCra9UGedgQvQvxVY2r7OQ+bH+OK+Vsyk64d/7RvKJxKluWhUwDBu/CbwO9/wFZibA
         YkAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm0QuYuV/MvTdADkSoNV2luMr8Wl43k0o6SabU+yilMbpx42JOFk5UFd5900UO5/6WEQtmr8uNHS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpx/2qCdY5GaBPi0SYM2Ws+tPd3cP28Wm961nCMmNmI0rO57Zi
	jfpiGmfE11gwpCGdfId/3Yp3ahGdIV03igzMv9jbO+7Nk/E0tymsQHw0
X-Gm-Gg: AYBFou3/i6S2fxM65CHUi4h1qUexCsK8I3p7tXdfktrcqmRs984Nxq0odh4LtmbYTI+
	MMRiDzHauxcE05XAtj2ob3Te/MYEEyedoPJpcvGBnzmWKjrxGPCzHBoLjI5vo2BcWvKxYqsu0C3
	6IxaFbu8ZhgIGGSjkuxNQGHrDLeTIL9WObwVwjTl2QGcesPPCd1ErLWcqwv1aF4+GbA4pEvqGrt
	jKMIkqD8HvLdGzdFdC6AqDFSjZk+cSwPgmIu4petJGdqrGK1/InOjw7nHpEbAwbeihRcUI2g/ms
	3ktBJ7d+VU84aoo+S+Yxwhl36hcSb/NgceGskBNevz0DwbAU7FAXRX2riL6vqY0ofeTqWAQLe5U
	AcyHKDFMk+Rl7PpIlF77csrVrVjhG0iTyC9JOT6WamVbLPP5OSKCMYw+2NrBFF79lBAy5ASGncr
	UaM2Dtzz99YSOkPb07DFvdazb4HGNoR5CqrXXl7PP0u9bnAMSmZcRHWcdF7AMGxltM0qLa/QMP3
	Z5+e06yfWfymILOhko+IUiC+YqBWBOlnO2FEKkqOZ1/2y3p2mUSUBbQuiXdP+T9iY9729ZEpnxM
	yeTyB/gCkS9bZS+56XUjNRAfTtQS
X-Received: by 2002:a05:6000:1146:b0:48e:d40:a87c with SMTP id ffacd0b85a97d-48e64bba760mr13304359f8f.16.1793399842774;
        Fri, 30 Oct 2026 15:37:22 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:22 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v2 12/15] HID: ft260: i2c: abort in-flight transfers with STOP before reset
Date: Sat, 31 Oct 2026 00:36:34 +0200
Message-ID: <20261030223637.86907-13-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A transfer that ends without STOP leaves the FT260 I2C controller
with BUS_BUSY set. I2C reset (AN_394 section 4.4.15) restarts the
master but, with the driver still bound, status stays 0x60
(CTRL_IDLE | BUS_BUSY) even when SCL and SDA are pulled up. The
next START then fails with 0x72 (arbitration lost + error) and
further resets do not recover; only a USB replug did.

Add ft260_i2c_abort(): a STOP-only write (flag 0x04, zero payload)
then FT260_SET_I2C_RESET. Use it wherever the host tears down an
open transaction:

  - read wait timeout
  - read status check failure after the HID report arrived
  - write status poll failure after the report was sent
  - SMBus block read with an invalid count (count phase has no STOP)

Leave ft260_i2c_reset() alone for HID output failure (the request
may never have reached the controller), sysfs i2c_reset, and probe.

Tested on a UMFT260EV1A with a 24LC512 at 0x51. Five 1 ms read
timeouts each followed by STOP+reset left bus_status 0x20; raising
the timeout to 25 ms on the same loaded module then read 16 bytes
successfully.

This matters more with the 25/75 ms completion timeout from
"HID: ft260: i2c: reduce driver module loading time", which makes
read timeouts more likely than mainline's 5000 ms wait.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 43 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 923ce6ee9dcf..50f68790c04d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -549,6 +549,33 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	return ret;
 }
 
+static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
+				   size_t len);
+
+/*
+ * STOP with no START and no payload. Used by ft260_i2c_abort() when
+ * tearing down an in-flight transfer: I2C reset alone can leave
+ * BUS_BUSY set even when SCL/SDA are idle, and the next START then
+ * fails with arbitration lost.
+ */
+static int ft260_i2c_stop(struct hid_device *hdev, u8 addr)
+{
+	u8 buf[4] = {
+		FT260_I2C_REPORT_MIN,
+		addr,
+		FT260_FLAG_STOP,
+		0,
+	};
+
+	return ft260_hid_output_report(hdev, buf, sizeof(buf));
+}
+
+static int ft260_i2c_abort(struct hid_device *hdev, u8 addr)
+{
+	ft260_i2c_stop(hdev, addr);
+	return ft260_i2c_reset(hdev);
+}
+
 static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 {
 	struct hid_device *hdev = dev->hdev;
@@ -618,7 +645,8 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len, u8 bus_busy)
+						u8 *data, int len, u8 addr,
+						u8 bus_busy)
 {
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
@@ -647,7 +675,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 	if (ret == 0)
 		return 0;
 
-	ft260_i2c_reset(hdev);
+	ft260_i2c_abort(hdev, addr);
 	return -EIO;
 }
 
@@ -686,7 +714,8 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4, bus_busy);
+							   wr_len + 4, addr,
+							   bus_busy);
 		if (ret < 0) {
 			ft260_dbg("failed with %d\n", ret);
 			return ret;
@@ -727,7 +756,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len, addr,
 						   (flag & FT260_FLAG_STOP) ?
 						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
@@ -795,7 +824,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		timeout_jiffies = msecs_to_jiffies(timeout);
 		if (!wait_for_completion_timeout(&dev->wait, timeout_jiffies)) {
 			ret = -ETIMEDOUT;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -809,7 +838,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret < 0) {
 			ret = -EIO;
-			ft260_i2c_reset(hdev);
+			ft260_i2c_abort(hdev, addr);
 			goto ft260_i2c_read_exit;
 		}
 
@@ -993,7 +1022,7 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 				hid_warn(hdev,
 					 "smbus block read: invalid count %u from slave 0x%02x\n",
 					 count, addr);
-				ft260_i2c_reset(hdev);
+				ft260_i2c_abort(hdev, addr);
 				ret = -EPROTO;
 				goto smbus_exit;
 			}
-- 
2.43.0


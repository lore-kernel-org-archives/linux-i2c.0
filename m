Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7286470EB1;
	Tue, 18 Aug 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056887; cv=none; b=p4Ol+VIqykxDILDVn3CM+RFZtXz+YLX+4ES99YKQL1SiTfeI9jLQEVLKQKQt4eC/eaXbONkLvAq62ePh2HpOVl85+ampTakPeIpkgLPj1mR6fpKHGhuRnAMjTTmwO3uhls93HNlZiDqvOEqhkgnoPe0D0CNREV3eIt/Lmt16iPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056887; c=relaxed/simple;
	bh=jWxEA/E2S2zAN7oNXhbykcoRKOEWftg0hOKSLlBfgFU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=d3MdOgz3ornza2u3/8vGbBeosFkgIuGwPVBQZ4ZekLtDP00v03OsBkbsK5yOeUqZNyrLoM5M9dnfZ6RLE4XdTSFwTyzKedvqbunnnfq1Tbac8kRGRLwkxhG+9cwLHdJlx2OKum3XNgBZTDpLs2WO/ZNpwcSrVL6aZjF/8KnnH0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CjhRrIk9; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CjhRrIk9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787056876; bh=JfbO0cDnqgWBOb1iarH4/qeDyXN3KkCMfuT1xXMj5C0=;
	h=From:To:Cc:Subject:Date;
	b=CjhRrIk9Qx1S2k6di2BF0du8YBXiQ0JoYnPiT6/CY/lG/Uayb7f95N8qwYpIIru8w
	 8pH0RtN5omFL3cTamBKIrwDkDbJDG275JneH+rUOtYLJlZenb4l/MxvO3ZlDOn3PZv
	 Nu4nBEblJvD0gHl8QK99fSC8eMwCmN5uLwQ+YXdI=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id A4D8545E; Tue, 18 Aug 2026 20:41:13 +0800
X-QQ-mid: xmsmtpt1787056873tfen0heml
Message-ID: <tencent_C372A37EAC8803525A57CB890B30E0B7B105@qq.com>
X-QQ-XMAILINFO: MFA3rFz8fXqrdq8JljZvPuax1sPspw73NE+Y0HiMNAMLGSjf/ILSMl3E2vRg6p
	 0/sKmhCW8QqHqEHZptSW/XPzfjiK9KAixr370/GahAeVHDU0444oHzYDRkQGYugJFmTSvQzAG4bQ
	 qTAn+PQ6N1YHYJy2zxWu6Y1pptVeGPAilS6NbKAe4ry6QPIOOH1DoL2QQ38DD6gNO2VS0chGSpV7
	 evUAtzPx98ttxFb6bgfBmVSZBK+A88DigZckYhIUV/NIMC38rWI1Xrn7OSHTeKuPcRUcMQOU725Q
	 PZUH4+0ARWaesOlJVCpwg8Qt0WGlzDHV9pIa/jMcsqgxdVuEbAHd3vjBPpOQi4rZaJlMUFLhjogX
	 e1revQt6dbFGmis1qWBIaIR7r3kQLZH8hIYzJHdn5B0NX3taHcBLy2/njQzeC8sXncYbOdeKWgc1
	 i3LUYp/QQ66y7oAJBSBC9sQCvgQCjCOslBzQBMl3pIXgF1pS/nZLjLfAhXh3tOOQqZENR0gdfQVQ
	 tbgFEQp2LIp7VcaThD9F6ka/U6wfQx18wBj0V3PEqvXqGW8q2PBwC7NlCDF+JP+cACBPITfcBUVi
	 dxMX+L+x1FnL6k3hfxzYB57hhAwWsD4g4KYUPHU+f5Izb+xoh76l7jkfrMC3KnxNvBDRhmylRmlm
	 twRgC931tGRVqJaOxlPDinlH1r9n1a996+bsT+474hqUgVGJklmmTfIPNtAgPH/D2qOsYJxEZdv/
	 sHbMTcUF8Uunc+mdAEd+Ekf0PsyUGn0ByGa/VgfgZWWynK3aY/VOjwpzKXKhDPUzqJlWNHk738he
	 aE/sChyKaGjSyh9f64zBKXyWj7cSNba7OcE3ooYBQCZJnxslvVNZV1qDr4vYyFkaJNl1dBJltNEo
	 DY+oSZXe8OS3vjHHIPpznAXJhNWbpS7Ee23nQVc8RmVFE9Vd1YTLSzm5U+Dy8qEPSvwWMclGBq48
	 jXd0OliS9kCRT5oL9zkZNZcMJWM5XsAUI67hf0BpaTfpBsbXkSPxCwPlHbpB4MSM/7zhBk/SFBmP
	 r2sdHkprWkPpcKYTiYIH+rg3eCQ+66iPQZdm31m8dSTdqfO6NyTwTfbUjBq681XjYFZCPM9X4RNB
	 eU0EI5
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jiawen Liu <1298662399@qq.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jiawen <1298662399@qq.com>
Subject: [PATCH] i2c: axxia: disable clock after removing adapter in remove
Date: Tue, 18 Aug 2026 16:41:13 +0400
X-OQ-MSGID: <20260818124113.246671-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jiawen <1298662399@qq.com>

In axxia_i2c_remove, the controller clock is disabled before
i2c_del_adapter is called. This leaves adapter teardown running after
the hardware clock is off, which can cause undefined behavior or hangs.

Reorder the calls to disable the clock after removing the adapter,
ensuring the adapter is fully torn down while the clock is still
enabled.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -795,8 +795,8 @@
 {
 	struct axxia_i2c_dev *idev = platform_get_drvdata(pdev);
 
+	i2c_del_adapter(&idev->adapter);
 	clk_disable_unprepare(idev->i2c_clk);
-	i2c_del_adapter(&idev->adapter);
 }
 
 /* Match table for of_platform binding */


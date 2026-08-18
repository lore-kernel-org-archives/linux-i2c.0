Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D978471CFC;
	Tue, 18 Aug 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056887; cv=none; b=RTJWMHK2q8QfxhYwH+ApP3Krf0EFmmQfNLOAaEL33xeeNXZK9WG0s6rKqeVN5RIpbs4q7zHL497A2GWbAjST2gFSs50tZLoYJsV+zKJSxlCtakLz3y2Da/YsPR7bezyUIK8Vo5vsTwQZ4IDte/EFCHPxdKu5bp2Ps78aKTCLkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056887; c=relaxed/simple;
	bh=JbtXNkGspuL7Q+jWUtB+FZDbRNAS08dBlbFw0JGI6Ws=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ld8CzXZouT4dMfxZZHe4RreeCZaviQPinrNdkjtpnMLljN96TdMGeTMGiSgLkHcQIjyj/MnhgVILD+3/ActnYc0Bju1TjUIhzDimsgbzTFzAo6ZgPmMm8rYGKpzTCpVVbqciy1rKFzc9blY0Luj1A3KPjp3488r7KMJVfRN1RVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h0GETFbz; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h0GETFbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787056879; bh=BJQNpXc0ya1WN+TX0UpecmWu2MNTmLYNO2whLlTD9iQ=;
	h=From:To:Cc:Subject:Date;
	b=h0GETFbzD92oZYqIsAFTTxLZWmfAjhcvGOnh8gZPM2ACJyT4p8e23Zc9s51x0Veii
	 34BMS1H2s7xQF1RwOm1VGwLS5lie3JX7ljoByqkk+7LGO/ExuxwilEVwUJpFH26W7a
	 LLdpFe7j75zmHAQ/L4Eky+362ziaNrvIe9SaFCvA=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A5010876; Tue, 18 Aug 2026 20:41:16 +0800
X-QQ-mid: xmsmtpt1787056876txi8li185
Message-ID: <tencent_91A432B69EB44818B24B37DDE90E50EA7705@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoebvRmat116eaVwcXFolnffOCRAmZcJ3PxZHOUF94jMYV5bWJpCO
	 XVLimMqsNWB3UnhkYWvsXaHxNClE9+L32xdS0rmEqokccoo4j/EmwcFZcLqTzSaaXVrfbzJktRCw
	 2Mz6/iaRcGQKhEIT7/Shf9hSOFI1UZ3mZ7+mlGNVsKAlmVGpJWjlp4xkK8kWxHskmPsAgLms1g57
	 A8+d0BSOoHjgRMY30gfscBs+4kBRSUJfJRZWaB74pLDkPRDJMu5N8jxAIKwb6WFUOipKMPqMNYB0
	 uFF2l1w34xkEgWW4rF0Iq5FGKlp+BZN4qG0a7QtfxQaO+zAHO7eWQG3gfH+jbDrG7xyQVRsSYxrs
	 hQ0YZtvNockcNzc6gsjQcQD2Djb3aonT1dNCEg9RA6NXMJVHKu3hk+TUHBtxx6OzWPihFRGrci9W
	 C8P+Hku2toIF461333TEu8sN4liuzcdznw3zLFrPNrZk35PXVTSJ7zg4WbTH2rLCeuvFR0PXc6C+
	 zrxfOqhICPDDcxyAim0NHLR/OmL3+lM7pRepkltnlZkmOZ0zqGz2JkKeD9aWfsoiIu+ad0ThKKxM
	 PKgeceKfOdiQLKAmWlX90GoYWZf2FRcxmZbR065udqiFWvI2IqnarfqK5tnMch4Vmzm/gqGcXc6a
	 FoPf037LzDks7cZk3gRA1J9xrb1riFFU1qCd8PfK3nr33uyB3TbIyD700r/XoVJ6pymdi+7IrW/m
	 wQQKuWnCr2CrsfTPUKTA2jmkenle5BD0dVvZnD5Bg6w5LZ20ioaOFpUqtTPXNRzMiLaV4CLp8I2p
	 Y3ooHc0xekJd78jiWGZ/b52hoeTotu541AL3EHQNOxK8/KWGrB96eOq9pTJdXmbztgAvcnYWleBH
	 gMqKSe5V9yRHqs1wY3/VuX0CTzL4jDX2juMQBAxnEtD0y5yFBNseAXUVrPcV6dKomodXk2h6Mb6E
	 A4rcvP4ijloFHnajYn79eeDHpjcu8vUNnpUZtEVM19AUXthstDV6hzhhgKWSW+PCDLuJymAT1qyO
	 cyetBWMgphWMXan/RknFYSXNXtbKWe/yYLOV8mibyr0U0SheoSZc63uiPhaqrwPYe/hjgSi8POnT
	 tKIMRmTe4qFlxl2cDTN+QPSug2/w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jiawen Liu <1298662399@qq.com>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jiawen <1298662399@qq.com>
Subject: [PATCH] i2c: microchip-corei2c: disable clock after removing adapter
Date: Tue, 18 Aug 2026 16:41:15 +0400
X-OQ-MSGID: <20260818124115.246682-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jiawen <1298662399@qq.com>

In mchp_corei2c_remove(), the controller clock is disabled before
i2c_del_adapter() is called. This leaves the adapter teardown running
without the controller clock, which may be required for proper
operation. Reorder the calls to disable the clock after removing the
adapter, ensuring the adapter teardown runs while the clock is
available.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/i2c/busses/i2c-microchip-corei2c.c b/drivers/i2c/busses/i2c-microchip-corei2c.c
--- a/drivers/i2c/busses/i2c-microchip-corei2c.c
+++ b/drivers/i2c/busses/i2c-microchip-corei2c.c
@@ -621,8 +621,8 @@
 {
 	struct mchp_corei2c_dev *idev = platform_get_drvdata(pdev);
 
+	i2c_del_adapter(&idev->adapter);
 	clk_disable_unprepare(idev->i2c_clk);
-	i2c_del_adapter(&idev->adapter);
 }
 
 static const struct of_device_id mchp_corei2c_of_match[] = {


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B8C8EB;
	Tue, 23 Jun 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250815; cv=none; b=MGJffaig/vvQVFJzoYDrXKoxGMtK1yOnPSZnT3ix5rBv/pLEkWsr4fclaMrKAHRl4qno4DzA7W1U1FEgv7aRLBslTAoSJBKKY0T2Z6iOLjePk7P0lvVKG51hbS3DkLy0koFWGCG84OUb40nDN0Ksinmy8Y6BJYVkB2Hd/+V6miQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250815; c=relaxed/simple;
	bh=JI38z1jaLCsFKYh18Ni5/rwQP2sXh0iFI1mRBa14wxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fRfaM+kQCbKavWuWG9GDjvNtaJIQeVWPVpK3rVWWtLQ/M/LbxguJR4qzwAw1LRV+cLnFd+rcoecjTVDV3lhcmoeIENG7cMPXOfB1M3iM7o3fIgPnjlF/085uUUj8dikyTb7uHEkJ7ETGbXsLrDMVNaP1rlBKCRp1LuK9zBW4HWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGbVvCP3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGbVvCP3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 026D5C2BCB8;
	Tue, 23 Jun 2026 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782250815;
	bh=JI38z1jaLCsFKYh18Ni5/rwQP2sXh0iFI1mRBa14wxs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cGbVvCP3pMcadM9zoMn7NyrmKKSP6GInXyGoHbfW/jMrb5154+VimaxpH2CmZ2GMa
	 D6Zwe3t/DwOqg0M9R/hMOvxV2vfLvFae+IDWt7ecFUIBxLqN1UtDpW/YuLLH3C7N4p
	 kwmSUkF3b2q8jqxUIex3fDO1Su1U57PbVyMQSrRqXV2/wlg/3tomenj8+PmwHG2IS2
	 YeJRNsZCtOpgHQGOWz1x65CyN+jgxHdBSbGpYgXJQ23GxIwkSdF0rFmmwtnZpJYZ+k
	 01zFwaC2xk2a4jOpF7jfQp+on8WiaRSe3tDZ0qv/03+A8O4u0/OuUN/Y6ihfmBe91M
	 tSBOh8kQksQ3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58DCDB47C;
	Tue, 23 Jun 2026 21:40:14 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Wed, 24 Jun 2026 00:40:13 +0300
Subject: [PATCH] i2c: mediatek: fix WRRD for SoCs without auto_restart
 option
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-6572-6595-i2c-v1-1-9155cebaae20@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNjXTNTcyMgYWmqm2mUrGuWmmyZbJJqlgiESkA9BUWpaZkVYPOiYyH
 84tKkrNTkEpAhSrW1AIYrn0FxAAAA
X-Change-ID: 20260623-6572-6595-i2c-6ec9c4e6a6a6
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782250813; l=1767;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=TG2emG/PCj4Coy27v6ImKi08qxfg+rKakjADtWBifso=;
 b=MuDkLvPkgVRxiqfkdn6qowJfHL5BjKXog1KYCzBl6lSkA60ha518SEnL4W5DoJjBD4Idz6x8Z
 SUQMLDg76jfBE+L8FJc9UxV+vq91u4HSMSUjKXmtKe7KS9p2cwApUpi
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

MediaTek mt65xx family SoCs have no auto restart, however, they still
support the WRRD mode in the hardware. Because auto_restart is set to 0,
the WRRD mode will be never enabled, leading to read errors.

Fix this by removing auto_restart check from the WRRD enable path.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
This is a preparation for the mt6572/6595 upstreaming.

mt65xx family SoCs don't have auto restart, but vendor kernels keep using
WRRD mode. Lack of the WRRD mode makes i2c reads impossible from both
userspace and kernel drivers.

Without patch (mt6595, da9210 buck at 0x68):
~ # i2cget -y 1 0x68 0x00
Error: Read failed
~ # i2cget -y 1 0x68 0x01
Error: Read failed

With patch:
~ # i2cget -y 1 0x68 0x00
0x80
~ # i2cget -y 1 0x68 0x01
0x00

Same behavior observed on mt6572 devices.

This change doesn't affect SoCs with auto restart option.
---
 drivers/i2c/busses/i2c-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 126040ca05f1..307925fb78e3 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1258,7 +1258,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	i2c->auto_restart = i2c->dev_comp->auto_restart;
 
 	/* checking if we can skip restart and optimize using WRRD mode */
-	if (i2c->auto_restart && num == 2) {
+	if (num == 2) {
 		if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
 		    msgs[0].addr == msgs[1].addr) {
 			i2c->auto_restart = 0;

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260623-6572-6595-i2c-6ec9c4e6a6a6

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>



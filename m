Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440E4582C3;
	Tue, 18 Aug 2026 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056878; cv=none; b=nivWca9Oig0q+0yvsadOR/kjNio46c+1Z0TJz/e4yHkQ2BGD+12cOy5XMm1IcX34hknYjkpua8GIxdtAS5wmw6kYrSSIuCwQEv3Yg30veoWywX2FyeDfs9uXxAMBsGFBQMQpDwAyHuEiuus3uv+b9nuD/J8AoxzjdaUIyDecppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056878; c=relaxed/simple;
	bh=iqngbdBOuFRnJy98deyERyp7TRYqktVZRrHwHtT94a0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kGRU0+821Zl9PnkRHyLXNyfWAPlDmb52HDCvEHnRwTSeoPUkRs3GzuOkj2HyLgIcqpuZv56IDlsg4GDricZNjb4iPglNxmE1YPdufFyN8Fn1fsjxtFSHw778xqPyBivgpcfo2feHooMMN770gbaupQu1CaRlEXmQPGKGk7F7KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Dc8cw861; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Dc8cw861"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787056873; bh=k1oMWhP6N0pDRhJpZ13pH5FkWsPcynnErXbUERx6smg=;
	h=From:To:Cc:Subject:Date;
	b=Dc8cw861fEqZb940ZBz50cbHQRDptDb9VOFVeFwR/x0cznRWe4EiTbKmqXqFr03DO
	 ASs8gP2isWy5klhHH7hxMIyNUukbMI6zLX12LHP/Mu+8DYsB3OcdCPbxHDoMAHtsg1
	 KULBP3KOOCVr/NHCBS1oEkMtmszVqIrb2bq4VrXM=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A4ABC83E; Tue, 18 Aug 2026 20:41:10 +0800
X-QQ-mid: xmsmtpt1787056870tzvk28xyn
Message-ID: <tencent_A6BBC809D24E57D92919D0E257A5D2B8BE05@qq.com>
X-QQ-XMAILINFO: OK7NBzdNss/R/i3m82SoO25bV7M2KPw+CgM8uk/zmbnT3sCm7B33KqutRk4e5G
	 +om0HpmAI00S2wd8oJPosNhbbM6HP8AP8te28nSnu/14d08APKKeMqhqynR4PcbJnj6rc88sR/mK
	 0JXTcnPCxK0tiuNe3G67+i5Y9fOlEBEWFZrBidBOwidRT4Raa5+GzyeFohgK0GXSCqiF4xJQmbWp
	 IS0Qk1U0NNekKWrzhT8uBDBDfjRb+PPhKoIo6iKgPQd+81MoApXThsI2jScACSoDvT3dVQwIALJC
	 TUXQSeCMjcpb5wHBjJEGvvx16qlw6qcNIGJ/qdKTGBo7/6xWxassEzkAeAmISzJITtwiVvVdhsda
	 Eaj6RGmreoe+e4AgEPzOta2Sw8At4dAn6WfCoJ3qzPVgtiXaMsy2Pz3xLkwLbbAcknpblYQW3DKQ
	 PXBHhRmaha/Qk780chwa1VhoBpj8vRLEv783ow+D5Qq3Nef4WEIEZqQxNOJLwnxED2o/8hF4f0j7
	 Thfy70GEyNwVdvY276JLisVggcI9OfjQyS+GF5cQLBHwgEWhVYMkioM2xXpw6t7T10N+ZI+3QLn+
	 iuewKCMV6/v/Cltd8OJ15aul1L3AQ2IfKy/6NGL8yl8PGZ/rRjtaCPwVqDgs7vP850g/NFzhZMXA
	 GJfyJGYDKwBw8PcCSr5p+KP2MRCpHDM1hmwieIhB2PJvl5ZCNOhS9TUJCVZMyaiQq3xlpXgguuxp
	 Icf52IOPGvDLGattHCvrHS7eObKU2kl72UiXz09xklnTRchvHqi9jXbQ/IkM56sC08Sll6fhINSm
	 PWm9wZ6izf9l5FNDkJxeKI0n+JUjG6epKT+Kqb2P208GJ8X2OIyqeguDIWeCvtsYr/PVrtmmREbt
	 utgu5YQ/02KZxi5BqwdWscN6E1SoVDa7quV6svFVd0qUE7F3oPxSMFLc49F19vBJoVKH90yLU7I/
	 o68+dFKH7puqfuawhWoRIPz3uMPyzVwOuAobDhB1jfo2P7la20OwCn5LbHvKp9RIY7ddZfuIpWHp
	 EmFdf+CsXvJ80Ls0ojmmkgO0QAkphf9FQjylQJbQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jiawen Liu <1298662399@qq.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jiawen <1298662399@qq.com>
Subject: [PATCH] i2c: altera: disable clock after removing adapter
Date: Tue, 18 Aug 2026 16:41:10 +0400
X-OQ-MSGID: <20260818124110.246659-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jiawen <1298662399@qq.com>

In altr_i2c_remove(), the controller clock is disabled before
i2c_del_adapter() is called. This leaves the adapter teardown running
without the hardware clock, which can cause issues during adapter
removal.

Move the clk_disable_unprepare() call after i2c_del_adapter() to ensure
the adapter is removed while the clock is still available.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -469,8 +469,8 @@
 {
 	struct altr_i2c_dev *idev = platform_get_drvdata(pdev);
 
+	i2c_del_adapter(&idev->adapter);
 	clk_disable_unprepare(idev->i2c_clk);
-	i2c_del_adapter(&idev->adapter);
 }
 
 /* Match table for of_platform binding */


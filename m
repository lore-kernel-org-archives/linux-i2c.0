Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C116524A07C;
	Thu, 18 Jun 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801113; cv=none; b=mzBMVTLLJpJQE5AE3wQ2zQSTXm3/yOx4x1zUeolbiGWAc1yky1o7QY9YH1jeQrOVpZ5GV8N8BFRglgBdd5I2TQHcAKJ8OmsTWexFQYxkNp5oHDx9WusDglOCwxxz7QMYYuWA5ttfICyKdZMTypkk5zviMgaIoInINkEbc1gW3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801113; c=relaxed/simple;
	bh=ar43ZtM7xbnQppJqmCQgUcUZ1ijaKS9xzjeEZ+xkWI8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=o3QqBojZltYZl3BBDEvtFEGpUoBatITM9gXlrWEy/RLplm9OUFsH4mUp32ELqlInc72N80XUjOWsQ/vw2ORErsT5v57jAD8pkmRl+YCJZZCaNAvtFwbJK1gowI56DVVXFFfosPoiB4R2oz5U29ecz48jOsJNJi5mXOAb5eKvDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MuphUXDE; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MuphUXDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781801099; bh=w5II9rAyz3TDKi0A5KHbzDGhN/zdZaMFoxjdbLMDG7U=;
	h=From:To:Cc:Subject:Date;
	b=MuphUXDE14jtIN/AU+6a3LHPt65tjRMnTjLF7SLdf3NkJ4S21p6JTkX7OLgcCA6P0
	 Ojn/UqCj/VEjlXPSCMArrJYnHzGf4d3GnUflu7Wm15u28tbUF+Y0wD3louiYt1CohK
	 k2yi979hKs9rU2YuBi6PxYwruE51+lOzvE13Su5Y=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id B3038E04; Fri, 19 Jun 2026 00:44:48 +0800
X-QQ-mid: xmsmtpt1781801088t5dvu2plw
Message-ID: <tencent_596B5D06A705C0B4DFBCCAC27AACA262C807@qq.com>
X-QQ-XMAILINFO: N6TydytkUq8foZbybPP568phZ7wYLsl3t+3hbXSoullAhwjqqnhShN/fbFvz1D
	 M+zoXEqxd5MxQoPFb8supZbzHHTK553yaq4PBn+WIFDNu08FT2E5akbvHKcC4ikEEQKT6xJisDd7
	 NQaakRhofT/KLAnLAfX3FGA3DWqKyY5KECgcQPMdppfQXVsMF+NX6DfkO4E0BSzkmxA/whkk4nAe
	 3uOBAMWfY5lZP0fAjAFxPu97ZHsVzoy5sQ+kHiQPf4fifOTz6GfD7SAr4RDV8Z3ZbPV9HQfIjv7h
	 eUsmZLFkRdeNcKWzFOV01gmMjlxtHbn8LO6+rcoPXPXkNXxpyC/zRfa5bpvAhtjCG8dtK+hjOjO3
	 4Ysat+U6dQWnDE8Amj75Ds3sy2QtT4SLYDn+wpxMe2BuHVJnCFIip1ZTWGiLDwxd36sz+KNO+Wau
	 LS5Z6L77h39okRF0jwN0aymQBEH5JqfOhqBo3V01GtvG2mXLi/LrMSBF1qZ3+ViryzF4y+83FAbY
	 dAaeLw0z/zPLZsVAy8ybEC50x6SutxJyFFJhJQeENNFHgQTB27AgsJTdTLWIaWo5Lw/lcPxv+4Ex
	 FmE73cLXTDEipKJ4Ez6IXLe30fZRsV18w+b2Il9Ncns4RmtjS9L9lSrK/nSQLPJZnA8nzh7ZhWWu
	 28GGfRQGYnmPQZmfIhJzI5QSyc+B1u+iy9kkR/kQf8muSbqi4d34VAEHjxvt6YecWmxV/oJXvXmh
	 vuNt71o4FTs+qsrKRXaN+9UG5vEzFT66A3bmzroMSvhTcN77Bq4oDDzRHVIPh/4Pe9l+2RA6s/DT
	 IDbZAcF5tFjHPkf1iVbz/1Ox6MW9ym8lwqeaOYg57i2kR0oEqHBO6QgXc1UP9AiRMaBMuhYCIQdu
	 vaaxKtYWVwAFe+gzGD1AkgSrr31AdOwvbvePbVYVXJ9XQ6dE0T7ltFRSN935Mo2SID7LmeYxtL81
	 mkkRk5Cegeyk89KJWGUP4pHUOE9L+7A7o1lF1S4ybanNl9gKo+622U72mTi0OpqdIYwJrPLf2neV
	 RyZAQ2oF6IUcnebMLk9kYyVhekevfubaxApMpA7M2ryi4D6nfZcVsvQlHyZIXr+M/7EQ5GVEybfg
	 A2iUvtMrHglunn7iTpCxn+ueyUKr4gpOLzrpj8FU4dp3bLe3qlzZ1IZlKjbZXfy2kR4ts5
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jiawen Liu <1298662399@qq.com>
To: andi.shyti@kernel.org
Cc: till@harbaum.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 1/2] i2c: robotfuzz-osif: check adapter registration failure
Date: Thu, 18 Jun 2026 20:44:40 +0400
X-OQ-MSGID: <20260618164441.3883683-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_add_adapter() can fail, but osif_probe() ignored the return
value and still reported a successful probe. A later disconnect
would then call i2c_del_adapter() for an adapter that was not
registered.

Propagate the adapter registration error and clear the USB interface
data on probe failure.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 412fa8e37f69..ad2693c1974f 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -163,10 +163,12 @@ static int osif_probe(struct usb_interface *interface,
 			    NULL, 0);
 	if (ret) {
 		dev_err(&interface->dev, "failure sending bit rate");
-		return ret;
+		goto err_clear_intfdata;
 	}
 
-	i2c_add_adapter(&(priv->adapter));
+	ret = i2c_add_adapter(&priv->adapter);
+	if (ret)
+		goto err_clear_intfdata;
 
 	version = le16_to_cpu(priv->usb_dev->descriptor.bcdDevice);
 	dev_info(&interface->dev,
@@ -175,6 +177,10 @@ static int osif_probe(struct usb_interface *interface,
 		 priv->usb_dev->bus->busnum, priv->usb_dev->devnum);
 
 	return 0;
+
+err_clear_intfdata:
+	usb_set_intfdata(interface, NULL);
+	return ret;
 }
 
 static void osif_disconnect(struct usb_interface *interface)
-- 
2.34.1


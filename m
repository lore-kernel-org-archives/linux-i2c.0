Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A101D47AC
	for <linux-i2c@vger.kernel.org>; Sat,  5 Sep 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788614723; cv=none; b=TWOpCcE+9CEbpoIEfGhhdo2exiE8SNPKiD3FJs5Z8yL755k18s5ZzXnFkX+3eaBRvgH9Y5551IW6ikkyIjr5U8cAat+yhQ+3KqHmvkoUKP5BP96Do5Y6NXXH7AKkNuEKIlOCMvx5lJFqIJTMSWUIfiLaAzp3zrSqG4MLP+4eTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788614723; c=relaxed/simple;
	bh=QWMEwIOcooRWk9BjRJruRUeNG+YYS3+Mj6K7qm+NBO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GzfmoAF7xb0lXWRMNJs+Md4qAr9APXmbsVVL0iUrOmPl5Hnn5bKG0+RfeLx8AUCUUGWSI4DLiMC/qRrkNQI+h1rCz7HLwFn1hORnr4dl88ENrNtGouaBYWMauRfDWYLfjWwXs35/xlpCycRVIJGDavriyXE0212o8PBqlH2/UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nalBfOAz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nalBfOAz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso2302909a91.3
        for <linux-i2c@vger.kernel.org>; Sat, 05 Sep 2026 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788614721; x=1789219521; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j7J8yt/imrohgMlytkvN5MFJVOTIoeTWumRUjiqHbP0=;
        b=nalBfOAzcxXSukBq4VWtPHxcRx+8as5w0R2J/TmaRu8enVw1kYk4L/YwSpnwtuJCvW
         ORmFvlUf6gA4ZrDGrNeILHXKhV07jLJVNtNj+s8xnvbaPd1fxYeQli/5Y1aUv1Afqg1Q
         XjLh+0sRECj+2C30qjqejM8nZtMRy04woKwaeHoz2lw+4NCad57ea9XGLJHxcpNxRk/n
         Fh6I+Al1MQTzdxWNS7PdP3j4O42BHHnqERxKxAcb9ApKJpoW0ihveUUcMgcQ6X3oQokO
         OBWi+D6hrH379l2yZ6nMwuIDNaOO4lg1Yxf1WdRuVUZCL/jqBh/28XivB/Yk8ptwtdq8
         /KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788614721; x=1789219521;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j7J8yt/imrohgMlytkvN5MFJVOTIoeTWumRUjiqHbP0=;
        b=qpKBSwb99AiTz/niJ8gmlUf4HEaT9QwnlVPp/r2Ubz0Z82NR5wHJ+8lAnz2k+TISgw
         M9yuMYPJFIzDQZZNNBq5TWgWVxu/BsT9/85mofzeimRX/kpnO/1ls/KU1PWlgzS5vMo2
         dqJJi9fYPBgmujzfxTjV+Gt+lwud/Y4IJmJxmmy7hlmXE/MKlAmeA/TOCO7g9JKglZnb
         +gB+HQuX7/SDV0u7j9zDoT2PLiVR2vOHqA4SO7xPYpkd/bhSTAi6T6lFu/BlKitas5Mn
         JR82FAR3SK06JNwfpKvMK8KcWOvxGYHEtHiARrw3kgwlvjvNr9XzCs4j/MOvR+9ds2fy
         YHXg==
X-Gm-Message-State: AFuF++kJEd+PqsdUYqmGGwPQtPCA7s6cQFXRJ4KBf0DcYqfbgWoKNzRR
	tAKlI/0Teprd9HOMgIwcA5tplFNkC8qHCUMq7fqEBHLPfZdZSw1yopV7
X-Gm-Gg: AYBFou1v0zvvQQq3y+lt1y1u0H70i8fKhrlepcvYJDIGQjVsOMdxPWaD/bJJxggxhKf
	ZmxxdqiO+MVI7mK2TKNBBdWX94WIVXmOEumTYXJ6+Lvj7dFvKOqefTjpmiMFdEwgTAl++4pkjK8
	GLYsdJjNwCfRj6xBGdehFIMcIOvge5+8Y/3+/EG/8WctsHV5ZXUxFlPVGR0Z99NzryHczvcep5a
	gOlfqIrcHFIs2qxxhp6QQx8MdVssmW1g+5/l2hF3ucxy3BffqNQg7CGROXKI+0nhvZfMebaRlrD
	Q/LeJ9ehZsFQsertJyEx0FXXLdgUv2BSPK+OmqKQ8d5IpOzzSUqckxpi9ERXiIXKphvLeMIrfrE
	J/tUW2bZD/a/yqBWOCD5beM1MQCP+0uAZetrC9ssFF94Jlp4Wqc8q46vcKLSCOXKzBqg0pf/ifo
	+Svim/wGoB6XO2uh+jjp6C6d4ghDn6LUs9CKVl+QzQkUndZqgnTcvKO2kbnTLRBSC6YIbFr4dd6
	lvlI8VPvw2wvF/lIsmGw3sa/p3uJyflEqY1Ob/qgOgDXSpFkcy/A8/X1h5yRwqoDgk=
X-Received: by 2002:a17:90b:3ccf:b0:399:ea1:5a82 with SMTP id 98e67ed59e1d1-39b26101277mr16779258a91.3.1788614721206;
        Sat, 05 Sep 2026 06:25:21 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacba5sm17171847a91.12.2026.09.05.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:25:20 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 05 Sep 2026 21:25:15 +0800
Subject: [PATCH] i2c: ljca: drop redundant explicit adapter deletion
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-ljca-v1-1-9109616ff1c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNT3Zys5ERdI2NjAyMTA3PTVAtjJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAIrpKCFoAAAA
X-Change-ID: 20260905-ljca-233024075e83
To: Lixu Zhang <lixu.zhang@intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788614718; l=1642;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=QWMEwIOcooRWk9BjRJruRUeNG+YYS3+Mj6K7qm+NBO4=;
 b=ow4Lq3WIn0W0SECO4+FYZlyW3O6Iff6mqZS2VExdtK069vdz3l6PrZk0Jeb8l6Lu3jPpQWYrR
 aRIYqpXbv6eAdUq6TlV6YoMlUHmUQMDsKxhsXMlc7Iot5unwrk66DrS
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

This driver uses devm_i2c_add_adapter(), so manual i2c_del_adapter()
in remove() is unnecessary.

Remove ljca_i2c_remove() along with the now unneeded
auxiliary_setdrvdata().

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/i2c/busses/i2c-ljca.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ljca.c b/drivers/i2c/busses/i2c-ljca.c
index 93274f0c2d72..da3370968c8e 100644
--- a/drivers/i2c/busses/i2c-ljca.c
+++ b/drivers/i2c/busses/i2c-ljca.c
@@ -297,7 +297,6 @@ static int ljca_i2c_probe(struct auxiliary_device *auxdev,
 	device_set_node(&ljca_i2c->adap.dev, dev_fwnode(&auxdev->dev));
 
 	i2c_set_adapdata(&ljca_i2c->adap, ljca_i2c);
-	auxiliary_set_drvdata(auxdev, ljca_i2c);
 
 	ret = ljca_i2c_init(ljca_i2c, ljca_i2c->i2c_info->id);
 	if (ret)
@@ -315,13 +314,6 @@ static int ljca_i2c_probe(struct auxiliary_device *auxdev,
 	return 0;
 }
 
-static void ljca_i2c_remove(struct auxiliary_device *auxdev)
-{
-	struct ljca_i2c_dev *ljca_i2c = auxiliary_get_drvdata(auxdev);
-
-	i2c_del_adapter(&ljca_i2c->adap);
-}
-
 static const struct auxiliary_device_id ljca_i2c_id_table[] = {
 	{ "usb_ljca.ljca-i2c", 0 },
 	{ /* sentinel */ }
@@ -330,7 +322,6 @@ MODULE_DEVICE_TABLE(auxiliary, ljca_i2c_id_table);
 
 static struct auxiliary_driver ljca_i2c_driver = {
 	.probe = ljca_i2c_probe,
-	.remove = ljca_i2c_remove,
 	.id_table = ljca_i2c_id_table,
 };
 module_auxiliary_driver(ljca_i2c_driver);

---
base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
change-id: 20260905-ljca-233024075e83

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>


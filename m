Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4437BE9A
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075337; cv=none; b=GkhizxfLVjNmKECkyCmuvskZdjeg5ahSlD/dyij6y+l2MQn6zrvzMtW31MwQxHMQ28pcnhXMs/trcBwKRD6oMoRqPK1UKNB5K5GSEXPQW4aNY/Ll7QqydKV8fcK5ctZZdi5YQ1DHLsmuLiC+qt0gkRl9OLr5iwzwl959XJbKM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075337; c=relaxed/simple;
	bh=0p3OFlxXnbyrdeMb+HpZ5Ss5LuB8WKTyZKXg5QBQvQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USV2sPe/5kQmNnMZWU7Cs/c4kFsCCkhy2i2ce5h5nuh62AeZ/B0w6GQBzJ69hBJgZd3FNLzwE83UE04KzZJhFfXzCY0aL9APpTAcWubul+/GBo8AtcRmXXkN5cN32oqAa0LqMFe4b2oYHmU50tR3YN2y7BG5glqG3QD5VjybPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg3UWsiF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg3UWsiF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so728780b3a.3
        for <linux-i2c@vger.kernel.org>; Sun, 17 May 2026 20:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075336; x=1779680136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qodqGJs0EFJRhwX3JQwHDuqYTCCvdIC9p8qgXoxwd6c=;
        b=Zg3UWsiFI8Z3hNvGFBfZR/tLLC5jyMddybynFcQsV71WSRS9vPraT3jp73a7SrUOTE
         Fc0BylzC6TEB4Clk31WBJv0b8C0ycHDPRsnCZU9D6GYNXhq1ttOpJndHBIOLp7Z8MorQ
         csPP/nJRRxWa2L5bzXzgxavaL8Jt80n3AVidc5aKfgc6QkovWzVL8cVsltxreTv51s5j
         BAb1dnGGENayj14xMa06JA7YIcYJ9p/lOZ+XVr/Aev2oJPne7zVo1Ocp1gvoCLzJLxP+
         HdpFUUwR6ynFaZkJImmaMFVb6gEFeUq5bkKaOBz7eBcZPQ4eSOQCxHUmKTFpAdBFv9Wy
         ZInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075336; x=1779680136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qodqGJs0EFJRhwX3JQwHDuqYTCCvdIC9p8qgXoxwd6c=;
        b=F/PMrizArEpazrFIxINkxZ6yhbaOBmQ/elweEpX4QYDC9GfjJaV32Clh/l/gH8rr8N
         U3dmMrojfBVm294OmDn2S/lqEC3YjCsRlPLJ7XnihaDYKl0LkD1iLrEU23fg8xYrOVOt
         28zeZpJcfw5kWNdaINUuhvASSdttH2DWUeAS3V0s1uQIQqlyyDusH/yRI74Kmy1aCEUY
         MYhXS5BMHMcrb9mkf4X3qcjP+0JZZTwNnJuNvi9JfzhwB0Zawu8YVGzM9ggXX9S3/ZIU
         +u49Csop5J7N7L03UAmOzDPHGEjRjtPgXBTHKgzjj2jImR080v2d/0kHJ8ZUC8g7wno/
         9wvw==
X-Gm-Message-State: AOJu0YwM6+IM8RjnedmQbjEL9RDClTgSz1euj2pNUrDGNP7i4wp7RJOy
	91xF5csPzfhP7Zx44ICNYvfHPNqpXjz6Qvqo4uipKi0pAXUvcwlpUL0T7U/q8w==
X-Gm-Gg: Acq92OFhjWXuRwIj7uCRE1gOaBjNflfhFCn6ue7o19rESH7/aQGoo4f3CL9W5XsG64I
	ywQkmEX/Buo+lSichqB3aRdHsbYtpIVGPu/3GITiln7/QE6RJyXEQ4hsTe1hFl+i5ELlwzSpwJW
	gxKXofmDdRKKWCv1g/TQ/YsgjRBdNreSk8R9d/oCsveDCiwBXAE/JOQDFA+k0HOQGljCysMCFd2
	RSoFtjmxuqxjlXwJ5AWMWxNeVTPsqyYXj6hvZ9BxjmWQr88MyOZhABePIpPkVF+IKGd2Pa425Jn
	ZA7R3JY0oZ182Hm+48BCC7yqFmKDs1khhFsKwSZ9+ppKQ7xQ+TpT+s6y9+6awWHfKQklHN33bcM
	K3XVjrv4iyCwxrDM31QT+fOvytE8KxpE75phsi7iDmYHVomKp5uD7xMl0/802Ezh/sGYrT4ntjI
	LUwGYDfY9Wy79JXKYzZMwExa0wTXpkWvtijQfA2UscmQsdWOTpnH30KakVt7VntkSpuol52HqQU
	ekrKLkFjFs1w2VRpfkJMjMsvs4V6/dcd3q6iTEC9JXLkA==
X-Received: by 2002:a05:6a00:4397:b0:837:8ae9:6c30 with SMTP id d2e1a72fcca58-83f33d8c21cmr13137066b3a.29.1779075335681;
        Sun, 17 May 2026 20:35:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm15252961b3a.24.2026.05.17.20.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 20:35:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] i2c: ibm_iic: Enable compile testing
Date: Sun, 17 May 2026 20:35:18 -0700
Message-ID: <20260518033518.570618-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the IBM PPC 4xx I2C controller driver to be built when
compile testing on PowerPC.

Keep the real hardware dependency on PPC 4xx platforms, while
extending build coverage through COMPILE_TEST.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5648d4957872..c2d378e9a1b4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -730,7 +730,7 @@ config I2C_HISI
 
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
-	depends on 4xx
+	depends on 4xx || (PPC && COMPILE_TEST)
 	help
 	  Say Y here if you want to use IIC peripheral found on
 	  embedded IBM PPC 4xx based systems.
-- 
2.54.0


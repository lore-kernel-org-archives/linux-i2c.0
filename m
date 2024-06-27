Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20A1A2FC5
	for <linux-i2c@vger.kernel.org>; Thu, 27 Jun 2024 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531488; cv=none; b=ou91Psvl9R9VoIcT5Kh4zVbam/xv7zixC3cO5cUkijskQSmyuZjhSu9CMP1ceMQspQUXJ7PZrQ8m7jKYAmURihe2G6x7S8lqVImORobVUx4raIVclsfYwWXAWipn9uTI7+nj1AglnILHcaYeyhah9hYhhHRATfJi096EPo1gHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531488; c=relaxed/simple;
	bh=nAFwo7D0gW9O/sMvgBY7XxEz39ucoeofOWIjMi7HBm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXZX+IcAUtikt4tgxghclW6yOidognNMz3dQApqz6uhz+3N3R6qOFwxLvc5+0WRqKn8uzyztILsTuc1MsKuOC9m6Xey1zznJSK7Kwxu5g2MUi6P6EcYBrIVUzsYkgA9sSdz73JdOlaHSZOWe4aXEUQTA5o4lFKdz8augReASYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MC9VUAvF; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MC9VUAvF"
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 11DC38855B;
	Fri, 28 Jun 2024 01:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719531485;
	bh=ZjPoWZtHz9km6NRPw56HluRMf/MgeWSiH2/yMZBn9lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MC9VUAvFLEqg20LtaYcjug/1r45V2MLOTGJJh2ipe6/xWriktVJCWPACkLFGoFKwc
	 rl/ICzFyDyR5c7/Jf5xlGh4OsIy5BUetK/JTFHJSr2O6hY7dGQCBrXA/ENCToZ0Nsg
	 SGeVl1i+lW3ldmsmkklobzIAqXnFCBnvbz0tBSdJ04oVFlsunytkVyrh/SjJ85xDWx
	 W7RePiJRSwwGhqrReqqNWtDOyUIUGXF11sMxcte6TJU8u6MQY/q/oDXborEyvh91Dq
	 wPr4C8RGZcF54L9/JQT4hRhzr4/hZmPdZiK7qEwAx90b0rVl44R4eradZHz5djPHUL
	 IqOSblJPlm5Lw==
From: Marek Vasut <marex@denx.de>
To: linux-i2c@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 3/4] nvmem: Use sysfs_emit() for type attribute
Date: Fri, 28 Jun 2024 01:37:29 +0200
Message-ID: <20240627233747.82341-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627233747.82341-1-marex@denx.de>
References: <20240627233747.82341-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Use sysfs_emit() instead of sprintf() to follow best practice per
Documentation/filesystems/sysfs.rst
"
show() should only use sysfs_emit()...
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-i2c@vger.kernel.org
---
V2: - New patch
V3: - No change
V4: - No change
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a31ea4275d5ae..5b3606114628b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -179,7 +179,7 @@ static ssize_t type_show(struct device *dev,
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
-	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
+	return sysfs_emit(buf, "%s\n", nvmem_type_str[nvmem->type]);
 }
 
 static DEVICE_ATTR_RO(type);
-- 
2.43.0


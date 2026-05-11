Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E4346E5D
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529991; cv=none; b=pK4PvEPYugwI3+9oIfOpYHNqNevQG4D+LvsMhVQdO4Vt5iEP2Ldpawsp+Rczx/JpUtaRSpkV4j3sAsjzpJOKTL2uoMXvlWv0YdAZ14a7sIL9LwYdn5yQzvetly6nCm5JfAa5aPsD4z2VR5F2DowP/hXprjLMNkuZREQcbzJj5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529991; c=relaxed/simple;
	bh=9cnCXAufsosxjIZlhO5qAW+KUJEicaWmss7ww0qWQ2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rg+f0UYOrFEyj6fhErmpzTPPVCnsle6cJjpnFy2GSQxr8nNBTP5p4jj2wIPcVfE9GNad268mQ0A8IOaaOAsWjHiPtrfnemSIP1y0D7u5+XIB/T0hXl+fM9xjQU5rj9OYBWHixLvq2LrifgyR7BowLjrERAptUh+pND5Xp58FJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=MgdGWHD5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="MgdGWHD5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so7161219eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778529989; x=1779134789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhNfRO8ZbDuzpCSUfRVvSXinww41Sv3w98mHeEXQDv4=;
        b=MgdGWHD5LGWKMs7aN8dbgJQ5Fp+zW3NnDvhUtCa7KTGRdI4RhjM/jhJiTw9K1/sUan
         IFSpkfCoSAMUraEF6he+Q4Ibg4wgAjLyynj1lAYcEZ5FfvQ4rlF0PhVnKc5p01TO3jFJ
         NkQYfET9T9Q0f9cD16HxfMXwZNk2PVNn8SXPmmrTuJBm/44RZnq8uBF3BVMbzTxHqo4C
         DPNcAiOyTZIe3DrDBgB6xD6z7yjmbtQegdzHq4tPAs6fj9lK11o+j5mOfCG/FaTjIj8y
         k8G/nxXf3kZfDN/Wa78zaEXg8ieECuNjTfsWO7dW92bn4CUS9aV0uhHv9geI0DKcFhts
         392w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529989; x=1779134789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HhNfRO8ZbDuzpCSUfRVvSXinww41Sv3w98mHeEXQDv4=;
        b=fnpiZRauSjDWlpbk1mJp2BWRl0jtm+8xuJJK554gDtsvIK+joKKwRs88s9UN8pmQYo
         Hr8nAeb87phgQGAPHmbxo+IYawLJoLYLjGqGy0iamkS6ebHlqQtbQu5BBTChN/mE/prj
         pBCphzv68JfqYtVfyrRZnec3FamwRiaXuO71kKYc9o1yGrAZl8SyAmaZbTp50b+PRZ1z
         nKHWpVHuFUKulepViUvKXXVkUY3MIV0WATeUWzvI8O9ftq95lXBRahe82tyTrI7jR3dr
         MwAgREJ+bxNG2De0nG2vGSOer5uAUK0S+PSNvXViNxOMnnBK2sfOntpCPGBqr1egmPAC
         kcHQ==
X-Gm-Message-State: AOJu0Yy4gJIS01QdHtvwO7s0brRDnJ/pbfT3+11qVKyubTjsGieLSCqb
	79CCnRXXUlm42uwHVdF31ukREet/eUAUa2ybS7ILKpWr7NdVpH70NIv9qmA/RfHlLu4=
X-Gm-Gg: Acq92OErxQElJu2SUbM9/yN6hUNTvg1fJ5Thxzx8jQ4u8sGqR54BxipotwD+lO0YD6n
	/9wgRZ/7y9u3GXpEcOcRFj5RG/6Alu9TrxQJ5ovQsKKriVXTRj+Mw73QH273qe7vjsndjT9Roxs
	QojzT45ut2b4GQp+h0WezSDPzlT8mCVIYgZ2NmwhgUaK+aWVlBcsAEdMdR3Y4eRmqjiPR9k3Zxs
	zBvcHTU+skSELTG/usG6ACW57aJaYkEo/yMj4zuqCu+gqmcKs6dOgM6BHDnm4yOVH8nvMUxsdTE
	6Hx0f26sZq8TzN0fqThQg1+i3B/onD3hgP7ZPkH/JNP0m53gHDGKvyin2103xZwxRI2cs6f/mOj
	BLeY7RbLYVbh9Wj91uZZHbBAneCGWfQJpET7XojPswSsfA4hhmv5IcyuI48z57WJB4jg47J4r2j
	R2FHtzXpw+uuN3deTwWjnOTG/z6r5aQplnsf1R6I9dLRbbrFV86L/OsAEuHlfpOM1HknXBC2U9C
	7zSqEz0J/4fdLVF8os1tTAZHQ==
X-Received: by 2002:a05:693c:3b0b:b0:2f2:b544:2fd4 with SMTP id 5a478bee46e88-2fb4c3e4291mr5469098eec.34.1778529989053;
        Mon, 11 May 2026 13:06:29 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm15066942eec.24.2026.05.11.13.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:06:28 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 11 May 2026 20:06:26 +0000
Subject: [PATCH v5 1/4] i2c: designware: Introduce shutdown exported
 function
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-dw-i2c-v5-1-6c382e1b5de6@wkennington.com>
References: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
In-Reply-To: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Introduce an exported shutdown function to safely shutdown the
DesignWare I2C controller.

This shutdown hook gracefully sets the target disable bit before disabling
the controller. This guarantees that any incoming requests from the
controller are immediately NACKed during shutdown, preventing the bus from
hanging.

Signed-off-by: William A. Kennington III <william@wkennington.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 24 ++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..ef618d3e1ace 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -1028,5 +1028,29 @@ EXPORT_GPL_DEV_PM_OPS(i2c_dw_dev_pm_ops) = {
 	RUNTIME_PM_OPS(i2c_dw_runtime_suspend, i2c_dw_runtime_resume, NULL)
 };
 
+void i2c_dw_shutdown(struct dw_i2c_dev *dev)
+{
+	unsigned int con;
+
+	/*
+	 * We only need to handle shutdown for target mode to ensure
+	 * we NACK any incoming controller requests. Controller mode cleanup
+	 * is handled after each transfer in i2c_dw_xfer().
+	 */
+	if (dev->mode != DW_IC_SLAVE)
+		return;
+
+	/*
+	 * To quickly NACK the controller during shutdown, we set the target
+	 * disable bit while the controller is still enabled.
+	 */
+	regmap_read(dev->map, DW_IC_CON, &con);
+	con |= DW_IC_CON_SLAVE_DISABLE;
+	regmap_write(dev->map, DW_IC_CON, con);
+
+	i2c_dw_disable(dev);
+}
+EXPORT_SYMBOL_GPL(i2c_dw_shutdown);
+
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9d8d104cc391..c71aa2dd368d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -417,6 +417,7 @@ static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 
 int i2c_dw_probe(struct dw_i2c_dev *dev);
 int i2c_dw_init(struct dw_i2c_dev *dev);
+void i2c_dw_shutdown(struct dw_i2c_dev *dev);
 void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)

-- 
2.54.0.563.g4f69b47b94-goog


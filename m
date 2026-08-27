Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025336B912;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821726; cv=none; b=WHTciljMBkXTn1t/CqWN/Q20YF/nnqKD1Rg9L8MGEzJSDP7cwJn/QTFdwN+Wd5KPwFGYx9+DmPpevaRnlSNGwDzfrCjFK4VPJAjfdoTzqKYIGYuccjbUSb8MoZI4bc471GOki5v4q5pR8Q/MFpau0yMXxGjG9b698F9kp6ohxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821726; c=relaxed/simple;
	bh=/GksnhYNesP45HiePsqhiIN1kWJNEvj5aSBFPP2lGBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYDJyruBGF8EYzDO0BU7YWn+4uAV3j2CIUuaFNCecOUrTMFyPofx7e9mtQphAnGb/ulHqoJfIqQdEWrZWe8u9iYKvhiVdWQBvnpL1Ui8lSSVabooLV7Ye6h3DBIjNM/wVCSgQ8rQfTFjLycGlkywLblmTRQj9AYETYp/Pyjk6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeYlCQWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeYlCQWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7957A1F00A3F;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787821722;
	bh=fNDsmY25d2+79qMBcXoyfYGND5DKyfIxnRNdUo9Ozfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeYlCQWjIrCdRDmJ4bC6t2t/RLpw6rPNDSZSWqFMC85zg+rTamRwUxSwqYBXQoJfg
	 3aAR16zllatXxKBGfMJl1WSV/wWwHTl7tZmbB+zMAcBqbyk4yJgcwauyQIi7XgeLv1
	 RNnz0AGmU43Ga3n5e/q+HRY4NFy2yXPSAekDsjz7YRIHKz+xTazAMqufw2Qh0wG6Bz
	 RCrurFLM7bXCaR0GCsMlvHQEPXKhlqSzkZDKMrYgwb9wG5tR0H+UvI19C14Dy6tjhU
	 tk40mNkm0WK3Wj1smVqwWDo+nMCRX9IW/QvKGFmO8k0N5aJ++NZNSSxHG0/su9T/k4
	 KmerCa1YaqMZg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzW6C-00000002g8H-0tDw;
	Thu, 27 Aug 2026 11:08:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] i2c: dev: drop unnecessary sysfs device lookup
Date: Thu, 27 Aug 2026 11:08:03 +0200
Message-ID: <20260827090804.638565-3-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827090804.638565-1-johan@kernel.org>
References: <20260827090804.638565-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs lifetime rules guarantees that the i2c-dev class device is
still valid while its attribute callbacks are executing so drop the
unnecessary reverse lookup.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-dev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 05616249f61b..319bc46cc207 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -47,6 +47,7 @@ struct i2c_dev {
 	struct device dev;
 	struct cdev cdev;
 };
+#define to_i2c_dev(d) container_of((d), struct i2c_dev, dev)
 
 struct i2c_dev_data {
 	struct i2c_dev *i2c_dev;
@@ -111,10 +112,8 @@ static void put_i2c_dev(struct i2c_dev *i2c_dev, bool del_cdev)
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
-	struct i2c_dev *i2c_dev = i2c_dev_get_by_minor(MINOR(dev->devt));
+	struct i2c_dev *i2c_dev = to_i2c_dev(dev);
 
-	if (!i2c_dev)
-		return -ENODEV;
 	return sysfs_emit(buf, "%s\n", i2c_dev->adap->name);
 }
 static DEVICE_ATTR_RO(name);
@@ -704,9 +703,8 @@ static const struct class i2c_dev_class = {
 
 static void i2cdev_dev_release(struct device *dev)
 {
-	struct i2c_dev *i2c_dev;
+	struct i2c_dev *i2c_dev = to_i2c_dev(dev);
 
-	i2c_dev = container_of(dev, struct i2c_dev, dev);
 	kfree(i2c_dev);
 }
 
-- 
2.54.0


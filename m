Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC142BEAA;
	Thu, 27 Aug 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826181; cv=none; b=NmjQnuO9EQEpE40l2d8kj/DRXEGqktNCvpC85F6/hSPl2aeR8JTNc0PV9I+Tkl3V7VNRAbfH/uky/HSOemdtsmAhCFqRWFZT9t2BJ7Q1fUjXRhsJifZNHThciv+agqx4BtY5DUDYTmQchp05M3XFn18XtvIwWZnJXf3PJBS+Ubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826181; c=relaxed/simple;
	bh=cr8GUHc33pCoSQQViyf2cxw4PqqMGDnkCl9gUsZ8L+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFbkWZiQTA7inedARbCINr2GkjRpP4IIL4psjz6QFWHbr1n2G6Ed4xMs4+i2vwFvW8xmFNviK2POBw7RQZPYCF/nRIOtELv/PPigKJSK81H79D8fddmLm6M55ns8k5Wz0mZpIBRfaQCUftM9cypxo8IvyIRFa3LysvLTO1ur6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVCpAKQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVCpAKQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15041F000E9;
	Thu, 27 Aug 2026 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787826178;
	bh=znfXMecyUVlNTcrDh+JBz4l6+Y6OUdvjsSRBHXtwkVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVCpAKQiYJLNj3FL5QmAeokJmvKt8o4kEKVzah6/HXdxiSElyd3CDMh1YXMeHPzI9
	 UgKZlHurAAFIJmu7yi7BbFPr6TJoBoKut1upOdyDyTV4DXm4I6/jnHBL1xMCMudTSO
	 hqSHltY7p3Vth5mzVNRcgq8+gjeG4LgnTUCH5FzaRUIIoFfHJW6mncSabVd4m/voDM
	 YMLRpnFaEg81w5AdLYHMgJj4j8E/jOSD/frgnnhxzLuW5LKcSwTEPvP34WB93eaOZ2
	 Mp3J6qjxSOvGbaBfXH4+lUW6IBxyUrB+8f9Lw+geHSKgA7vhtoknHMvmfh/RHNmPBt
	 Xfs3w2S/CPU3A==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzXG4-00000002pC3-18fh;
	Thu, 27 Aug 2026 12:22:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/3] i2c: dev: drop unnecessary sysfs device lookup
Date: Thu, 27 Aug 2026 12:20:42 +0200
Message-ID: <20260827102043.673273-3-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827102043.673273-1-johan@kernel.org>
References: <20260827102043.673273-1-johan@kernel.org>
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
index 0940070c0317..49c05f2eb223 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -47,6 +47,7 @@ struct i2c_dev {
 	struct device dev;
 	struct cdev cdev;
 };
+#define to_i2c_dev(d) container_of((d), struct i2c_dev, dev)
 
 struct i2c_dev_data {
 	struct i2c_dev *i2c_dev;
@@ -110,10 +111,8 @@ static void put_i2c_dev(struct i2c_dev *i2c_dev, bool del_cdev)
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
@@ -710,9 +709,8 @@ static const struct class i2c_dev_class = {
 
 static void i2cdev_dev_release(struct device *dev)
 {
-	struct i2c_dev *i2c_dev;
+	struct i2c_dev *i2c_dev = to_i2c_dev(dev);
 
-	i2c_dev = container_of(dev, struct i2c_dev, dev);
 	kfree(i2c_dev);
 }
 
-- 
2.54.0


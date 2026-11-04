Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800443;
	b=5S/cTEMin7izWrhRVEsD8j+O/Ttlxfu+lPSoO3Xi33rA6cgwOSEpv3nn11Jmf/zF4lLq
	 RxystA8cxAq1hW1dnRXidjGEgJqLv7JEzS5pLCix3ewpP1SDztCWmG1EHs4W4+j+T9rL6
	 lE5yYS+NTGpYy+2jP/8JV/bJWQimzPEDv7sRstFCGSCYPjyjfBFxu04friw9vCRSLTpnH
	 vSPdUJotvLNNWd09jmqcZPvuiaD1qflYfgdiwordA0Q66gClL19LOC8tDAO9gxDplmp67
	 AxiBHE3cLSx+GI1cXWUG6ueTq2CrC88rxxPmq31pOHYkEBj8sa0F3iwbTjW62CAh9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800443;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SERbX9iophMB+xD5OItMT4ueu9GiLVDzhjq3mOsJXYg=;
	b=Ksrk/qnULFgvJCNgK/zvQwJQzDA9qlGu/H9I2OChiHZGV4OwdRZ8k3nZukaRjf1yXJs3
	 YJ/6MwCaEoQQIk9q9Zi0CkwQAjArLjhpSdw4Hq1W84VAewoXTGVvJOC27Dybxc5Z2AbCV
	 u0haHQdTMxmTRL2gTMV7jHUdLrxRbuU4IgRWWMP7NAN25yRlnsL1BZf7RMeJs30TCufnL
	 4ap7VT+Z+DziU7aN1PaZqhHDaB+SRzI8NXVN2WLaK7e76oPqsL1aQiYflFd5bp7VOLGwm
	 UOQLvdtkur2pvFwErreJpTLGqYLzlQuac/a4mnAAIbH8Gbzd898CCpt8W3sAh4DY2KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mfk0kih5;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1061606A326;
	Wed,  4 Nov 2026 13:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1061606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mfk0kih5
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3792E4E413FD;
	Wed,  4 Nov 2026 13:54:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0449E60770;
	Wed,  4 Nov 2026 13:54:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A6EC103291AD;
	Wed,  4 Nov 2026 14:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793800436; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SERbX9iophMB+xD5OItMT4ueu9GiLVDzhjq3mOsJXYg=;
	b=mfk0kih5TEt7tTvq0pdH6dxcyphiiAZwV/r7gc8nBU7qD3stIaY9iKkES58xgW5G/2t5pG
	fcRRQjkI2kmiipPBG4XDJXY7PZ+idYa6thiwh6i5YrLJjALnShHMpmWzCz2bCUJnqw2NUB
	3+2A3hMZ06Z6pHrINa9THTz4dfe6nBiZG2dRmRnwzXTR/dowWnIjBe3DkncnBaiHUMKKsq
	XGNqgfF1zfn72Tnk9ONggECvXuNINc1sGuK6M8kzT9QDV0uJPkYkG/BlPaMuAX7u4UTlfw
	kAXUu17E/X51EC/nCCmtSyfQacdG+WNADTuGVJFNDChZPcrPVtHPOXgyKi1GSQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v9 1/3] i2c: core: Introduce i2c_get_adapter_physdev()
Date: Wed,  4 Nov 2026 14:53:04 +0100
Message-ID: <20261104135324.492692-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104135324.492692-1-herve.codina@bootlin.com>
References: <20261104135324.492692-1-herve.codina@bootlin.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The physical device providing an I2C adapter is the device that calls
i2c_add_adapter() or variants and i2c_del_adapter().

Most of the time this physical device is the parent of the adapter
device.

Exceptions exist with i2c muxes. Indeed, in case of i2c muxes, the
parent of the mux adapter device points to the adapter device the mux is
connected to instead of the physical of this mux adapter.

Introduce i2c_get_adapter_physdev() and a new physdev field in the
adapter structure in order to ease the adapter physical device
retrieval.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 16 ++++++++++++++++
 include/linux/i2c.h         |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 165ec14260c8..0c08b0e71609 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1956,6 +1956,22 @@ struct i2c_adapter *i2c_get_adapter_by_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL(i2c_get_adapter_by_fwnode);
 
+/**
+ * i2c_get_adapter_physdev() - Get the physical device of an adapter
+ * @adapter: the adapter to get the physical device from
+ *
+ * Return:
+ * Look up and return the &struct device corresponding to the device supplying
+ * this @adapter.
+ *
+ * The user must call put_device() once done with the physical device returned.
+ */
+struct device *i2c_get_adapter_physdev(struct i2c_adapter *adapter)
+{
+	return get_device(adapter->physdev ?: adapter->dev.parent);
+}
+EXPORT_SYMBOL(i2c_get_adapter_physdev);
+
 static void i2c_parse_timing(struct device *dev, char *prop_name, u32 *cur_val_p,
 			    u32 def_val, bool use_def)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 6a847fc88d25..bcf2e4e30108 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -762,6 +762,7 @@ struct i2c_adapter {
 #endif
 	int retries;
 	struct device dev;		/* the adapter device */
+	struct device *physdev;		/* the physical device */
 	unsigned long locked_flags;	/* owned by the I2C core */
 #define I2C_ALF_IS_SUSPENDED		0
 #define I2C_ALF_SUSPEND_REPORTED	1
@@ -929,6 +930,8 @@ struct i2c_adapter *i2c_get_adapter(int nr);
 void i2c_put_adapter(struct i2c_adapter *adap);
 unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
 
+struct device *i2c_get_adapter_physdev(struct i2c_adapter *adap);
+
 void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults);
 
 #ifdef CONFIG_I2C_DYNAMIC_TIMEOUT
-- 
2.56.0


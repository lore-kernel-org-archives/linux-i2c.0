Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839042;
	b=wyX8DQlslWKbqLaG4U4wuAS0nsL5MLotk9CcLn4l7J065UZb5Z5SAA0hGAZXM/dFyv+n
	 VLQ0SOb5tUU+9gzZZBwQFi1b1wh/HmyU2UgiyWn/NF4nxfFA+ZlvidOY5V4SzOyYLChUq
	 ZjOUcA+tQF9uWIPuvhOjpJm7Un0OuwhWCf503TPGPehzTXlPA6lrjM7iLpbyHiPhEZosW
	 y1zJvCqdPGPsXrQTuzwRZiO8bf6KPk4kkbvCDA8JsTBqTijhkHuvjTywZKE2hPXAMHcK1
	 tpES495snAXSyGA8/vMWkIwxv8YlUJ/ZQxBR41/hnP6UjoFbtNfWRqjGtYGF6/puVgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839042;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=EoaRfVjB+wiF8oKOlK4L7ySxFsN81xtIauFrg21540Q=;
	b=qERkNxwGzHUlJW5CIF0NXIO43OFwMb8WBHan0QOFt0/PzIUHhUUtNugPEgYtT3OKniec
	 lKkv8ltncHCYZQjRHxlqIDzmXmeXr9CgWBiI8PY82OOIhy9hDJkVDcPqCiR5Q56Jr+Ss6
	 CSpOrmZRkJxKZ7dXjj8Gv7D6tncYXJhBaDh2VMeTzuHsoEjyr1t7tzqS91XZHW4AqjM5Y
	 xzFnNHK3FkUT3giB3sQ6NVroGh0t8S74j5K026QfWNRr1wRc0mOqPCrOX54Qsf67qu0aI
	 e3i2gBl53d16Ja2r9KsksGirQR4ppkqQ30kukUkuXnKIMCbe8WKjDBnShrBFoRrgGQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=WkyY1K4n;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F43606A89C
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 14:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F43606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=WkyY1K4n
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026111614235334c758a9f600020746
        for <linux-i2c@vger.kernel.org>;
        Mon, 16 Nov 2026 15:23:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EoaRfVjB+wiF8oKOlK4L7ySxFsN81xtIauFrg21540Q=;
 b=WkyY1K4nA4fnMTreG6yN44Wnr81nn+eCydr4/qctmmDy/L87HS2HlZ9ifD2SfJhs0C53E6
 T08sJC/0QGq47diHmVj75R0zyn0NsoNVs8f2NK0FhFvDPD/D9IVolYGwIt+fft40ASa5la9M
 Kx+mza9L4b/VMdfxW79jBo2Or57bymZqSBYxuxuBCSxr099c7eAndnLu4CBlxQ3yEYifwYsY
 4o8UfkxwX9S3HEz9lysf+xAl3jjoi3Bxzl89NHrgWYx3Mm4FSQfvPrKPqPJroJn7J4/oy01G
 +llpmNIeWUVDUDCnxG9b1ko4iIspAoXrMpNcGhg6cEfLd9K9djJ4DRbw==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: andi.shyti@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: baocheng.su@siemens.com,
	tobias.schaffner@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 3/3] platform/x86/siemens: simatic-ipc: enable support for RW-548A
Date: Mon, 16 Nov 2026 15:23:51 +0100
Message-ID: <20261116142351.1228943-4-benedikt.niedermayr@siemens.com>
In-Reply-To: <20261116142351.1228943-1-benedikt.niedermayr@siemens.com>
References: <20261116142351.1228943-1-benedikt.niedermayr@siemens.com>
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
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer

This patch enables the platform detection of Siemens Simatic
RW-548A IPCs.

The nct6775 driver is used for hwmon support and needs to be loaded
during platform detection.

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 drivers/platform/x86/siemens/simatic-ipc.c         | 3 +++
 include/linux/platform_data/x86/simatic-ipc-base.h | 2 ++
 include/linux/platform_data/x86/simatic-ipc.h      | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 8f99032897dd..2efaf9ac2be5 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -84,6 +84,9 @@ static struct {
 	{SIMATIC_IPC_IPCBX_59A,
 		SIMATIC_IPC_DEVICE_BX_59A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_59A,
 		{ "i2c-nct6126", "nct6775", "adt7475", "emc1403", "w83627hf_wdt"  }},
+	{SIMATIC_IPC_IPCRW_548A,
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE,
+		{ "nct6775" }},
 };
 
 static int register_platform_devices(u32 station_id)
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
index 2d7f7120ba6b..214a13d42ef2 100644
--- a/include/linux/platform_data/x86/simatic-ipc-base.h
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -23,6 +23,8 @@
 #define SIMATIC_IPC_DEVICE_BX_21A 6
 #define SIMATIC_IPC_DEVICE_BX_39A 7
 #define SIMATIC_IPC_DEVICE_BX_59A 8
+#define SIMATIC_IPC_DEVICE_RW_548A 9
+
 
 struct simatic_ipc_platform {
 	u8	devmode;
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index 8d8b3b919674..4cdcf865a7f1 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -38,6 +38,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPCBX_21A = 0x00001101,
 	SIMATIC_IPC_IPCBX_56A = 0x00001201,
 	SIMATIC_IPC_IPCBX_59A = 0x00001202,
+	SIMATIC_IPC_IPCRW_548A = 0x00001402,
 };
 
 static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
-- 
2.43.0


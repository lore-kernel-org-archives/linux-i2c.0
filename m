Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1C4C33F9
	for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602329; cv=none; b=ktn2jaownXhR7AGNtFlcqO+W3j20OLB78C+4RDnp3Xb+Hw9l41HyhqRPAoN4Y36S9DkncbZHAgJQ2laen5nW9jeCK2J2jrHR+j2Ez1PE77HEB+UqguOkifTp7D/tGr38WXsWmnv5J6cUb/eeuCJwdQGmPDlGZKJq18/2jWCUO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602329; c=relaxed/simple;
	bh=cRBiTAX8sUcFRk5xwhqKvWV37dgGuNWlRNcie5a2MCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoEO/QENRfHcd10NAoWJnkKKlhwvVwIGNWk3apcKi3ZBbG+DMHM2pi9e89e2Zm5zn35tixo9/LlDhkt+klPPnvXmbBnEvmYBEhC1AuuhRkdlCS21hHlixM8Dt/Ru05Y7tgkh1tENG3IaH/vuY3wv4PuohSm0zm/HOTuy0ZG9do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b=CHeIT+jQ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=benedikt.niedermayr@siemens.com header.b="CHeIT+jQ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202609281331579093585a9900020731
        for <linux-i2c@vger.kernel.org>;
        Mon, 28 Sep 2026 15:31:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qgiJK1A/bzYz7KUdCuSnEMBXjiHNUiMcAAe7ng8RjSA=;
 b=CHeIT+jQsFPJfq+D/oKWWwjLWE8c2teszUPpK9z06anCvdV5kvYaxhy8PpDxpRbpQ7J8Yk
 foHWhj0UR5MtN8N/O+tVQ6FMCYsynvDHlNHYPWDi+lG6xhhy4szW9fS0s135FfIa4prpfXXE
 sMXxOlEszAHR0s50fIPCdNdyDhOppUbgL4npfYx/u0BodSOOMGDSWBmK24PHdFE75xiTAhjS
 okNOtzYhN/68T2DwVa1Qtuq89rdCDFkcTCUvkAE2VNCJOIAPcLfhWkkZAC8JQn9PjCbqxTJq
 h5TUnya1F1KjcU0o9bwgexwORA6evucQeASRZ6n3j7LbxmaqRvnVQ/BA==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: andi.shyti@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: baocheng.su@siemens.com,
	tobias.schaffner@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86/siemens: simatic-ipc: add fan monitoring support for BX-59A
Date: Mon, 28 Sep 2026 15:31:56 +0200
Message-ID: <20260928133156.817479-3-benedikt.niedermayr@siemens.com>
In-Reply-To: <20260928133156.817479-1-benedikt.niedermayr@siemens.com>
References: <20260928133156.817479-1-benedikt.niedermayr@siemens.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer

Some fans on the BX59-A are connected to the ADT7475 fan controller
which is connected to the NCT6126D Super I/O chip's SMBus interface
(supported by the i2c-nct6126 driver).

Other fans on the BX59-A are connected to the NCT6126Ds hwmon interface
which is controlled by the nct6775 driver.

This patch enables the required drivers.

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 drivers/platform/x86/siemens/simatic-ipc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 7039874d8f11..132a899c8752 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -33,7 +33,7 @@ static const struct dmi_system_id simatic_ipc_whitelist[] = {
 
 static struct simatic_ipc_platform platform_data;
 
-#define SIMATIC_IPC_MAX_EXTRA_MODULES 2
+#define SIMATIC_IPC_MAX_EXTRA_MODULES 5
 
 static struct {
 	u32 station_id;
@@ -53,10 +53,10 @@ static struct {
 		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPC227G,
 		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G,
-		{ "nct6775", "w83627hf_wdt" }},
+		{ "nct6775", "w83627hf_wdt", NULL }},
 	{SIMATIC_IPC_IPC277G,
 		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G,
-		{ "nct6775", "w83627hf_wdt" }},
+		{ "nct6775", "w83627hf_wdt", NULL }},
 	{SIMATIC_IPC_IPC277E,
 		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E,
 		{ "emc1403", NULL }},
@@ -71,19 +71,19 @@ static struct {
 		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPCBX_39A,
 		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_39A,
-		{ "nct6775", "w83627hf_wdt" }},
+		{ "nct6775", "w83627hf_wdt", NULL }},
 	{SIMATIC_IPC_IPCPX_39A,
 		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_39A,
-		{ "nct6775", "w83627hf_wdt" }},
+		{ "nct6775", "w83627hf_wdt", NULL }},
 	{SIMATIC_IPC_IPCBX_21A,
 		SIMATIC_IPC_DEVICE_BX_21A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_21A,
 		{ "emc1403", NULL }},
 	{SIMATIC_IPC_IPCBX_56A,
 		SIMATIC_IPC_DEVICE_BX_59A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_59A,
-		{ "emc1403", "w83627hf_wdt" }},
+		{ "emc1403", "w83627hf_wdt", NULL }},
 	{SIMATIC_IPC_IPCBX_59A,
 		SIMATIC_IPC_DEVICE_BX_59A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_BX_59A,
-		{ "emc1403", "w83627hf_wdt" }},
+		{ "i2c-nct6126", "nct6775", "adt7475", "emc1403", "w83627hf_wdt"  }},
 };
 
 static int register_platform_devices(u32 station_id)
-- 
2.43.0


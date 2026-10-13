Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C443D410C
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878787; cv=none; b=gQqRv+Dcw/WDrqzb32hi2kxgdqZGw6h7oXRZS2wdkwwMKS4tuy2qc6fkNiHi8sbVchOn/ZRfKZj9uWN/FUrlQG5gfW5yx6Lmzatlwxe6H8m/KwnnMq5LTKGL3tZ8jfnvbddz4VAchc/IicSxblyrFKz3gT/27cBPETd7YmSF1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878787; c=relaxed/simple;
	bh=BiS/bMkGceTlf3ws23i7YgIpdVZf2YK3ZmhYCzIMeLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dxX6AZjim/cJBsvubYDS5pLUIghvb5uaUpdtSDIscQGoKObM/X8xE+2R39BBb9LB2YcRzkiRmm6v49Je8Ax0ErrM6Gyf7wT+CZ15GQ43odefxhcEPx7n2XuYIWcb6SlxFC8W/g2MSEzMWC7OJRR4up8KP2NKKIIjo/GaaMWDaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpYzhYr9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpYzhYr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791878783; x=1823414783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BiS/bMkGceTlf3ws23i7YgIpdVZf2YK3ZmhYCzIMeLc=;
  b=fpYzhYr9AbWvI67RqkKqgd8cIbdWMsiAKm5GywpRBicMCq2bY6ZmlknX
   CPUxiybspEdSgwasiigDFcWyC2W3QO3Jh3YHRBiVqKLzrR+FwqGpowKwl
   duLnWLAP+Ad3niS6NjHEGxIRxUnh2+HSVnfOtBNIBOIfXwZYvp2iwc/qY
   LGhYDvLmYBV29jMuG4XzXmP9w+SgwlwkBhj4lBlrfdkL2gEG7vev6VR1f
   bCqbzokajKqr7cQSQLw5WxO73gNyFMK2FiiKuzH5y9GxsZwCswuBSTa57
   gLmmCkvTwEzCnhZYTYDWmfB1m5HY0EHU3BXZekMZ5AoUkkDmk4BUr1BUt
   Q==;
X-CSE-ConnectionGUID: yWQRBDxSSrGJJs49fFbUmg==
X-CSE-MsgGUID: hEcDRJu2SiyGZsD9lzhilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="604243"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="604243"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 01:06:22 -0700
X-CSE-ConnectionGUID: bOffWgcPRwuZei0MnBuhLg==
X-CSE-MsgGUID: TT0hFBeFSH2QRN0bF0u55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1204049"
Received: from senthil-nuc10i7fnh.iind.intel.com ([10.223.163.42])
  by fmviesa005.fm.intel.com with ESMTP; 13 Oct 2026 01:06:20 -0700
From: Saranya Gopal <saranya.gopal@intel.com>
To: linux-i2c@vger.kernel.org,
	andi.shyti@kernel.org
Cc: yo-jung@canonical.com,
	mpearson-lenovo@squebb.ca,
	andriy.shevchenko@linux.intel.com,
	saranya.gopal@intel.com
Subject: [PATCH v3] i2c: i801: Gate SPD instantiation on SPD Write Disable bit
Date: Tue, 13 Oct 2026 13:36:03 +0530
Message-Id: <20261013080603.808196-1-saranya.gopal@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yo-Jung <yo-jung@canonical.com>

When DDR5 memory modules are present, probing the spd5118 hub requires
page-selection write transactions. If the BIOS has set the SPD Write
Disable (SPD_WD) bit in SMBHSTCFG, the transaction fails and wedges the
controller into an unrecoverable "SMBus is busy" state.

Pass the PCH SPD Write Disable status into the SMBus core via
i2c_register_spd_write_disable(). This safely skips spd5118 instantiation
under write-protection while leaving legacy DDR4 (ee1004) functional.

Retain the original #ifdef CONFIG_I2C_I801_MUX preprocessor block around
mux_pdev to prevent compile-time regressions when the multiplexer driver
is disabled.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=213345
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Co-developed-by: Saranya Gopal <saranya.gopal@intel.com>
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
Signed-off-by: Yo-Jung <yo-jung@canonical.com>
---
Changes in v3:
- Introduced helper function i801_register_spd() as suggested by Andy
  Shevchenko. This isolates the dynamic routing logic and cleans up
  the callsite in i801_probe_optional_targets(), avoiding style/preprocessor
  indentation warnings.
- Added Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca> from validation
  on Lenovo platforms.
- Fixed compile failure when CONFIG_I2C_I801_MUX=n in v2 by retaining the
  original #ifdef structure around mux_pdev.
- Link to v2: https://lore.kernel.org/linux-i2c/20250430-for-upstream-i801-spd5118-no-instantiate-v2-2-2f54d91ae2c7@canonical.com/
Changes in v2:
- Switched to i2c_register_spd_write_disable() dynamically.
Changes in v1:
- Initial submission.

 drivers/i2c/busses/i2c-i801.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b29c99ed3883..810f61e39cad 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1170,6 +1170,14 @@ static void dmi_check_onboard_devices(const struct dmi_header *dm, void *adap)
 	}
 }
 
+static void i801_register_spd(struct i801_priv *priv)
+{
+	if (priv->original_hstcfg & SMBHSTCFG_SPD_WD)
+		i2c_register_spd_write_disable(&priv->adapter);
+	else
+		i2c_register_spd_write_enable(&priv->adapter);
+}
+
 /* Register optional targets */
 static void i801_probe_optional_targets(struct i801_priv *priv)
 {
@@ -1193,7 +1201,7 @@ static void i801_probe_optional_targets(struct i801_priv *priv)
 #ifdef CONFIG_I2C_I801_MUX
 	if (!priv->mux_pdev)
 #endif
-		i2c_register_spd_write_enable(&priv->adapter);
+		i801_register_spd(priv);
 }
 #else
 static void __init input_apanel_init(void) {}
-- 
2.34.1


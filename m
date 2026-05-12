Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642AC4C0421
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579924; cv=none; b=e/feXGxEAbGyhIA2sbgEfh28+gJJ6LSgAMyZJj//J8Yw3iaFL3n9HuDng5xlTl4Nwwc2eoJUe++/o4ATRvjYyiw91PtXq34Gic+by5hB/rOARpNiCUtgEJ+3MOp/uNIb0ogd1t7i3/N4WpNRC8/3W/ZYk9BAcZnDhXtyFqq01CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579924; c=relaxed/simple;
	bh=bOFM4QU5xu7KgGZMZwMPxnRovR6UYAHIvUlj+2CSig0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R9l0v32H2R/sUpL3vbuVhy5l7drLhJhrUeIDbtWOI1ai37plAeW7p1rpv5LXT7TBdNjvD0VZP7gzyHflqYGyK76puL89tsZ6FrMeSIYNGnDB5/LvOeEzPlW7bhdd8Nqd51aoPP4B56XgAx3sdjfeiTSO3EGhsbx3qz/n4OFcFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=C/J8LH2k; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="C/J8LH2k"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so8102927eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778579922; x=1779184722; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1+5OZsWURPavYcobtYNQ0u77xCxFvwCg3S8LRIf/FI=;
        b=C/J8LH2kmuxnvfhUHsSXGYK5JI/6u2ch8fGtaJyNzyvpA+DnO0qBkqvgyFlPcm9E6I
         RhsYB3W7k+ubYOG0g1+UoqqziErRMhCoIcq+rRJQn9DFY4gL17eL4Hlh9Daa8xbxL54+
         V59MQw3hRq12KL55KTynLwGhVl4QQcUmOS7OkhyQ+cA9Ogq8IlDy9X8nPHsd5Gv90Cd7
         HXVw6v5IMkEDIldqY4LolZVFrA+JDFTnI1eegkMkStH9Yazp6yKKem48pl6zVmaD0UFa
         hl8Krm4NYxirlVP42mY634IO29TZq3Hdfb7MHFVR7sTKfFyTDqiY9I0WAAH658v44EUl
         /Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579922; x=1779184722;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1+5OZsWURPavYcobtYNQ0u77xCxFvwCg3S8LRIf/FI=;
        b=G+ibJvT0Yi85l5kHdE2WI/m4n0uq6Cilw5Tx/ALPOPViXrOQovtDuCfOW9DEuWl48F
         jeWJLO+OJfsIZzRFAQ/v//0DmpCm3G4gaCV09lbBmC7nzZeJq/ikO13jmh2DIZQ3I2fo
         KfghPkf+lAGVNVjjPVJonztH9VhgwLMcb8uetESJN/G8bPZ8CEH59HNb6CzNQT18UKVI
         SJYn5BuDefGmwIKADBUU9dWmY/9BWI00pVr80KYZf1XFXsCiint5a46xv2hICqluD+eG
         lgYWpEwh91QL1sRAjrQ+0fMv4TvDXXfu/zjIaoXKj5xAQFqsQDRrIfkg4noEfZ/ZYf2M
         3DaQ==
X-Gm-Message-State: AOJu0YzY1FTM1XBjNgPWP/AgX3jwXi7y7im/59TyLBLSJwQ/+7dCVoCi
	1d2+GOU0ogc4hZGwq3Dl04W3LZdk6gPxTG04izThKDBcasb8EEdhsZuHtXZ7jb0XND9+HUg0YKi
	2+3m3L7w=
X-Gm-Gg: Acq92OHfvIpR5TOQlPfWpT5cgObrz7AcVzbnFqU5NVRdqX4Sf/4hr1NiDwPyGcuabaO
	Wfac8fpxsJsbqnaPhLKrGokfWT+9oA0y7fCEvzEFMxkW1fIbpoLjiNO9jVrtDKCAI9S2TrY+ll7
	fjx3md3SE31bQ//e+aszKlVog2/mlspLWWDng8mUE8Vd1y2kBFZOAO7Q1vucO7BCkvLAw3hT0MA
	AQR5oFLE01RXP7nB/KKE7EWIau1IR57n4sc+4qsX1SiPi9lUcrbOxJYw6MJEi4gIADOfe2W+6MF
	Wpe/boEgQIE+mo7AItUlR16H4TwEO5ztX996jMmOyWq8iU/sI5spFL+mshsC1KQLdN/7owkM/FN
	ISi+J2zr66bVMWafICDrm5JyP0wvrSeeRM5FCBdWPayOh7CEWF9812Gx4IMA5wdeiD9qmo+CJuY
	s5Cgm90fb+Rf46IOTHFt8CxUzA1A==
X-Received: by 2002:a05:7301:4b15:b0:2f2:32bc:787d with SMTP id 5a478bee46e88-2fb4bd0a720mr7026387eec.23.1778579922097;
        Tue, 12 May 2026 02:58:42 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm22894743eec.31.2026.05.12.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:58:41 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Tue, 12 May 2026 02:58:14 -0700
Subject: [PATCH v2] i2c: mux: reg: use device property accessors
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260512-i2c-mux-reg-v2-1-80ea1da4cd0a@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIALX5AmoC/0XMMQ6DMAxA0asgzzUyThNVnXqPqoMLhmQgIAMVE
 uLujbp0fMP/ByxqSRe4VweYftKSplzAlwraKHlQTF0xMHEgRx4TtzhuO5oO6D0zuU5uPlyhFLN
 pn/bf7fkq7m0acY2m8n80jSdynl3NIQTCBuXdbWYSR8mPrPsap7mWBOf5BS1IKnudAAAA
X-Change-ID: 20260305-i2c-mux-reg-552203da8564
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778579921; l=8668;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=bOFM4QU5xu7KgGZMZwMPxnRovR6UYAHIvUlj+2CSig0=;
 b=wRXvPsmMpOcSHF/D7I62JthrLUl2BWyyOmNx4rW1H4Cd4BjHPKnZns6JsC8OAcRdKad8K5XH0
 VP6GnO9+jB+BD9Se42+A3TrBo3/Kk5t3ULaLY4J7mbN5AwvbGZC8FsL
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

Convert the device-tree parsing path to the generic fwnode/device
property accessors so the driver can be probed on ACPI and swnode
platforms as well as OF. The helper is renamed from
i2c_mux_reg_probe_dt() to i2c_mux_reg_probe_fw() to reflect that.

Accessor translation:

  of_parse_phandle("i2c-parent") +
    of_find_i2c_adapter_by_node()    -> fwnode_find_reference() +
                                         i2c_get_adapter_by_fwnode()
  of_get_child_count()               -> device_get_child_node_count()
  of_property_read_bool()            -> device_property_read_bool()
  for_each_child_of_node()           -> device_for_each_child_node()
    of_property_read_u32("reg")        on OF:   fwnode_property_read_u32()
                                       on ACPI: acpi_get_local_address()
  of_property_read_u32("idle-state") -> device_property_read_u32()

Behavioural preservations (deliberate, to avoid regressing existing
users):

  - The three-way endian fallback is kept verbatim: an explicit
    "little-endian" property wins, then "big-endian", and otherwise
    the host's compile-time byte order. device_is_big_endian() is
    not used here because it ignores "little-endian" and introduces
    "native-endian" semantics, which would diverge from the binding.

  - The platform-resource fallback for an un-mapped reg keeps its
    "if (!mux->data.reg)" guard so a platdata user that supplies a
    pre-ioremapped reg through struct i2c_mux_reg_platform_data is
    not clobbered.

The OF-only of_address_to_resource() translation in the old
probe_dt() is dropped because the same address is available from
the platform_device resource table on both OF and ACPI, and the
existing fallback in probe() ioremaps it.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Convert the device-tree parsing path in i2c-mux-reg to the generic
fwnode/device property accessors so the driver can be probed on ACPI
and swnode platforms in addition to OF.

Changes in v2 (per Peter's review of v1 [1]):

- Restore the three-way endian-property fallback verbatim. v1 used
  device_is_big_endian(), which ignores "little-endian" and adds
  "native-endian" semantics — a binding-visible behaviour change on
  big-endian hosts that did not specify the property. v2 keeps the
  original logic ("little-endian" wins, then "big-endian", else the
  host's compile-time byte order), expressed via
  device_property_read_bool() instead of of_property_read_bool().

- Restore the "if (!mux->data.reg)" guard around
  devm_platform_get_and_ioremap_resource() in probe(). v1 dropped it
  and would have clobbered the pre-ioremapped reg supplied by a
  platdata user through struct i2c_mux_reg_platform_data.

- Restore the dev_err_probe() wrapper at the probe_fw() call site so
  the silent error paths in the helper still produce a dmesg line on
  failure.

- Rewrite the changelog to enumerate the accessor translations, the
  new ACPI child-node handling via acpi_get_local_address(), and the
  behavioural preservations above.

Tested locally on the ACPI/non-OF code path I added. I do not have
any of the in-tree DT users of i2c-mux-reg on hand (the existing
boards are on PowerPC and SH), so I have not been able to verify
that the OF path is byte-for-byte unchanged in behaviour at runtime.
Tested-by tags from anyone running this driver on a current DT
board would be very welcome.

[1] https://lore.kernel.org/r/20260115003523.26660-1-abdurrahman@nexthop.ai
---
 drivers/i2c/muxes/i2c-mux-reg.c | 84 +++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 53 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 1e566ea92bc9..5a7ee763606c 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/platform_data/i2c-mux-reg.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -75,83 +74,64 @@ static int i2c_mux_reg_deselect(struct i2c_mux_core *muxc, u32 chan)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static int i2c_mux_reg_probe_dt(struct regmux *mux,
-				struct platform_device *pdev)
+static int i2c_mux_reg_probe_fw(struct regmux *mux, struct device *dev)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device_node *adapter_np, *child;
+	struct fwnode_handle *fwnode, *child;
 	struct i2c_adapter *adapter;
-	struct resource res;
 	unsigned *values;
-	int i = 0;
+	int ret, i = 0;
 
-	if (!np)
+	if (!dev_fwnode(dev))
 		return -ENODEV;
 
-	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
-	if (!adapter_np) {
-		dev_err(&pdev->dev, "Cannot parse i2c-parent\n");
+	fwnode = fwnode_find_reference(dev_fwnode(dev), "i2c-parent", 0);
+	if (IS_ERR(fwnode)) {
+		dev_err(dev, "missing 'i2c-parent' property\n");
 		return -ENODEV;
 	}
-	adapter = of_find_i2c_adapter_by_node(adapter_np);
-	of_node_put(adapter_np);
+
+	adapter = i2c_get_adapter_by_fwnode(fwnode);
+	fwnode_handle_put(fwnode);
 	if (!adapter)
 		return -EPROBE_DEFER;
 
 	mux->data.parent = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
 
-	mux->data.n_values = of_get_child_count(np);
-	if (of_property_read_bool(np, "little-endian")) {
-		mux->data.little_endian = true;
-	} else if (of_property_read_bool(np, "big-endian")) {
-		mux->data.little_endian = false;
-	} else {
-#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : \
-	defined(__LITTLE_ENDIAN)
+	mux->data.n_values = device_get_child_node_count(dev);
+	if (device_property_read_bool(dev, "little-endian"))
 		mux->data.little_endian = true;
-#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : \
-	defined(__BIG_ENDIAN)
+	else if (device_property_read_bool(dev, "big-endian"))
 		mux->data.little_endian = false;
-#else
-#error Endianness not defined?
-#endif
-	}
-	mux->data.write_only = of_property_read_bool(np, "write-only");
+	else
+		mux->data.little_endian = IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN);
+	mux->data.write_only = device_property_read_bool(dev, "write-only");
 
-	values = devm_kcalloc(&pdev->dev,
-			      mux->data.n_values, sizeof(*mux->data.values),
+	values = devm_kcalloc(dev, mux->data.n_values, sizeof(*mux->data.values),
 			      GFP_KERNEL);
 	if (!values)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
-		of_property_read_u32(child, "reg", values + i);
+	device_for_each_child_node(dev, child) {
+		if (is_of_node(child)) {
+			fwnode_property_read_u32(child, "reg", values + i);
+		} else if (is_acpi_node(child)) {
+			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), values + i);
+			if (ret) {
+				fwnode_handle_put(child);
+				return dev_err_probe(dev, ret, "Cannot get address\n");
+			}
+		}
+
 		i++;
 	}
 	mux->data.values = values;
 
-	if (!of_property_read_u32(np, "idle-state", &mux->data.idle))
+	if (!device_property_read_u32(dev, "idle-state", &mux->data.idle))
 		mux->data.idle_in_use = true;
 
-	/* map address from "reg" if exists */
-	if (of_address_to_resource(np, 0, &res) == 0) {
-		mux->data.reg_size = resource_size(&res);
-		mux->data.reg = devm_ioremap_resource(&pdev->dev, &res);
-		if (IS_ERR(mux->data.reg))
-			return PTR_ERR(mux->data.reg);
-	}
-
-	return 0;
-}
-#else
-static int i2c_mux_reg_probe_dt(struct regmux *mux,
-				struct platform_device *pdev)
-{
 	return 0;
 }
-#endif
 
 static int i2c_mux_reg_probe(struct platform_device *pdev)
 {
@@ -169,10 +149,10 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		memcpy(&mux->data, dev_get_platdata(&pdev->dev),
 			sizeof(mux->data));
 	} else {
-		ret = i2c_mux_reg_probe_dt(mux, pdev);
+		ret = i2c_mux_reg_probe_fw(mux, &pdev->dev);
 		if (ret < 0)
 			return dev_err_probe(&pdev->dev, ret,
-					     "Error parsing device tree");
+					     "Error parsing firmware description\n");
 	}
 
 	parent = i2c_get_adapter(mux->data.parent);
@@ -180,8 +160,6 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 
 	if (!mux->data.reg) {
-		dev_info(&pdev->dev,
-			"Register not set, using platform resource\n");
 		mux->data.reg = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(mux->data.reg)) {
 			ret = PTR_ERR(mux->data.reg);

---
base-commit: 0031c06807cfa8aa51a759ff8aa09e1aa48149af
change-id: 20260305-i2c-mux-reg-552203da8564

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


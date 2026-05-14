Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480F2F25F5
	for <linux-i2c@vger.kernel.org>; Thu, 14 May 2026 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720072; cv=none; b=hIssD6PrX/lMq02ilZE8JeFxX03BxD/D+XGcL/FEkSXMtUt6QzBoTuhBUyUIECyPMxp0RkpozclxpioG/0eSPX0TIQIL4Mmi3ZIzhpJtanGDmzCS2nOGC+1IWaEOiFOCcOLnJqyW/6gO5B03gSvTjR3pTQfHjzGfc+/R9tV4hAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720072; c=relaxed/simple;
	bh=MzGODVa4DeGQU5C+cZnr92IEwH4cg6ZVCQfAWMsP+Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uiq9LRpxjG89Yryjmpns/og9SOSgdZDALJhUZPPb7XAy1GApD20dZUy8fpsOeDw7zu8QFhQjx+X+h4hLRJlNOXxxC+LbKyz7tJbezXspgxUdwPotPRTNtsh4SHFFYl9pblsUPO/eI27OtR0pk//wTqhKLJ/x7/puuVyO1HZGwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=GC8pRs0g; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="GC8pRs0g"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso1254259eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778720070; x=1779324870; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BELW03wfNz2uc0F8K5d4Plbu0HoPLaDaE6GI8cbjIGU=;
        b=GC8pRs0gvYnBoau+iTo9L1PdMlhDcdPldCBtXuv7KwOtPfO30QGYXljCnVi9o7MCdV
         SQjJgJjdKE6XW3M/t/+GcOBmsyZnhwT+gjIFUf5Ex6wDpJNb/49SH1HT3YirT7V//dGS
         omIWm4XcXZDa9OyQmhAY1USUp92Ppc5UcCRu3j48spPoNpooJxp30Gdt0UJcSjvGm2nQ
         +Xf7aHiHMz5usfoQfhf7Zp0ayaYoy8eoHvkA9+YY6N2HCJBdKEVJgce4WH3PZyM08zaE
         HkkYBgvoFSEJb/yklPoEQDXTrTPUlef98B472z9gY4j6lOWNisVw7UJuAHqlA6oiF2BD
         J9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720070; x=1779324870;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BELW03wfNz2uc0F8K5d4Plbu0HoPLaDaE6GI8cbjIGU=;
        b=WtJFeWJEJzDB6FuSg8a8u36MAXx+XlNAaPdWzyY/TIDGz45JtCmfGAkAR70XiNDsaY
         ll0fwJmnnv/IijFO8xA/EmVR/TXu153BJGE/X6LfLssl4YWQKGApual6h1hYzXW4DcC3
         jTToEtBie4xvPZZ38E6djb6zTpTWqkkPClid6TPMiXYXdE0lOlJmq5qMhZFl7ax1GMDW
         Ufp4pZMz9zDwJKp6274zqlwh8Spx9guFe8vZ2+fMriu21SP0/c4bsy1XbFM4ZCgPr6BR
         R4uS1orKP5Ex5/o79C2eerd+KLcsCUw7wc1KUNe5Gar/ey+6fAwL7Nromx88qC7s8Sas
         kSsg==
X-Gm-Message-State: AOJu0YxDVs+kPw5/NhMcCWPtH9CXoJBqCMy3nP1C1TPRaZi3IIzVUo6O
	T77PB37EA1He0H4U7zs05lIS6Ogaq2HSsMPhGTeQL6UwgqCczDC7RqYD55Pd3c7bG2Ag4ZP+GAH
	NnSdMC8U=
X-Gm-Gg: Acq92OHG75zTIPWx/ifX3BexxV3CcLqkA3WFVz0lPUJsVXEa5tyZt8jjryNCd/b1+tS
	HVzUoNG7V9m1HQ2uJa3oEwwENfsGDXYbpc1Or3kriRLiwIkfGG2ujM4/YT3bI3hPctuRVP+fuOm
	4HJKsvzgwtFOGD36bGeqgdqTPrRHrMKf6RUMls4o710P9mcn2uslPqxxJAeZ2uxF4XoaxrdfXKY
	lpimvHOCNxgB7/xW+UPkzoYV9/Y4gKbew//TMc9O/aE6PAt+HUeeYtRllSFqozSTN5KDizbfPO0
	CsnURd9lCc4wf+PHqVz9T7aSguQgOM1G5l8yvMYwQsorZOybjE95QzJP+mkaQcTkMdWnHXSTqN3
	rBS5GvmgvPXkt8qv/vi5SjQXcCPdyEdmJGPv+ZlKCZP2Jm32gSjhNBYQZtvV+12v6Gk0dhG8q2V
	JQZN+tfdFUCbSJywsoYZ8kQ+XMGQ==
X-Received: by 2002:a05:7301:2290:b0:2f5:5dd3:1fcf with SMTP id 5a478bee46e88-301185a953emr3607968eec.10.1778720069630;
        Wed, 13 May 2026 17:54:29 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm1288218eec.15.2026.05.13.17.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 17:54:29 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 13 May 2026 17:54:27 -0700
Subject: [PATCH v3] i2c: mux: reg: use device property accessors
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-i2c-mux-reg-v3-1-0fa7242605bc@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAEIdBWoC/1XOOw7CMBBF0a1ErjEaj2MLUbEPlGKIB+wiH00+C
 oqydxwogPIW7+itamBJPKhzsSrhOQ2pa3PYQ6HqSO2DdQq5FQJ6sOB0wlo306KFH9o5RLCBTs6
 XKi964Xta3tq1yn2XrtFjFKavYYwDsA7tEb33oI2mW5hEKDbUXlpextj1R0q7F9MwdvJ8n5txV
 z+GM/j3Y8bMnIDJBCrrAPTrVNu2vQCpRjVe5wAAAA==
X-Change-ID: 20260305-i2c-mux-reg-552203da8564
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778720069; l=9590;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=MzGODVa4DeGQU5C+cZnr92IEwH4cg6ZVCQfAWMsP+Ow=;
 b=iObh15q+RVHet8dZIpR2c0r2DJjpoQGMNIrbDZzTIF0bsG4uCwAQ1WO7rKOvYquyRm4yJmyie
 iwgHH2VGI5ICetTU/ckTUbhV7aoRLkYW45/EMs1TAkdnmhdgb2fmKej
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
- Restore the original __BYTE_ORDER preprocessor check for the
  endian-property fallback. v2 replaced it with
  IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN), but that Kconfig symbol is
  only defined on architectures with configurable endianness (arm,
  arm64, mips, ppc, sh, xtensa, microblaze). On architectures where
  endianness is fixed (x86, RISC-V, ...), the symbol is undefined,
  IS_ENABLED() silently evaluates to false, and the mux defaults to
  big-endian register writes. On a little-endian host that turns any
  non-zero channel selection into garbage and quietly breaks every
  slave behind the mux.

- Replace put_device(&adapter->dev) with i2c_put_adapter(adapter).
  v1 switched from of_find_i2c_adapter_by_node() to
  i2c_get_adapter_by_fwnode(); the new helper additionally takes a
  try_module_get() on the adapter owner that put_device() alone does
  not release. This leaked a module reference on every successful
  probe.

- Read swnode child "reg" properties via fwnode_property_read_u32().
  The previous loop branched on is_of_node()/is_acpi_node() only;
  software nodes hit neither arm and silently left values[i] = 0,
  giving every swnode channel index 0 and breaking channel mapping
  on swnode platforms -- exactly the case the cover claims to add
  support for.

i2c: mux: reg: use device property accessors

Convert the device-tree parsing path in i2c-mux-reg to the generic
fwnode/device property accessors so the driver can be probed on ACPI
and swnode platforms in addition to OF.

Changes in v2 (per Peter's review of v1 [1]):

- Restore the three-way endian-property fallback verbatim. v1 used
  device_is_big_endian(), which ignores "little-endian" and adds
  "native-endian" semantics -- a binding-visible behaviour change on
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

[1] https://lore.kernel.org/r/20260115003523.26660-1-abdurrahman@nexthop.ai
Link to v2: https://patch.msgid.link/20260512-i2c-mux-reg-v2-1-80ea1da4cd0a@nexthop.ai
---
 drivers/i2c/muxes/i2c-mux-reg.c | 75 ++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 1e566ea92bc9..8b35a50e2841 100644
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
@@ -75,37 +74,34 @@ static int i2c_mux_reg_deselect(struct i2c_mux_core *muxc, u32 chan)
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
-	put_device(&adapter->dev);
+	i2c_put_adapter(adapter);
 
-	mux->data.n_values = of_get_child_count(np);
-	if (of_property_read_bool(np, "little-endian")) {
+	mux->data.n_values = device_get_child_node_count(dev);
+	if (device_property_read_bool(dev, "little-endian")) {
 		mux->data.little_endian = true;
-	} else if (of_property_read_bool(np, "big-endian")) {
+	} else if (device_property_read_bool(dev, "big-endian")) {
 		mux->data.little_endian = false;
 	} else {
 #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : \
@@ -118,40 +114,35 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 #error Endianness not defined?
 #endif
 	}
-	mux->data.write_only = of_property_read_bool(np, "write-only");
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
+		if (is_acpi_node(child)) {
+			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child),
+						     &values[i]);
+			if (ret) {
+				fwnode_handle_put(child);
+				return dev_err_probe(dev, ret,
+						     "Cannot get address\n");
+			}
+		} else {
+			fwnode_property_read_u32(child, "reg", &values[i]);
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
 	return 0;
 }
-#else
-static int i2c_mux_reg_probe_dt(struct regmux *mux,
-				struct platform_device *pdev)
-{
-	return 0;
-}
-#endif
 
 static int i2c_mux_reg_probe(struct platform_device *pdev)
 {
@@ -169,10 +160,10 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
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
@@ -180,8 +171,6 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 
 	if (!mux->data.reg) {
-		dev_info(&pdev->dev,
-			"Register not set, using platform resource\n");
 		mux->data.reg = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(mux->data.reg)) {
 			ret = PTR_ERR(mux->data.reg);

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260305-i2c-mux-reg-552203da8564

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


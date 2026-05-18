Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E9405C57
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139274; cv=none; b=mXsGJFNXhkeAI4k1qYAF7ZX1cT1b9GARB3032iAQWmfNl7JjHBXrLlCMUO/MtYZqGHzE/rSq6avISGRIpzqYSANl9HnEitqHHvo9wDLP3WGx227fkuPC0A6dx3Sx/X6cFCwfqNLifWCizoiyuMCN2qTGdlE/u3CkNbL6K2ziJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139274; c=relaxed/simple;
	bh=Xkg7XS4H8hyzwibl1dKIzkbzPTQnA5508G/NkaHude0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MSQYaEItRn2ZZ90IjHlW3E8yoQhoYtpSNS+9tYUUrCyTMNGQ9ILGsI5izpa6hrJQgDw1TlFV9UFlPe13tlg+DlfMdpJ4PLZSgdLvcAo1ZmcoUJYcwlvpxrCiKMmqUYuyhJ4ealAh017wtw4PAl3PxqKR9IzqnA3cep7Z4XdNjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=LSDQe6at; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="LSDQe6at"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1779875eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779139271; x=1779744071; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/fObRSH7iKN6IR818w8B3s5zjeyPDqroIxBkTQX8ts=;
        b=LSDQe6atCcUgQWaBA/yDN8hsUC7HfrBRZr0Mm1SCdLtCaUJGjPv3H/JAb3LkuFdBwt
         A1vpHvQQGWGybl/S925TCZ1QuK3Jv/qmTvF4vq39ZfvOIyavdS2V5b8FxBXNTAEflJHn
         nrWAXtQvBz3wL6j1g6tLueuqbtZaL1fy8Dg9eyVk3lp4Y4Hlc0IP6CzvtOFAW//MiLhr
         PGmQ/3tdp0InzfvbUaPvVit15v+0kEQ28eAIuYXAZ9MKvjj7aPvuTtCP55aTocI5G9gE
         aALNDV2TihpQ6j+1xAqyZ7egR7UhsBh7/bXoWGPQ0KtVK1vb6Ww0Zj0G6l0siS46MVuY
         FhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139271; x=1779744071;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/fObRSH7iKN6IR818w8B3s5zjeyPDqroIxBkTQX8ts=;
        b=mSSwanYcmjCJaUSF/Ky5/aZZAYmSbTgeh0OUFemOuNMW8AHYHsG2WGmK7Q4dY2kang
         Fh0C5tWA62mP8ZWMxGSKw7eitN1eYFJBXl9oz2V6TjPk+gJqtibbXp8O1amG/rJoVsmG
         ejtA+BfzX5K0kABzJEKVgq25saPLMuwdv6SQuqwNNL7kszG40dnLHIKDQiqycWNApPzL
         XYc6JSenn2TwnEl4PWlXfALqo7BkDI3x50D6bCeCUxOvya3nsuXssGZ65/BTa1vVggP7
         owur1dNmeERcH2fcmEsbmvqvYoH/RuRDLZ213PSt7IwQr4DMuLCEOsGCU4sjT2SZfoUZ
         X0YA==
X-Gm-Message-State: AOJu0Ywlu/10/I7cqP9VacnCa6B9nC96sCvwZh9Luu5C/sjJHu3VouPo
	4RLbyPS4Uezjs8IeTy446eYiTan1oLJB7rZApw/LVLd0B47vGLr4vZE9MeiUpKgSqixCsaxxkcz
	D3qr45EY=
X-Gm-Gg: Acq92OHH9PSOV7ZRv8hluGI4AYUEMAR/1HAOfeRozO7Y3WCI3/dFKOZHE59NkcN61ta
	U3cc0t1DPaAqAsMRecGl3DtJWDjmOkl3DHIeANu2zJ+6boynnfZZ3U/+RmDBp9IQYATwtAUK2M5
	pGAVVlMQyDmjdbj2J8EzEchAmjXiUkxDXeMJiCHroKB7XPNbqLaVTJi0W6Fx7eo/m/WCthXoMzU
	64mUPXmKjBNMEGySvn4GD8S4oo18nm52ZLqla0jH0JwhJsr5O4/rXext6SlDtP3Nqntms6MIj7H
	Xp4PV6uY6573InaMbfwNHDKN4uvZnq0b3icHkcoljsn1evRoEBzkzKzKbnXjOrUZPxWPl/i9Fhz
	TgFrt8/KgCIYxWqwZTymp0ndyarrbTnXtu1aCECj9VkXX6SUCjMQ5dM6GtoFYeKTeYBvApFZlXk
	hgNjjEDWZqbf1afQUigt0UwNue7A==
X-Received: by 2002:a05:7301:2c89:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-303979af460mr6102577eec.14.1779139271227;
        Mon, 18 May 2026 14:21:11 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b3cb2sm18818839eec.30.2026.05.18.14.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:21:10 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 14:21:06 -0700
Subject: [PATCH v4] i2c: mux: reg: use device property accessors
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-i2c-mux-reg-v4-1-0143917144d0@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAMGCC2oC/1WOQQ6CMBBFr2K6tmY6pdW48h7GxUAH2wVgBiQYw
 90tuFCWLz/v5b9Vz5K4V+fdWwmPqU9dm6HY71QVqb2zTiGzQkAPFpxOWOnmOWnhu3YOEWygk/O
 FysZDuE7TWrveMtfSNXqIwvRrGOMArEN7QO89aKOpDE8Rig21l5anIXaPA6WlF1M/dPJaz424V
 L8NZ3DzY8ScOQGTCVRUAei/sxwZ7b9st7LNMtR0xGJZy2ojz/P8ARReX9EkAQAA
X-Change-ID: 20260305-i2c-mux-reg-552203da8564
To: Peter Rosin <peda@lysator.liu.se>, Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779139270; l=11690;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=Xkg7XS4H8hyzwibl1dKIzkbzPTQnA5508G/NkaHude0=;
 b=8kdWhBoaz19aeKMR0u421mRnqgWXRmgGVfDnx5VzBMaTJVkq+Zq7/suDW6rmYNjIsdgmUFNW4
 kXrdup2KhZiASF3flPDUiPI5VmFuAp/5W9Sx5Pe9TZ4FV2Ms86H0c3g
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

Convert the device-tree parsing path to the generic fwnode/device
property accessors so the driver can be probed on ACPI and swnode
platforms as well as OF. The helper is renamed from
i2c_mux_reg_probe_dt() to i2c_mux_reg_probe_fw() to reflect that.

Accessor translation:

  of_parse_phandle("i2c-parent") +
    of_find_i2c_adapter_by_node()    -> fwnode_find_reference() +
                                         i2c_find_adapter_by_fwnode()
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

  - The "if (!mux->data.reg)" guard around
    devm_platform_get_and_ioremap_resource() in probe() is kept.
    drivers/platform/mellanox/mlx-platform.c registers i2c-mux-reg
    platform_devices with no memory resource and supplies a
    pre-set .reg / .reg_size through struct
    i2c_mux_reg_platform_data; without the guard those
    registrations would fail in probe().

  - The "if (!mux->data.reg)" ioremap block (and the paired
    reg_size validation that depends on it) is hoisted above
    i2c_get_adapter(mux->data.parent), so the fwnode path
    preserves master's ordering of "ioremap before parent-adapter
    get".  For platdata users the validation runs from a slightly
    earlier position, but mux->data.reg_size is already set from
    platdata by then, so the order is functionally neutral.

The OF-only of_address_to_resource() translation in the old
probe_dt() is dropped because the same address is available from
the platform_device resource table on OF as well as ACPI, and the
existing fallback in probe() ioremaps it.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
- Switch the parent-adapter lookup back from
  i2c_get_adapter_by_fwnode() to i2c_find_adapter_by_fwnode() +
  put_device(), matching the OF original's
  of_find_i2c_adapter_by_node() semantics (device ref only, no
  module ref).  probe()'s subsequent i2c_get_adapter() does its
  own try_module_get() and -EPROBE_DEFERs on failure, so the
  brief acquire-then-release in probe_fw() wasn't earning
  anything.

- In probe(), hoist the "if (!mux->data.reg)" ioremap block
  (together with the paired reg_size validation) above the
  i2c_get_adapter() call, restoring master's "ioremap before
  parent-adapter get" ordering on the fwnode path.

- Patch description: name drivers/platform/mellanox/mlx-platform.c
  as the concrete in-tree platdata user that motivates keeping
  the "if (!mux->data.reg)" guard around the platform-resource
  ioremap path.  No code change.

- Link to v3: https://patch.msgid.link/20260513-i2c-mux-reg-v3-1-0fa7242605bc@nexthop.ai

Changes in v3:

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
 drivers/i2c/muxes/i2c-mux-reg.c | 90 +++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 52 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 1e566ea92bc9..4d076c46dac2 100644
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
+	adapter = i2c_find_adapter_by_fwnode(fwnode);
+	fwnode_handle_put(fwnode);
 	if (!adapter)
 		return -EPROBE_DEFER;
 
 	mux->data.parent = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
 
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
@@ -169,34 +160,29 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
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
 
-	parent = i2c_get_adapter(mux->data.parent);
-	if (!parent)
-		return -EPROBE_DEFER;
-
 	if (!mux->data.reg) {
-		dev_info(&pdev->dev,
-			"Register not set, using platform resource\n");
 		mux->data.reg = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-		if (IS_ERR(mux->data.reg)) {
-			ret = PTR_ERR(mux->data.reg);
-			goto err_put_parent;
-		}
+		if (IS_ERR(mux->data.reg))
+			return PTR_ERR(mux->data.reg);
 		mux->data.reg_size = resource_size(res);
 	}
 
 	if (mux->data.reg_size != 4 && mux->data.reg_size != 2 &&
 	    mux->data.reg_size != 1) {
 		dev_err(&pdev->dev, "Invalid register size\n");
-		ret = -EINVAL;
-		goto err_put_parent;
+		return -EINVAL;
 	}
 
+	parent = i2c_get_adapter(mux->data.parent);
+	if (!parent)
+		return -EPROBE_DEFER;
+
 	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values, 0, 0,
 			     i2c_mux_reg_select, NULL);
 	if (!muxc) {

---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260305-i2c-mux-reg-552203da8564

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


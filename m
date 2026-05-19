Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915635A3B1
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214785; cv=none; b=eQzgiGdNiEfb7zoHiiPcHaySkDah5GQ2W03pgSwDpZFpYMTjwPLR0C8JEXp6rDTdlryvw7stYFwEx+CfssoYF6rDKxR03HG/5soJk83mjq8oIxROAexCf/VsM4Qzyz7Z2ACZmMI+weveyOAn6l/dMXlfohTyDUFJg1pnRt23wFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214785; c=relaxed/simple;
	bh=011c6Jh4xWmSqAqrzi85Yq5JgEYpNeoBlg3EZSAIjgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tfCoxDTgDtFpXrel/YbWRXuEnZu3pgCHZEMbvrquYQGvQtsJU1Qe0HsbHvo2yiQllj2TMLYWLMMb0uTIUcAbp+KjhwfS4qc5LwENQv+AruoNKX3rz2Q8dW3wiBSlrp/Ou5uHMO+IcvdRPGIupCP1K/6usbJ4432r1tGWY/22T0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=C/EhWX2/; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="C/EhWX2/"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f3c623322bso366683eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779214781; x=1779819581; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQJW3WCfJKOz/Cwke2nbE8MPA/u27zOGB07cr3akkaw=;
        b=C/EhWX2/yJ6JTl5SGc99EBjNJ4ycc0h/pDrOxMpdH97LLB9loTURk5VJvp8VgYUMTJ
         C1x8yq+oLsS5+DjmDjGHMLwgO/h1cDE2rBFYccf4reHRuAHtfH3m/7eOCDvL5hnM4IAY
         10BkEAj5PGK9cLLDELxX7MH2XW0QGeiKe4FTLW188md8UvK1CF2yMAu4gbQ72k39KQER
         DZz0FzRq0lY/lXbGKyFgIykJkSc+bdPWUKVVR+vr6Jxz5dpXTtMmW3YjmzH/qoIpUKpc
         tdEIYZTELjrQ0oW1EccydfsM6RBp4JGTE18mG9EHWZbyKUYm5Hhroa1yf/TpQiSmvQdw
         /U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214781; x=1779819581;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQJW3WCfJKOz/Cwke2nbE8MPA/u27zOGB07cr3akkaw=;
        b=RBfqXoHy7t6elepAwXsupsmlPrJfCTLrKWr1dGOjcKfZVc6PTmkN6caFWSzmvA03wj
         DkealvH71WYTdW22NfMY5WALUR8205kNc01H7c7g+6xjAwPUgXGvV2rdrSiRxcf/wSbf
         4hc8Cn/niSCrln4JrbkTANd940zvfzu4TC3C9g62q63AYxwPlSTUVbtqtt+aLZWFnjT0
         +Pv3Pa7VXQvQvfdKn5guhNURuLOyNO8HDi6h9TX57mClZmLcNdp5aA4vLX9VjnG2IIUv
         83NnfSrAh7kkM7rsgEiOgg8auI8REb9FQOjThrmthgxCLKnfXCG3fzkDXxZQl2BkWugA
         xW8Q==
X-Gm-Message-State: AOJu0YxwjKR+PO9jBLINJckRpp6+RO07S7c/rX9YBUeEixYoTdTb2iMY
	lkKylNGutnclKtJALtBu4PluaYtxjA2GzzGy0sFJw2Acww/tzlxCO/9cWKA9IS85rbA5yk7oqWI
	wo03ea7o=
X-Gm-Gg: Acq92OGEgIDPQdXanpXsdsI1gXZMonYXqSRcMMLqPbKSMNJExdv4wrq6fvFa1fwcJSg
	gW7+Mh8MIYmTF0YvzsOsU4rTPQ/f89ZApIFbG1aV9i5KqrbnHtcNqc7oya702KKNb4hJWHQzn46
	A6kUJl/vixqKtGS0wgl3d5+Gf5oVncMdK3TcQPjnZ8Q/mK5EHG4C2ZKzSeA3BWWV9RfaVdN5YZk
	F5xvrKBi1Lg9ttvQIfCY+LQyeGkEdH01oV1EVlYBaS26yRKLLqbvBSR3FSRjMss2ZPclb5gHpjY
	Ql5Tbhhw+bMm2drxeMCI595n6DamIpVoNmlpBeFRC44ampu29weXVVCAMDHi73cKOFhtYVzAOeT
	PqKmeseGAZ/GmIJ/vrZ0o3aEtpZwxIg7GnqbdpvYhCAOod+Xk3nHAapXNJo319tksRp3wtsNibe
	KcN0u7djjnsPzsDVAp0n/iP2guZA==
X-Received: by 2002:a05:7301:1001:b0:2e5:5bf4:8869 with SMTP id 5a478bee46e88-303986771bcmr9519703eec.21.1779214780728;
        Tue, 19 May 2026 11:19:40 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm20039144eec.5.2026.05.19.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:19:40 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Tue, 19 May 2026 11:19:36 -0700
Subject: [PATCH v5] i2c: mux: reg: use device property accessors
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-i2c-mux-reg-v5-1-7af068f255cd@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIALepDGoC/2XOTY7CMAyG4augrAlynB8KK+6BWJjGJVm0RWmpi
 lDvPgmzmFaz/GQ9r/wRA6fIgzjvPiLxFIfYd3nY/U7UgboHy+jzFgjoQIOVEWvZvmaZ+CGtRQT
 tqbLOiCyeiZs4f2vXW95N6ls5hsT011DKAmiL+oDOOZBK0t2/UqLQUnfpeB5D/zxQLL0Qh7FP7
 +9zE5bqb8Mq3PwxYc5UwKQ8mdoDrTvlkUmvsd5inTE0dERTrvf6HzZrXG2xKVgZfVJHZYyHDV6
 W5Qcz62xcYQEAAA==
X-Change-ID: 20260305-i2c-mux-reg-552203da8564
To: Peter Rosin <peda@lysator.liu.se>, Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779214780; l=13412;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=011c6Jh4xWmSqAqrzi85Yq5JgEYpNeoBlg3EZSAIjgA=;
 b=wh1yoidfpXl6VoNGYXPAVCBb3wRro/3Vcos42wiGyBNnr3cRr8k0vWjUvxYstv51MbP9Piaws
 fLF9eY72B7uBNpaGPcR1P/oItzvqQwkV6gw172cGS9bSKF7E38GfOfw
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
    of_property_read_u32("reg")        on ACPI device nodes:
                                         acpi_get_local_address()
                                       everything else (OF, swnode,
                                       ACPI data nodes):
                                         fwnode_property_read_u32()
  of_property_read_u32("idle-state") -> device_property_read_u32()

The child-node branch uses is_acpi_device_node() rather than
is_acpi_node(): the latter also matches ACPI data nodes (the
_DSD hierarchical-property children used by PRP0001-style
firmware), which have no ACPI handle and would make
acpi_get_local_address() fall back to evaluating _ADR against the
root namespace and return -ENODATA.  Routing data nodes through
fwnode_property_read_u32() instead lets them resolve the "reg"
property the same way OF and swnode children do.

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
- Discriminate ACPI children with is_acpi_device_node() instead of
  is_acpi_node().  v4 routed every is_acpi_node() child to
  acpi_get_local_address(), which is wrong for ACPI data nodes
  (the _DSD hierarchical-property children PRP0001-style firmware
  uses): data nodes have no ACPI handle, so ACPI_HANDLE_FWNODE()
  returns NULL, acpi_get_local_address() falls back to evaluating
  _ADR against the root namespace, and the probe fails with
  -ENODATA.  is_acpi_device_node() narrows the match to ACPI
  device nodes (which do carry an _ADR), and the else-branch now
  resolves "reg" via fwnode_property_read_u32() for OF, swnode,
  and ACPI data nodes alike.  Flagged by Sashiko on v4.

- Patch description: extend the accessor-translation table to show
  the new ACPI-device-node vs everything-else split, plus a short
  paragraph explaining why is_acpi_device_node() is the right
  predicate.

- Link to v4: https://patch.msgid.link/20260518-i2c-mux-reg-v4-1-0143917144d0@nexthop.ai

Changes in v4 (per Peter's review of v3):

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
index 1e566ea92bc9..13da757100fe 100644
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
+		if (is_acpi_device_node(child)) {
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


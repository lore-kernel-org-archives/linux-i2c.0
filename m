Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689D32C937
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225536; cv=none; b=BA4oxhzLDHHZt9AkIxN97OBXj5Sfhb17mM0u45f/LUEtx4pOk1aHIXS6NaRep2BT+g+F/2pwiNAO8L9K83TFVWXr3ToHbBQATrnlPb7zpmjflWbnpC4+XsDgjD9I6PdyWDy5rkQOh6siDsOPTxU2PulctIzSPt4OhlXEush4Xxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225536; c=relaxed/simple;
	bh=QIZqmHymnRrsejWwAK70fTNqVgfK8dTswBEsYXCbmyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Iu5+mfGYEwQVuP2/Jzd3dFJJwquoIkNuJFJClmbm+CpXG42EMfwRQSsR4ufgYyG0mkAh48puqPoo+qUoErssALg9w85Ken+VENlD4hbdlzIOlytNAZBhvy5osMEt4j7SUCOJTvi/45q1pOzGU9ef4MBnchsR0YE4NJBT27aUq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=UqMg/n3g; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="UqMg/n3g"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1357c851a48so4122037c88.1
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779225534; x=1779830334; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOiYUMp/X2BOdrrhMg75tq2SkCKQ2xp8QzPlJ/rrRsI=;
        b=UqMg/n3gea0jiiexJhHhV1cewGkvGomIM/CAcjaaUICQfXXxP7M3QF9V0sl1D+R8S7
         W3L7+Yu2wgW0FAweTcLvCSVCVFzeipuC8d0Y1LQfJi3KpkXi7mgNP+NhjQKStEsSuJJS
         KqFUBDmBDoti4nBW/ic3gE31ax0KZmMS9Qs5NCSQmpIB8fXqmQ9qHKCQfkpW5r008Nph
         z/mK0dYayqlH/bCk4eF9XvdUTjHQ4uv6X351p/Ca5qMUvOckZBhKxqLKLy7jCOuO3n6H
         WXKboY+qXBJedNeN7i5Z+jkYWRCkOusUK9QnZSJhPB8GbJM9WbYmnkd6Ys/OP32LlncW
         Ff+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225534; x=1779830334;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOiYUMp/X2BOdrrhMg75tq2SkCKQ2xp8QzPlJ/rrRsI=;
        b=lQkZfN29JTHpd3FKi0TA6GOTkW48qLRCOjVj9fErdJGJqyZ6uOgL6Djl3s2NdVaqYn
         xxQuKr06p1pxMzdtoJVHYbre4bRM0vEtdttwUbUuY3NXRtTNgG5cAH15EEPW62ony07C
         bpzWTKu7GGTz4rwlJpWJshUVB/M+R7Qsn5OEz8bLCHGaf8hLhj8kwuTH/xQNTXVfn0oJ
         ua5huuqPA0p3+aUaPmTtq0LeSFsZBbToHrhjEpSweRmezPIaKOILBTaTwmHyaNX0e34m
         9kCjI3i2SyqKMq/Pny3K1KqIldPCKzAyhewm00mAGE0JGFQ/oy9i2KSvTyuwFRLArUbM
         WzNQ==
X-Gm-Message-State: AOJu0YzEY4/K/2u/bbfcwvaa8n9iTRZ58Cxh7jHYhmSsowNCye74YrMF
	MHMedscuI98t+Wnw8Gq+QlyXdwNGuEylivbHng2gpDDSX+aItsTYC9RmIAlrEoIT4teQLaTceNW
	A+/7aQo8=
X-Gm-Gg: Acq92OELJfeBaXjmplTWJHUN2NDK9JddcBvqV0CFjcTqdL6LHq3h9C8ulddQibnARYJ
	OtqDwLQrDffa4Dk4+KOWeS2hNcdY8zBlgzFl5onIIU8a7CdLPjfxt9AzqCNITQQyGtQLJz8WTeg
	vDSQyKppmBJwX+peiPx5KN8aiKlfsjvgYqm19NVhXxnxfWdu77jgeCA2eYXc7oTlp3FivLTyJL5
	IC7OuNWGR2vuyH2KWMp+Vye+Mfa4KUTvUeLjINxQqO5nyz4stpySxUJZcKUIe9ttwn4orn9c7io
	zk0jdYf9oQDP6pbvbJMWoUJ0MLgl86Dy2FhYbr/0a0TwnCN4InvdsOA3Aeck1z/Aii2XjfVP+o/
	CaqoxQ7MrisNSsa9fsWe8mVqE0YT7xfsbzZtmIS4kKAA1VvtW5Btvjdpn8TXbbP4A40JkT/quqm
	/S/c62oufddHIQgqC3RPFgcY/Bs1Wrc1Nsib2M
X-Received: by 2002:a05:7022:7a2:b0:130:ab68:2b5e with SMTP id a92af1059eb24-13504312dddmr9144324c88.4.1779225533470;
        Tue, 19 May 2026 14:18:53 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm25790017c88.9.2026.05.19.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:18:53 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Tue, 19 May 2026 14:18:50 -0700
Subject: [PATCH v6] i2c: mux: reg: use device property accessors
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-i2c-mux-reg-v6-1-a27ff50dee67@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIALnTDGoC/2XOwY6CMBDG8VcxPW/NdNop6GnfY+NhpK3tATAFC
 cbw7lvcw0I8fpn8/pmXGHxOfhDnw0tkP6Uh9V0Z9usgmsjdzcvkyhYIaEEDyYSNbB+zzP4miRB
 BO67JGlHEPfuQ5nft51J2yH0rx5g9/zeUIgBNqI9orQWpJF/dI2eOLXffnZ/H2N+PnNZeTMPY5
 +f7uQnX6l+DFO7+mLBkavCsHJvGAW876yOT3mK9x7pgCFyhWa/X5gObLa732KxYGX1SlTLGwQe
 mLT7tMRVccQBbByRq3A4vy/ILWBe1054BAAA=
X-Change-ID: 20260305-i2c-mux-reg-552203da8564
To: Peter Rosin <peda@lysator.liu.se>, Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779225532; l=14029;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=QIZqmHymnRrsejWwAK70fTNqVgfK8dTswBEsYXCbmyc=;
 b=dFwRr3NJfaPTD8CxoIH/qhLq19D3QFTOU2bh8Rxl63fewLoU9oUGbQ7e70/xmv5CiuQthc+NY
 5CdRiYaUlgxDtAcgFr4VPvzY/qX2Q+wPlxGw2QnMNF1FcC6Xd8vFl/f
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

Acked-by: Peter Rosin <peda@lysator.liu.se>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Assisted-by: Claude-Code:claude-opus-4-7
Assisted-by: sashiko:gemini-3.1-pro-preview
---
- Add Assisted-by: trailers per
  Documentation/process/coding-assistants.rst to acknowledge the
  AI assistance used while preparing this series (Claude Code
  during development, and sashiko's Gemini-backed reviewer that
  caught the is_acpi_node()/is_acpi_device_node() distinction
  addressed in v5).  No code change.

- Pick up Peter Rosin's Acked-by from v5.

- Link to v5: https://patch.msgid.link/20260519-i2c-mux-reg-v5-1-7af068f255cd@nexthop.ai

Changes in v5:

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


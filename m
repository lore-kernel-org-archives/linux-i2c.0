Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC822F7445
	for <linux-i2c@vger.kernel.org>; Sat, 28 Feb 2026 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242925; cv=none; b=Ae1RfTBcL+mAmKv8N20JUio8CLeMBoNMflWeRXyi6Z4aZjCckpWvnrOjQmmI6WebN8YzF4d2DY+PXbID/ggwmxHwtFA2aURSTP/UdW5EID5uPNZec+aZpi/l5xKiwmKm/4ZqWrFGyI2f/QoSrCC2/vSbDpGOlE4P9KC7booZB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242925; c=relaxed/simple;
	bh=tghNlPhUDkiomLSifSCjQ4NBUNBVcg8CkJQxrGysYYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rw092ypuzXp+OPbrHdFuZnYusbD/awD190s745cc2Rj0H4gWTQKzT1ZdkDPh5USOhzYwf3rxzk5zV6udghxB9NwDQtIbvQerzFhJOZlZPiytFN+jcWOIhAs0ClAJgCDMZhLBOA77sYHi2EEe7v/R4dtOSFYWis5o8scl3MzWdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL86eDGG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrzxHfqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL86eDGG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrzxHfqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772242922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=stBAJUVAT1cR/W/HFQeqlmRnAKPFYOCN0yyyWRTAjn0=;
	b=gL86eDGGXjMxdF8Aliu0IkGtBJvkJURbeDaLkV+/kbmBRt6jfgfb5jNdf5dYaLqpttKa/j
	hkp3XHOBWCw1uMKU4uNdmrVIIBK1vUEmZRMRkPzFuSfdD9czpI3M/lHyrfOVuUGGvTWn8z
	dlLNdi7Ts9bR/dFqrmtRInxHgxSy+IU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-SyRRK7PiNUOPJDxkgoGEZA-1; Fri, 27 Feb 2026 20:41:55 -0500
X-MC-Unique: SyRRK7PiNUOPJDxkgoGEZA-1
X-Mimecast-MFC-AGG-ID: SyRRK7PiNUOPJDxkgoGEZA_1772242914
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c2b7f4caso21840925a34.2
        for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 17:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772242914; x=1772847714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stBAJUVAT1cR/W/HFQeqlmRnAKPFYOCN0yyyWRTAjn0=;
        b=MrzxHfqskqRd95RMUtbgTp+dwGqg8zpZuSp15aDFNepyePthVfYTGrBZTv+UALEzge
         SGzduPaK5qxVM/+Lu0Dfv5x69WMdiuGjtXBAzIlnGjR7J7z3kurTCelpg68MdebUvOhF
         eHIT9EC80q4oFiXH/7ZQzZBPcc5TmkMlQ0g4zI6WxqJI4qP/Qn0GKDasQGSrR7e6jMpb
         3CLptNljQp21bVXPAN+AWNeMr5GeS0MBp/EwSudSqWb0kGFCjLWFb4/mvg1oQPWx70/u
         5afySh+uQfVPF7Dn/n8QHggFifyfc5TvTUUjwOKmAMm1ESBDnizhNZgLUtJx7/o2HsD7
         nZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772242914; x=1772847714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stBAJUVAT1cR/W/HFQeqlmRnAKPFYOCN0yyyWRTAjn0=;
        b=nciRpZ0zTBn0i1YinkWwOyggxqECOZXCIAjGuuhXyZE3WzQrwVN7DV2Jx/zhGzOvJe
         TITdFjxU9cPR1x4BhaXI8Q+qKyu0Z4YiC/FkCqhupx+2FMmotgbdImQ5fzXX7GfQSBiG
         Mor8+w2fMX8aDMWONCU4wZg8e1CbbxG8nbWnnNO5z7U1j9Vur1ImDq1IPQLWRobRkfEX
         sLRA5cqkNKp+74nzICaZ/pmLckbU5QftcjHHgs4oMtTZw5FPgYozGEIOSuitskoJWg9M
         fFEcrNQn7PqcX3G1DlcI4ROLaV7s1YtG75PbuMzsf+sNQiitbT+p1Z0O4jriCQ19cef8
         AsJg==
X-Forwarded-Encrypted: i=1; AJvYcCUdsgGE1SIX0HaKyeW0mxHU5gbqn1Z41PPHNvAqD+6VNDcyIFIHEsRDLyArqidiIIMnMTGe7o+oBaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vAEO7mdc+cYcqjOYAGa/slM+BXOvu62iJrkrNPlLGVZ6h3iZ
	jBO/szRNVyZfI/Kn+fBMatP9wRJN6s8i0QHUejuA2rKn/lggUdmCZNs4L1oOCrlm7oHLftXmcx4
	9skiDXICeDqB82CcwV6pjo8pj4iLBMCzOZRHbGhLu7u/GUsAFqol6hhLxNgZiBg==
X-Gm-Gg: ATEYQzwQy2qIPuTyqKuOtVLNFmPM1TL0LeZgZ0XLk+d71DAvnmWNyxIH/3GdG36GDoT
	mtcwYuCKVC1WpFHmVPJ+0qIunv98TQFmX/u75DomxI7oQ4YQ1TFvIUq15XYbB3UAU4qvXmAQE9w
	FBOERt4Z8efaaKEuehZb3nx53nOFtW/42mS4NHDwm2W7SeqNn6X+kqal19gNdXvJJD1jH32hhzU
	PdBn6DMmfEUSyi+GXW+9P6fMWfm6wv6xIlY3qyD9lq9iWXlw+jmpqCNKCpOfMdA/ATN6w24l/Qn
	+VB/soyi63Oj3leXjeveBuQxtHHZg/yG+Nnp6fsBo/ZilDh+2PQcAXbPsGUy1PKc2UItB5bO50T
	S/SD4Dc2Kipv09HZyLqCDNyZHf3kQ2r+1hzkDi63wkN7aVqMxJniBdEDOLXRduB92y3gD8iiWXA
	PLZSP2kKkH6xqljy0any7bUa0G
X-Received: by 2002:a05:6830:4987:b0:7d4:c263:8495 with SMTP id 46e09a7af769-7d591be24bfmr3334243a34.26.1772242914179;
        Fri, 27 Feb 2026 17:41:54 -0800 (PST)
X-Received: by 2002:a05:6830:4987:b0:7d4:c263:8495 with SMTP id 46e09a7af769-7d591be24bfmr3334233a34.26.1772242913738;
        Fri, 27 Feb 2026 17:41:53 -0800 (PST)
Received: from chaithco-thinkpadp16vgen1.therouter.haith.cloud (174-16-132-196.hlrn.qwest.net. [174.16.132.196])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866541fcsm5484611a34.21.2026.02.27.17.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 17:41:53 -0800 (PST)
From: Charles Haithcock <chaithco@redhat.com>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: Charles Haithcock <chaithco@redhat.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: i801: Revert "i2c: i801: replace acpi_lock with I2C bus lock"
Date: Fri, 27 Feb 2026 18:41:15 -0700
Message-ID: <20260228014124.1884412-1-chaithco@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f707d6b9e7c18f669adfdb443906d46cfbaaa0c1.

Under rare circumstances, multiple udev threads can collect i801 device
info on boot and walk i801_acpi_io_handler somewhat concurrently. The
first will note the area is reserved by acpi to prevent further touches.
This ultimately causes the area to be deregistered. The second will
enter i801_acpi_io_handler after the area is unregistered but before a
check can be made that the area is unregistered. i2c_lock_bus relies on
the now unregistered area containing lock_ops to lock the bus. The end
result is a kernel panic on boot with the following backtrace;

[   14.971872] ioatdma 0000:09:00.2: enabling device (0100 -> 0102)
[   14.971873] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   14.971880] #PF: supervisor read access in kernel mode
[   14.971884] #PF: error_code(0x0000) - not-present page
[   14.971887] PGD 0 P4D 0
[   14.971894] Oops: 0000 [#1] PREEMPT SMP PTI
[   14.971900] CPU: 5 PID: 956 Comm: systemd-udevd Not tainted 5.14.0-611.5.1.el9_7.x86_64 #1
[   14.971905] Hardware name: XXXXXXXXXXXXXXXXXXXXXXX BIOS 1.20.10.SV91 01/30/2023
[   14.971908] RIP: 0010:i801_acpi_io_handler+0x2d/0xb0 [i2c_i801]
[   14.971929] Code: 00 00 49 8b 40 20 41 57 41 56 4d 8b b8 30 04 00 00 49 89 ce 41 55 41 89 d5 41 54 49 89 f4 be 02 00 00 00 55 4c 89 c5 53 89 fb <48> 8b 00 4c 89 c7 e8 18 61 54 e9 80 bd 80 04 00 00 00 75 09 4c 3b
[   14.971933] RSP: 0018:ffffbaa841483838 EFLAGS: 00010282
[   14.971938] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9685e01ba568
[   14.971941] RDX: 0000000000000008 RSI: 0000000000000002 RDI: 0000000000000000
[   14.971944] RBP: ffff9685ca22f028 R08: ffff9685ca22f028 R09: ffff9685ca22f028
[   14.971948] R10: 000000000000000b R11: 0000000000000580 R12: 0000000000000580
[   14.971951] R13: 0000000000000008 R14: ffff9685e01ba568 R15: ffff9685c222f000
[   14.971954] FS:  00007f8287c0ab40(0000) GS:ffff96a47f940000(0000) knlGS:0000000000000000
[   14.971959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.971963] CR2: 0000000000000000 CR3: 0000000168090001 CR4: 00000000003706f0
[   14.971966] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   14.971968] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   14.971972] Call Trace:
[   14.971977]  <TASK>
[   14.971981]  ? show_trace_log_lvl+0x1c4/0x2df
[   14.971994]  ? show_trace_log_lvl+0x1c4/0x2df
[   14.972003]  ? acpi_ev_address_space_dispatch+0x16e/0x3c0
[   14.972014]  ? __die_body.cold+0x8/0xd
[   14.972021]  ? page_fault_oops+0x132/0x170
[   14.972028]  ? exc_page_fault+0x61/0x150
[   14.972036]  ? asm_exc_page_fault+0x22/0x30
[   14.972045]  ? i801_acpi_io_handler+0x2d/0xb0 [i2c_i801]
[   14.972061]  acpi_ev_address_space_dispatch+0x16e/0x3c0
[   14.972069]  ? __pfx_i801_acpi_io_handler+0x10/0x10 [i2c_i801]
[   14.972085]  acpi_ex_access_region+0x5b/0xd0
[   14.972093]  acpi_ex_field_datum_io+0x73/0x2e0
[   14.972100]  acpi_ex_read_data_from_field+0x8e/0x230
[   14.972106]  acpi_ex_resolve_node_to_value+0x23d/0x310
[   14.972114]  acpi_ds_evaluate_name_path+0xad/0x110
[   14.972121]  acpi_ds_exec_end_op+0x321/0x510
[   14.972127]  acpi_ps_parse_loop+0xf7/0x680
[   14.972136]  acpi_ps_parse_aml+0x17a/0x3d0
[   14.972143]  acpi_ps_execute_method+0x137/0x270
[   14.972150]  acpi_ns_evaluate+0x1f4/0x2e0
[   14.972158]  acpi_evaluate_object+0x134/0x2f0
[   14.972164]  acpi_evaluate_integer+0x50/0xe0
[   14.972173]  ? vsnprintf+0x24b/0x570
[   14.972181]  acpi_ac_get_state.part.0+0x23/0x70
[   14.972189]  get_ac_property+0x4e/0x60
[   14.972195]  power_supply_show_property+0x90/0x1f0
[   14.972205]  add_prop_uevent+0x29/0x90
[   14.972213]  power_supply_uevent+0x109/0x1d0
[   14.972222]  dev_uevent+0x10e/0x2f0
[   14.972228]  uevent_show+0x8e/0x100
[   14.972236]  dev_attr_show+0x19/0x40
[   14.972246]  sysfs_kf_seq_show+0x9b/0x100
[   14.972253]  seq_read_iter+0x120/0x4b0
[   14.972262]  ? selinux_file_permission+0x106/0x150
[   14.972273]  vfs_read+0x24f/0x3a0
[   14.972284]  ksys_read+0x5f/0xe0
[   14.972291]  do_syscall_64+0x5f/0xe0
...

The kernel panic is mitigated by setting limiting the count of udev
children to 1. Revert to using the acpi_lock to continue protecting
marking the area as owned by firmware without relying on a lock in
a potentially unmapped region of memory.

Signed-off-by: Charles Haithcock <chaithco@redhat.com>
---
 drivers/i2c/busses/i2c-i801.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9e1789725e..0ff3edccce 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -310,9 +310,10 @@ struct i801_priv {
 
 	/*
 	 * If set to true the host controller registers are reserved for
-	 * ACPI AML use.
+	 * ACPI AML use. Protected by acpi_lock.
 	 */
 	bool acpi_reserved;
+	struct mutex acpi_lock;
 };
 
 #define FEATURE_SMBUS_PEC	BIT(0)
@@ -894,8 +895,11 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int hwpec, ret;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 
-	if (priv->acpi_reserved)
+	mutex_lock(&priv->acpi_lock);
+	if (priv->acpi_reserved) {
+		mutex_unlock(&priv->acpi_lock);
 		return -EBUSY;
+	}
 
 	pm_runtime_get_sync(&priv->pci_dev->dev);
 
@@ -935,6 +939,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
+	mutex_unlock(&priv->acpi_lock);
 	return ret;
 }
 
@@ -1465,7 +1470,7 @@ i801_acpi_io_handler(u32 function, acpi_physical_address address, u32 bits,
 	 * further access from the driver itself. This device is now owned
 	 * by the system firmware.
 	 */
-	i2c_lock_bus(&priv->adapter, I2C_LOCK_SEGMENT);
+	mutex_lock(&priv->acpi_lock);
 
 	if (!priv->acpi_reserved && i801_acpi_is_smbus_ioport(priv, address)) {
 		priv->acpi_reserved = true;
@@ -1485,7 +1490,7 @@ i801_acpi_io_handler(u32 function, acpi_physical_address address, u32 bits,
 	else
 		status = acpi_os_write_port(address, (u32)*value, bits);
 
-	i2c_unlock_bus(&priv->adapter, I2C_LOCK_SEGMENT);
+	mutex_unlock(&priv->acpi_lock);
 
 	return status;
 }
@@ -1545,6 +1550,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	priv->adapter.dev.parent = &dev->dev;
 	acpi_use_parent_companion(&priv->adapter.dev);
 	priv->adapter.retries = 3;
+	mutex_init(&priv->acpi_lock);
 
 	priv->pci_dev = dev;
 	priv->features = id->driver_data;
-- 
2.53.0


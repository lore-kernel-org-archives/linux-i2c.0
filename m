Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098792;
	b=S+zWX9qcuNPjTqoPFFuliUho97UTE63ICHv/lsCdkaR4fLvYuiQHBsRX1H+/t38MQMQC
	 jRLA7yZ17j9qcwNZxmdOv4EjCFZxC2JWKo55aMScUckHm9ytWoW5Fz2uuwR6NVFevnMAe
	 GyJ4oMIBIp7ffQdmdzI/UL74i9npan5f9w4crsYOlmfjhvE+CBqgaBOiYdC2zsHSZCpSO
	 HB/u2OTBWU9D+AqRr968m/AThDX2156SzIpjdM4KQ3BoqF3h7dK/Ip11s32UFdAYwSlZe
	 1EtgkekNrsz6viqX1YV3rwsVxK4jyvUCNydBnTvR7myduXxx2tXjvHVKWvSg0D22V5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098792;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=8P9Uj6WkP9gTrQOhvS5In3IHrSdQLFFO/QDLraiTJ6Y=;
	b=RBwO4/20BjuaBv3SRUG/FC3+uAuEasC40NXdBWslSbTi9BEzm7HdZZ2AXYkHfyhjAlw/
	 xgF1rCp+m3H/9V7P2IZjKbCyp1e6xTyUve1pYHNa9LiX4OEM7a7gpU+1rKIINWQ2IVfLT
	 c2K8ajiAQ1B/vc8G1G/MjCpYKisLZLMAy99IuiMEreWS1QmA2+cN1zk8u3ENfAigy/96D
	 EfL/GLwWcg6UCqUM0izdTRACgauaftR8HLAmBPaoMTftpX/VqvCjEaGiv2ectCj5cazuE
	 mS5BkxxqN+St98U3ZntH8fkgITwQSHs4nTrfhb007j8vAOfar078fITcd19kxJ33HwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=iKsyc8x2;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF5606A334;
	Thu, 19 Nov 2026 14:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85AF5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=iKsyc8x2
Received: from abreu.molgen.mpg.de (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B2D5A4C2F3FFBE;
	Thu, 19 Nov 2026 15:32:31 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"fangzhong.zhou" <myth5@myth5.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Dell.Client.Kernel@dell.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: acpi: Limit DLL0945 100 kHz quirk to Dell Precision 5560 and XPS 15 9510
Date: Thu, 19 Nov 2026 15:32:16 +0100
Message-ID: <20261119143218.586632-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1795098752; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=8P9Uj6WkP9gTrQOhvS5In3IHrSdQLFFO/QDLraiTJ6Y=; 
	b=iKsyc8x254LdwPUEyvAmsaK/DyXj9YZ1r6LVjhm8HW889bQYl6o/CfDxuyxKznyEPuZ3aGy5BXhQ
	S7ErQguuWVWRZzhqql0myre/055dG1Uv/wk6sJ54El4tfwzPoNyHqkPLyYUxAdsF0SbZYKg5TgrnZq
	OSirMikb7Rj2XhxE9SSz7OqrdDb9C+5KoTxtcd+s35WZ1CjjOTI/AG/odcqjYqqlNjZdcDjfW9xIUB
	GwIntWy5zjrP12Qg8SuzoGBC4FZuqTzUzlPl69kv9hxeWV0XpRFCdlvtpixslymyiIVQNjniunQ7XU
	8YK8fawsMbg2sM7KqssUegWya2A2QdZA==

Commit 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
forces the I2C bus to 100 kHz for all devices with the ACPI ID DLL0945 to
work around a sluggish cursor on the Dell Precision 5560. But DLL0945 does
not identify a touchpad model. Dell uses it for touchpads from different
vendors:

    System                Touchpad
    Dell Precision 5560   ELAN 04F3:311C
    Dell XPS 15 9510      ELAN 04F3:311C (bugzilla #214597)
    Dell XPS 13 9310      Synaptics 06CB:CDE6

The ELAN touchpads are the ones known to need 100 kHz, but the Synaptics
touchpad of the Dell XPS 13 9310 is slowed down without need. Its DSDT
specifies 400 kHz, and Linux logs:

    i2c_designware i2c_designware.0: [Firmware Bug]: DSDT uses known not-working I2C bus speed 400000, forcing it to 100000

The touchpad scans every 7.1 ms (scan time field in the input report), and
i2c-hid reads wMaxInputLength (64 bytes) for each report. Tracing the I2C
transfers for 30 seconds of moving a finger on the touchpad shows:

                             100 kHz   400 kHz
    read time (median)        7.3 ms    2.5 ms
    bus busy                   87 %      36 %
    reports per second          111       140
    frames lost                18.6 %     0 %

At 100 kHz the host cannot keep up with the touchpad, and every fifth frame
is lost. At 400 kHz all frames arrive, and no sluggish cursor was noticed.

So, only apply the DLL0945 entry on the Dell Precision 5560 and XPS 15 9510
by pointing the entry's driver_data to a DMI table, which can be used to
restrict other entries in the same way.

Tested on the Dell XPS 13 9310.

- The `[Firmware Bug] … forcing it to 100000` line is gone from dmesg.
- Re-probed the touchpad’s I²C controller with debug output on, and it
  reports `Bus speed: Fast Mode (400 kHz)`. The touchpad came back up
  under hid-multitouch.

Fixes: 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214597
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Dell.Client.Kernel@dell.com
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    Based on andi/i2c/i2c-next (9c19b1c07854) with Mika Westerberg's
    "[PATCH v2] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz"
    <20261118073607.297350-1-mika.westerberg@linux.intel.com> applied, as
    both change the same table.

    https://lore.kernel.org/linux-i2c/20261118073607.297350-1-mika.westerberg@linux.intel.com/


    Claude Opus 5.5 (Claude Code) helped analyze the I2C traces, write the
    code and draft the commit message.

 drivers/i2c/i2c-core-acpi.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 64fdf8ffb5ffe..8feb3cb205fdd 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/list.h>
@@ -356,6 +357,31 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
 	{ }
 };
 
+/*
+ * Dell uses DLL0945 for touchpads from different vendors. The ELAN 04F3:311C
+ * touchpad of these systems needs 100 kHz, but for example the Synaptics
+ * 06CB:CDE6 touchpad of the Dell XPS 13 9310 works fine at 400 kHz.
+ */
+static const struct dmi_system_id i2c_acpi_dll0945_dmi_ids[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 5560"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9510"),
+		},
+	},
+	{ }
+};
+
+/*
+ * If driver_data is set, it points to a DMI table, and the entry only applies
+ * to the systems in that table.
+ */
 static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	/*
 	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
@@ -373,7 +399,10 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 */
 	{ .id = "ASUE140D" },
 	{ .id = "DELL0A86" },
-	{ .id = "DLL0945" },
+	{
+		.id = "DLL0945",
+		.driver_data = (kernel_ulong_t)i2c_acpi_dll0945_dmi_ids,
+	},
 	{ .id = "ELAN0678" },
 	{ .id = "ELAN06FA" },
 	{ .id = "ELAN1300" },
@@ -391,6 +420,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 {
 	struct i2c_acpi_lookup *lookup = data;
 	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	const struct acpi_device_id *id;
 
 	if (!adev || i2c_acpi_do_lookup(adev, lookup))
 		return AE_OK;
@@ -404,7 +434,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
 		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
 
-	if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) == 0)
+	id = acpi_match_acpi_device(i2c_acpi_force_100khz_device_ids, adev);
+	if (id && (!id->driver_data ||
+		   dmi_check_system((const struct dmi_system_id *)id->driver_data)))
 		lookup->force_speed = I2C_MAX_STANDARD_MODE_FREQ;
 
 	return AE_OK;
-- 
2.54.0


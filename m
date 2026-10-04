Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F12AE76;
	Sun,  4 Oct 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791111596; cv=none; b=omwt0kSauPhr5Auw+2j+8QGKWH01G17XWDENfFpO7kjeSDn2sbN2k8R/2XkwOqw5/GnR3NS0+2/SXoue4eEMzvrXbg1b8yd4aqPXric3bltQrtyHzr+gNqJ8MOd17ySkT0RLFW2VX3LI+svnk2Q7Dtb+uK5DBtfW1G1tzWlMFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791111596; c=relaxed/simple;
	bh=fd5fXcAhQjDuGGewLwJnHv0q+1PFlCLfA2n3JN8ylNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BgIIzFTgIo96PGgE4m5YX/ZI1l+XMtKFkkqpbVdvnBldo8uOnmgdkd1vWFausQ+7uhoE77t7VWAwrmYg1ksDmKwL4NmXz/NdCGRjinPcLkU90ku915ev3QzFF0ivM/CHvm0CQ2HfMedMO14IMEsQD8M4tVphV8CKJkAVUamGbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOn2eqas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOn2eqas"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47915C2BCB9;
	Sun,  4 Oct 2026 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791111596;
	bh=fd5fXcAhQjDuGGewLwJnHv0q+1PFlCLfA2n3JN8ylNo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=YOn2eqasvXtNVoAwkuF0L57q6f+DNxrEVUGVsJzrNe2w4vCkjzJG/ajnnGq3INH+J
	 sYNtkzmYMOUvHjDtLuq2jNMeDrBBLaa4xjcj5ASIlF8dRaGLEaAmUQ4VBAHIW3CFkl
	 ChbXBGn11ydqzxlIR+wq+/oUE/dhMSQ4/xg7lnqt2JdKugIvsmU1KtLrFtmcFVW0L/
	 AV+0tnIzyuRQu9O9TpiVjPSD2KjLgDfPC+ChpxeVNbq6oCmhszJUyiZRtmNQCVJqqi
	 iH4soxc6JPnEyYSIcGMaVx2m71DgTpPUk0RZe955jzpbNtPoMWh3RGCEjTTiXj+srj
	 paXz1GVajPE5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170D2CA5FE6;
	Sun,  4 Oct 2026 10:59:56 +0000 (UTC)
From: Harinn via B4 Relay <devnull+prinn.dev.pm.me@kernel.org>
Date: Sun, 04 Oct 2026 17:59:53 +0700
Subject: [PATCH] i2c: acpi: Force ASUE140D touchpads to 100 kHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-i2c-acpi-asue140d-100khz-v1-1-cc2dbad00470@pm.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqDMAyF4VeRXC/QlkxhryJedDHVbOCkmWNMf
 PdVvfwOnH8Fk6xicKtWyPJR09dU4C8V8BinQVD7Yggu1N45Qg2MkWfFaIt4cj2W+Tn+kKipSTi
 lJlyh3OcsSb9Huu1O23J/CL/3HmzbH8l2jN98AAAA
X-Change-ID: 20261004-i2c-acpi-asue140d-100khz-44764ecff725
To: Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <westeri@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Harinn <prinn.dev@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791111594; l=1034;
 i=prinn.dev@pm.me; s=20261004; h=from:subject:message-id;
 bh=CuXYtEQhbQqdDDViBlDQYIFq8WwTJxIz9o0H7TCHD1M=;
 b=adT3U/tce9xAsjL3NVTi1vLNYJ4orkdv3gjXD70QK0+cucyBy8YyVOuHoVzPS/zEjAArKHG9m
 ZudNy/K2OAgCiMfhUcIy1nAWBhJXz0YMKT6tLkY/teQpF9wf2gNe/5E
X-Developer-Key: i=prinn.dev@pm.me; a=ed25519;
 pk=3q9t6SnPdJf3aRWfM5pwBvkSsRbrWSjKlcZ7e9U+UZU=
X-Endpoint-Received: by B4 Relay for prinn.dev@pm.me/20261004 with
 auth_id=1108
X-Original-From: Harinn <prinn.dev@pm.me>
Reply-To: prinn.dev@pm.me

From: Harinn <prinn.dev@pm.me>

The ASUE140D touchpad on the ASUS Zenbook UX3404VC (BIOS UX3404VC.303)
starts lagging shortly after boot when the bus runs at the 400 kHz the
DSDT asks for, and only recovers after rebinding i2c-hid. Forcing
100 kHz fixes it.

Signed-off-by: Harinn <prinn.dev@pm.me>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd50186e..e5b27375af31 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 * the device works without issues on Windows at what is expected to be
 	 * a 400KHz frequency. The root cause of the issue is not known.
 	 */
+	{ "ASUE140D", 0 },
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },

---
base-commit: 6addb4f385570ebc11c4eb499a4f1c149f313e84
change-id: 20261004-i2c-acpi-asue140d-100khz-44764ecff725

Best regards,
--  
Harinn <prinn.dev@pm.me>



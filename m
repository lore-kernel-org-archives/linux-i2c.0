Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99A21CFE0;
	Sun, 24 May 2026 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779610079; cv=none; b=bO9w9xeiajR4A98XpjC6QFoWDrz9z0jPMcNaIQL7g4yX0iTraReaGOl8Qs3rm3xTl9kqZW1d/GWJwPVMlMQFm2E4GnWXftKnsZYm1PpvDGYtx2LN5XB6aaiDSMia/Hop5HVK0B/iN8u7VglpkeLpqzbLoiuxNUtjY/eo/LaeFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779610079; c=relaxed/simple;
	bh=9siUbjBGjkYz/vb+AEwh+rBA/PDo3PLkuThvpwu1FZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNlhaZuUCzeuKzlLUH8zWsozBbxJjBT0H3hXI441Xw3w309IOOR593Si/2ncDl4ycB3owSQw0+kVU7s70kXr+Kbp+XIZSj+y6R02uAPrv93N71Q9VA+pJibZm6eGQe9qOHE7v044xnZcgR5AHmyc2b4Jh2lmTMpCzO1lz0fOFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.speedport.ip (p5dc553b1.dip0.t-ipconnect.de [93.197.83.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8C4044C151324A;
	Sun, 24 May 2026 10:06:57 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: eeprom: at24: Make VCC supply description requirement optional
Date: Sun, 24 May 2026 10:05:33 +0200
Message-ID: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some platforms (e.g. IBM Power System S822LC (8335-GCA POWER8)) do not
describe the EEPROM’s VCC supply in firmware-provided device trees.
Using `devm_regulator_get()` on such systems falls back to a dummy
regulator with a kernel warning:

    at24 0-0051: supply vcc not found, using dummy regulator
    at24 0-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 0-0052: supply vcc not found, using dummy regulator
    at24 0-0052: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0053: supply vcc not found, using dummy regulator
    at24 0-0053: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0054: supply vcc not found, using dummy regulator
    at24 0-0054: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    […]
    at24 12-0050: supply vcc not found, using dummy regulator
    at24 12-0050: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 12-0051: supply vcc not found, using dummy regulator
    at24 12-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write

Switch to `devm_regulator_get_optional()` and treat -ENODEV as “no
supply described”. When `vcc_reg` is NULL, skip all
regulator_enable/disable calls; the hardware is assumed to be always
powered. Linux now logs:

    at24 0-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 0-0052: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0053: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0054: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    at24 0-0055: 256 byte 24c02 EEPROM, writable, 1 bytes/write
    […]
    at24 12-0050: 16384 byte 24c128 EEPROM, writable, 1 bytes/write
    at24 12-0051: 16384 byte 24c128 EEPROM, writable, 1 bytes/write

Assisted-by: Claude Sonnet 4.6
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/misc/eeprom/at24.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0200288d3a7a..7e1050f8759a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -699,9 +699,12 @@ static int at24_probe(struct i2c_client *client)
 	at24->offset_adj = at24_get_offset_adj(flags, byte_len);
 	at24->client_regmaps[0] = regmap;
 
-	at24->vcc_reg = devm_regulator_get(dev, "vcc");
-	if (IS_ERR(at24->vcc_reg))
-		return PTR_ERR(at24->vcc_reg);
+	at24->vcc_reg = devm_regulator_get_optional(dev, "vcc");
+	if (IS_ERR(at24->vcc_reg)) {
+		if (PTR_ERR(at24->vcc_reg) != -ENODEV)
+			return PTR_ERR(at24->vcc_reg);
+		at24->vcc_reg = NULL;
+	}
 
 	writable = !(flags & AT24_FLAG_READONLY);
 	if (writable) {
@@ -754,9 +757,12 @@ static int at24_probe(struct i2c_client *client)
 
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
-		err = regulator_enable(at24->vcc_reg);
-		if (err)
-			return dev_err_probe(dev, err, "Failed to enable vcc regulator\n");
+		if (at24->vcc_reg) {
+			err = regulator_enable(at24->vcc_reg);
+			if (err) {
+				return dev_err_probe(dev, err, "Failed to enable vcc regulator\n");
+			}
+		}
 
 		pm_runtime_set_active(dev);
 	}
@@ -771,7 +777,7 @@ static int at24_probe(struct i2c_client *client)
 		err = at24_read(at24, 0, &test_byte, 1);
 		if (err) {
 			pm_runtime_disable(dev);
-			if (!pm_runtime_status_suspended(dev))
+			if (!pm_runtime_status_suspended(dev) && at24->vcc_reg)
 				regulator_disable(at24->vcc_reg);
 			return -ENODEV;
 		}
@@ -808,7 +814,7 @@ static void at24_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	if (acpi_dev_state_d0(&client->dev)) {
-		if (!pm_runtime_status_suspended(&client->dev))
+		if (!pm_runtime_status_suspended(&client->dev) && at24->vcc_reg)
 			regulator_disable(at24->vcc_reg);
 		pm_runtime_set_suspended(&client->dev);
 	}
@@ -819,6 +825,8 @@ static int __maybe_unused at24_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct at24_data *at24 = i2c_get_clientdata(client);
 
+	if (!at24->vcc_reg)
+		return 0;
 	return regulator_disable(at24->vcc_reg);
 }
 
@@ -827,6 +835,8 @@ static int __maybe_unused at24_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct at24_data *at24 = i2c_get_clientdata(client);
 
+	if (!at24->vcc_reg)
+		return 0;
 	return regulator_enable(at24->vcc_reg);
 }
 
-- 
2.53.0


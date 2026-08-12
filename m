Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B345C716
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544256; cv=none; b=DhMZKF/wndDwiS2FhkMW8N7yPBvTdsSS1AZgFGmzQ3V8A+FfsLF4gJYECVvPSDk/Ipw3M8ddh0uYTp4sKqH6F0WTeHvHt2VXlcrXmuc5P7ocijPEWVkOBhUX3WFj8dQgj+CO4UiyMx/7Rd5TOaa4YYFPHrVP+sJEWm+vRWUe/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544256; c=relaxed/simple;
	bh=GfzBwg4ZHphT0HU4JIpIzgvGvublxLx3VU0uduAtHN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTA+s3O/wuzj0x6MR3wL42JVQKx1hV0Cmvo9ivjl4dmM650hF6crfCDiWofB+oCmPOuCCCKNp4hgmvB2TrqcRs3jbWkN+3ZfXWcpc4MlU5SrU1hn2Ho7+CwPpKuS0b0eHUjODCrvzB+TOc2zQhXN+L24n9I6cD+g1ddBMO3NilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9PEs6sS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9PEs6sS"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1167423a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786544252; x=1787149052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/70XqHwKtpkb8Nem1mvPAp3age5VnZSIpQXUrCBp0Sw=;
        b=J9PEs6sSN6TRv7rae6EJnMJV1fJFkMR5LYzm4yAseH7WWu7D6IEGn4UMhMFbnBnNEw
         3LD4Y5sRVjilCXbsYDSTG8bNqYf7R/2mp9h7FCTLFSehkAKqjPteDBJY+DDCPN/OkMPQ
         67DJ8HDWqbdEFE+flPmJHuFFa5V1nXHtqGD8KSfx4vzZ2+Y9nI2bMbjG97XoKZ+u7KIT
         dhHZsIrfYfHSvcAOYJg+Zkga6+y4BYRTZXvoamsqw7DRc/l/lOFl9cq59v05q9OmMlxi
         O71c3KI97tJsjpKj8L5aXBb1CQORjUjGjCzcoeLecuw4nAaCAhCjzvtajUCLEAZeImmm
         0SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544252; x=1787149052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/70XqHwKtpkb8Nem1mvPAp3age5VnZSIpQXUrCBp0Sw=;
        b=LQ3NWFrlFBfnAWBZl2JOMWH57USnx2inqIx6UhGP14SgOrlQ5tPt0RDGwkI0SuPnFX
         jJf95yt1C/SjL/kUekZBkQcV7Z2MZcEbcuwrv0bzW4JpczyecJK7dSZIw3KHfh7WwVBZ
         P7i9rXKrionceI4F3qlIAZ98p3U7kL70qoiuwKAMDagH/LpZwKdE1mjnM0byBx/9n+FN
         jzlHgv5f3Ij2Ndvd2JZXbiu2V+jbVaurxU8mCY5NV+/PysvQqKJtdoPAsq6UHeIvGZbH
         grURTfSWr9OtKVuyoHFkhU4m1QHyk+tLnkwxYQxZZlX09jAG1rMomwuU0WEkGNEa2FeD
         VUJA==
X-Forwarded-Encrypted: i=1; AHgh+RrUTWPdy/1gTe6DKomXYMzjwOLcT86/yev1YDZX5/NU4A1gfvh5kjOfb7BRNbQ05yci/GOCqEalSds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxg/ECgM2fhZMaHKv2N0rsyN8diiZcsm3nYU4G9WZBORQN3Dek
	/lzJ5px8QAvJYU11n3My86+hJoG3cG+0XD1r7J3eAcBPE8qjIs4rcYxM
X-Gm-Gg: AR+sD134VdA62yl9fZjSvaQ1z+y+LBOhhAByKa13zoi3IjC7oTbeBwSSWDGGGY07SpT
	Be0yQNjegTHt3mCJmQL6xTUScRLayIaW2VZngK9YAzXOzv6oqpG1AaoIddl6aM9QvNVEitpl2ty
	tZtLtVJbukeRVz4zVrdxa0CN/OEDIYk2oRKjJz/W6abCcLho9c3zMwaXUZbNyMwPdHHENN1Ur3g
	TPvJAcRSnS0a6ws3/BFcx+UBNkTcIHtEpcWUr9EVJ+ZBVGRwHho04YHDwb5arm006bu3KD9Kgxw
	RF5g++XIlUAK1jMVWAA1vt5Tk1LQyOBXi5IQIwTlPq5ByTouKbVq/gGDflDiTIIp1sQkjTWZqep
	eqBUI5kl4hIgzw+6cTdmqoVY8bRKqc0dTPk7dpWotHZuxczmGSdbR9qWKPvP9vIybt/yPVm/3/i
	O2IgQmioEZ1KKeIB5O3cpE33LYfjHhgg/eZwTAD6aLbBI2QaZJWIgmCXlRRXszf9SGGuCiQL6Kw
	PxZrrqLgnf9w8RLkOsG406TSDEdApkGx2PKlnKXSHslp3hGYoP3vrWYKaDK
X-Received: by 2002:a17:90b:3802:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-393014f2d24mr5947349a91.15.1786544251973;
        Wed, 12 Aug 2026 07:17:31 -0700 (PDT)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf361d57asm11963071eec.6.2026.08.12.07.17.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 07:17:30 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nam Tran <trannamatk@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v4 5/5] ptp: ocp: Add Time Card V9 I2C peripheral topology
Date: Wed, 12 Aug 2026 07:17:15 -0700
Message-ID: <1db6580bc69f73f7b0273b0444484b1f391c8616.1786543681.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1786543681.git.ahmadexp@gmail.com>
References: <cover.1786543681.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Time Card V9 places a BME280 at 0x76, a BNO055 at 0x29, and an
IS32FL3207 at 0x37 on PCA9546 channel 1.

Describe GNSS1 and GNSS2 as RGB LEDs on outputs 0 through 5 and SMA1
through SMA4 on outputs 6 through 17. The board uses a 4.7 kohm RISET
resistor, sequential red, green, and blue output wiring, and an 8100 uA
per-output limit.

Select this profile only for the exact fixed-width EEPROM ID
"TIMECARD-V9". Earlier revisions expose the same I2C devices with
different LED routing, so probing cannot distinguish them safely. Leave
erased, malformed, and unknown board IDs unconfigured.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 73 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index f2c2979daaf1..a843198796ab 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -353,7 +353,7 @@ struct ptp_ocp_serial_port {
 
 #define OCP_I2C_MUX_CHANNELS		4
 #define OCP_I2C_MAX_SENSOR_COUNT	5
-#define OCP_I2C_MAX_LED_COUNT		5
+#define OCP_I2C_MAX_LED_COUNT		6
 #define OCP_I2C_MAX_LED_COMPONENT_COUNT	(3 * OCP_I2C_MAX_LED_COUNT)
 #define OCP_I2C_MUX_NAME_LEN		32
 #define OCP_I2C_MUX_COMPATIBLE		"nxp,pca9546"
@@ -613,9 +613,61 @@ static const struct ptp_ocp_led ptp_ocp_r4006_leds[] = {
 	},
 };
 
+static const struct ptp_ocp_i2c_device ptp_ocp_v9_sensors[] = {
+	{ "pressure@76", "bosch,bme280", "bme280", 1, 0x76 },
+	{ "imu@29", "bosch,bno055", "bno055", 1, 0x29 },
+};
+
+static const struct ptp_ocp_led ptp_ocp_v9_leds[] = {
+	{
+		.node_name = "multi-led@0",
+		.function = LED_FUNCTION_STATUS,
+		.function_enumerator = 1,
+		.has_function_enumerator = true,
+		.channel = { 0, 1, 2 },
+	},
+	{
+		.node_name = "multi-led@3",
+		.function = LED_FUNCTION_STATUS,
+		.function_enumerator = 2,
+		.has_function_enumerator = true,
+		.channel = { 3, 4, 5 },
+	},
+	{
+		.node_name = "multi-led@6",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 1,
+		.has_function_enumerator = true,
+		.channel = { 6, 7, 8 },
+	},
+	{
+		.node_name = "multi-led@9",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 2,
+		.has_function_enumerator = true,
+		.channel = { 9, 10, 11 },
+	},
+	{
+		.node_name = "multi-led@c",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 3,
+		.has_function_enumerator = true,
+		.channel = { 12, 13, 14 },
+	},
+	{
+		.node_name = "multi-led@f",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 4,
+		.has_function_enumerator = true,
+		.channel = { 15, 16, 17 },
+	},
+};
+
 static_assert(ARRAY_SIZE(ptp_ocp_r4006_sensors) <=
 	      OCP_I2C_MAX_SENSOR_COUNT);
 static_assert(ARRAY_SIZE(ptp_ocp_r4006_leds) <= OCP_I2C_MAX_LED_COUNT);
+static_assert(ARRAY_SIZE(ptp_ocp_v9_sensors) <= OCP_I2C_MAX_SENSOR_COUNT);
+static_assert(ARRAY_SIZE(ptp_ocp_v9_leds) <= OCP_I2C_MAX_LED_COUNT);
 
 static const struct ptp_ocp_i2c_profile ptp_ocp_r4006_profile = {
 	.name = "r4006",
@@ -630,6 +682,19 @@ static const struct ptp_ocp_i2c_profile ptp_ocp_r4006_profile = {
 	.led_max_microamp = 8150,
 };
 
+static const struct ptp_ocp_i2c_profile ptp_ocp_v9_profile = {
+	.name = "v9",
+	.sensors = ptp_ocp_v9_sensors,
+	.sensor_count = ARRAY_SIZE(ptp_ocp_v9_sensors),
+	.leds = ptp_ocp_v9_leds,
+	.led_count = ARRAY_SIZE(ptp_ocp_v9_leds),
+	.led_node_name = "led-controller@37",
+	.led_mux_channel = 1,
+	.led_address = 0x37,
+	.led_riset_ohms = 4700,
+	.led_max_microamp = 8100,
+};
+
 #define bp_assign_entry(bp, res, val) ({				\
 	uintptr_t addr = (uintptr_t)(bp) + (res)->bp_offset;		\
 	*(typeof(val) *)addr = val;					\
@@ -2230,6 +2295,7 @@ static const struct ptp_ocp_i2c_profile *
 ptp_ocp_i2c_select_profile(struct ptp_ocp *bp)
 {
 	static const char r4006_id[] = "R4006";
+	static const char v9_id[] = "TIMECARD-V9";
 	size_t board_id_len;
 
 	if (!ptp_ocp_has_eeprom_data(bp))
@@ -2242,6 +2308,11 @@ ptp_ocp_i2c_select_profile(struct ptp_ocp *bp)
 	    !memcmp(bp->board_id, r4006_id, sizeof(r4006_id) - 1))
 		return &ptp_ocp_r4006_profile;
 
+	/* Older revisions share V9's I2C devices but not its LED wiring. */
+	if (board_id_len == sizeof(v9_id) - 1 &&
+	    !memcmp(bp->board_id, v9_id, sizeof(v9_id) - 1))
+		return &ptp_ocp_v9_profile;
+
 	return NULL;
 }
 
-- 
2.50.1 (Apple Git-155)


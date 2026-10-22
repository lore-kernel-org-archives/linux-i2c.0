Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627216;
	b=5BJVx36qDEArLznWhaspdGWCWGKzoE7bxSuAgyKaHuV6fZnxi/ha9GI3EDuybgMqVRig
	 R4TVuoznXASErOwugh1S7rEwKgTQSKOPJh2NhPuFpgzEn3bgvcb1WZh8NH/Pk0Fazn3jp
	 K0aj2mRcavbiNAiqg1kZZpCvjUGOYDHhxI+z2qpIeMDM3aGKGAA5eamGnY/IzvqMbDgR7
	 ZKMNwzdB8LQ4UhKoVL97tGMGSR8WCPEDcSMr/+xfPmMEs1uEeZL8KcXuIOLmPlgocJoJh
	 fm2DXNovcUGxDNANIIFqEe2/YtpA0TjOGW4oGBIjSgg1sz+WVdJPSFbUEbn6GZmNAAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=YPuKNwql1HIbNGqoX33bMzSynPjwm2jO6JjQ4c2NRG0=;
	b=lGUgIMECAoLATNgmKBo2tXJ6Hp9jmOTd2B+bH5DtJ2tSoHBWoFK37gF3qRviQYeS/u6j
	 Zxntchdnrwc/H8n/sDBW1ZNdSa89ID7hLubwLh0b351CLrbKT4OVdqWZc3M6ztGkwNnIQ
	 WeK1tcTGew7WlUtNIQIwSwWC5cgRvvqgAyn2jT0pEdtBBzRyIGYazQeZ+Yx6u3kT6xHd8
	 CXd+5f7ircCnWFzhkvN5QAAuNn6iF3wCHwWWXSbD5BLF5Q335T1AFcSfrwfnxEBqdp4Er
	 1SHMupCIAN/UGXj4COakaIhghiRAd4VIJD5+p9U+uqe/8wHZvWpDhpdGvizK69Bt87g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SByisiU6;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ACE606A325
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 00:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01ACE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SByisiU6
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-702dedeb70dso772449eaf.1
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792627215; x=1793232015; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YPuKNwql1HIbNGqoX33bMzSynPjwm2jO6JjQ4c2NRG0=;
        b=SByisiU6fJXNb0cLpxl09Fm0k75RSzbkJ1LipdlzldJm2OfFf5NptDDfAGgYx44eVi
         /RdV4DDervYxrUvnq4RYVhwKSxhXo9CU7eq2d2/sKCeizfqzCJmhT9xJb/BRxIVDxsvO
         3ss+kBYwTLCV3FBcUHpjeUkO8cXcrRCAd7xEbgmoZEloRaWYYcigZNlc5eyIwYGXGL49
         4gxLUKhYDe5qr1oVl5M4CfYbympkunrl1OVi7/ViSk+gXvB5kGoaikAxTZ/ZHLMdAee3
         HwPoBjW6KqsWQaDgxHgO0UIGzNnSBEbhDU0736Edyaas5oW3fUAIlZUslQmuGFrYM1yZ
         PvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627215; x=1793232015;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YPuKNwql1HIbNGqoX33bMzSynPjwm2jO6JjQ4c2NRG0=;
        b=13fLIdckqsHVHFoagKJv3K/gqtaj/47PwJ9z+gf61YXbFOtxdVgWi18UCdLQ0ERXyk
         bMpzEj6UQVMg9XSWfkXfyEl1QxN8BBh8E/D2dRnSKVWrtz2K9XwjM/tKQlImKOeYirQM
         +jWrE6J7jU0JmyyhLK9kf9rWPUJGFm5+i/IFe4xrhuXkEW1tzZYbnrKgWuAFl9kQuMEB
         6FGNQK6JrJPvCMPmBkJ2XotzQkx8wAlfn9b42Wa+bUf1iNbQDsQ6vBrZeckzFLauMNuO
         r6epX4ksL+rem/cb8h8Wi/ZkqFDpXxlC4lTl1Vma6SFgZHwaceRW5u5scb+xzO6coQgT
         EhUw==
X-Gm-Message-State: AFq9FYJys+vjoGk550262zGYtw5Fa0qEjyMfYGg3Ay2TY5STksRYZNsL
	3aJubs6e49EyIYavq9g0oDCOynhUmeyPZNzT3reWnN4IceQ4BWRGGIk+
X-Gm-Gg: AYBFou1EmDNdzdBOvx5idgjlGA2/pBO+k02yE9Pnm8Zk3s4Ya8LGBSDrderjRHVIUU4
	+tq51BcyhrNiYy/S6iW5Hg20xQpQ63pnIq+WMEWWe7mdxjD3j0uf44soWMk++4DiQUcuJ9sf7n+
	2wF+NADRKdczmr05kW+RPlsfRLN2gNtAI09B/3gp3Lc68xo6OtosXbe0cqk5oW0bH78eEwhs7Ah
	vkpHvbrVvnyPM0kmxSH9dH4hzQX6FMlrZiAR3OawiaWQTcKqRXJY8IlaxSuCM2r9IcLEaR7cXoh
	QudfqWVHlPfjs2QxPVNdkhUrZ2vtvc++/4AJkIGHeVyOiUONZAZfVNDPie5WmtXFQv1K3gp1p6E
	Nigk7jNOXzAnqI9Zu/NQ+eAbhrNRObF+MSkK+D3VsOA0Urh0cspxUWxtMc6gDk7Oda+zGZyTYMW
	nx9nmIZlL65/77klO329YyNGL3aSAMQ7hrlsh5n5i+O+dgn0gpmEpxG3d1RJbXcRUMQu360ZD4o
	XXh29T3u5Bfut42x73d7x96KqnOMESe+WXLWoPztQDrWNuzzt4Pi1LV+s73c28MIFwMVJDl0D/A
	dDGumM9auaKn2bgr2z27YznUyf96Zseg066gT9eWqGfQibtnm0NZDs4VjpH7ZrGZxE65Nt/7W7x
	fywMlIJALKYDMAW+hyMm4TMXNM3Nrq8eCMOIrfTGz0CtdX3cGROzN4oZ3ehunt9Tn546BYeVx7T
	jsDJBA/ZJ1Jcxxt97Dx4vCPYYh
X-Received: by 2002:a05:6820:c87:b0:6d2:a9c5:ec7a with SMTP id 006d021491bc7-7093fdbccf6mr2829070eaf.34.1792627214681;
        Wed, 21 Oct 2026 17:00:14 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbddc7100sm3710064a34.24.2026.10.21.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:00:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 21 Oct 2026 18:00:12 -0600
Subject: [PATCH] i2c: mv64xxx: protect transfers against input clock
 changes
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-submit-i2c-mv64xxx-clock-v1-v1-1-959ea2aa3f90@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PwW6EMAxEfwXl3KiJISHlV6o9OI4paQtsCYuQV
 vvvNUuPvVgae+ZpfFeFl8xFddVdLbzlkudJhH2pFA04fbDOSbQCA94asLrc4phXnYH0uPlm33d
 N3zN96c1qhyaFFiCC9UoI14X7vD/p75dTS/yTaT2QhyNiYR0XnGg4VmJY+Of1P/gfT843Kbme0
 DNP8yiVuqphgto7MiFxbXzvwLujUO2Rexc8ROQUQ3qicKVBfusq7qltWpnovKmRjYuI9i0EkCy
 nNjkSDU5dHo9fnKmpbC8BAAA=
X-Change-ID: 20261021-submit-i2c-mv64xxx-clock-v1-5a0d8722b216
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The controller's timing divisor is calculated once at probe. On Allwinner
H616 the input is APB2, which also supplies the UARTs. Changing that shared
clock leaves I2C using its old divisor and can change SCL during an active
transfer.

Register an input clock notifier for DT-configured controllers. Calculate
the prospective timing without modifying the current divisor, then try to
acquire the adapter bus lock. A running transfer vetoes the change; an idle
adapter keeps the lock through POST or ABORT so a new transfer cannot start
between validation and the actual rate change. Do not wait for the bus lock
under the clock framework lock: a transfer may be waiting there in runtime
resume. Also reject a change while START or STOP is still pending in an
active controller, since software completion can precede the physical STOP.

Publish the new packed divisor on POST and install it before the next
transfer. Runtime resume reads the same cached word, so a suspended
controller needs no register access from the notifier. Preserve the old
timing on ABORT. Drain notifications before removing the adapter, whose
device storage is cleared by i2c_del_adapter().

Keep platform-data controllers on their supplied fixed divisors because
they do not provide the requested bus frequency needed for recalculation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Based on i2c/i2c-next with the posted clock-abort fix [0]. The notifier
holds the adapter lock between PRE_RATE_CHANGE and POST_RATE_CHANGE or
ABORT_RATE_CHANGE, so an aborted parent change must deliver its matching
ABORT notification.

[0] https://lore.kernel.org/r/20261021-submit-clk-parent-abort-v1-v1-1-2936181822fc@gmail.com
---
 drivers/i2c/busses/i2c-mv64xxx.c | 137 +++++++++++++++++++++++++++++++++------
 1 file changed, 117 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1acba628e16c..e34998b74fdd 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <linux/notifier.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 
@@ -132,8 +133,12 @@ struct mv64xxx_i2c_data {
 	u32			send_stop;
 	u32			block;
 	int			rc;
-	u32			freq_m;
-	u32			freq_n;
+	u32			baud_div;
+	u32			bus_freq;
+	u32			new_baud_div;
+	struct notifier_block	clk_notifier;
+	bool			clk_change_ready;
+	bool			clk_change_locked;
 	struct clk              *clk;
 	struct clk              *reg_clk;
 	wait_queue_head_t	waitq;
@@ -212,7 +217,7 @@ mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
 	}
 
 	writel(0, drv_data->reg_base + drv_data->reg_offsets.soft_reset);
-	writel(MV64XXX_I2C_BAUD_DIV_M(drv_data->freq_m) | MV64XXX_I2C_BAUD_DIV_N(drv_data->freq_n),
+	writel(READ_ONCE(drv_data->baud_div),
 		drv_data->reg_base + drv_data->reg_offsets.clock);
 	writel(0, drv_data->reg_base + drv_data->reg_offsets.addr);
 	writel(0, drv_data->reg_base + drv_data->reg_offsets.ext_addr);
@@ -751,6 +756,10 @@ mv64xxx_i2c_xfer_core(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (rc)
 		return rc;
 
+	/* The adapter lock excludes rate changes until the transfer finishes. */
+	writel(READ_ONCE(drv_data->baud_div),
+		drv_data->reg_base + drv_data->reg_offsets.clock);
+
 	BUG_ON(drv_data->msgs != NULL);
 	drv_data->msgs = msgs;
 	drv_data->num_msgs = num;
@@ -813,9 +822,9 @@ static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
 
 #ifdef CONFIG_OF
-static int
+static unsigned long
 mv64xxx_calc_freq(struct mv64xxx_i2c_data *drv_data,
-		  const int tclk, const int n, const int m)
+		  unsigned long tclk, const int n, const int m)
 {
 	if (drv_data->clk_n_base_0)
 		return tclk / (10 * (m + 1) * (1 << n));
@@ -825,26 +834,96 @@ mv64xxx_calc_freq(struct mv64xxx_i2c_data *drv_data,
 
 static bool
 mv64xxx_find_baud_factors(struct mv64xxx_i2c_data *drv_data,
-			  const u32 req_freq, const u32 tclk)
+			  u32 req_freq, unsigned long tclk, u32 *baud_div)
 {
-	int freq, delta, best_delta = INT_MAX;
+	unsigned long freq, best_freq = 0;
 	int m, n;
 
 	for (n = 0; n <= 7; n++)
 		for (m = 0; m <= 15; m++) {
 			freq = mv64xxx_calc_freq(drv_data, tclk, n, m);
-			delta = req_freq - freq;
-			if (delta >= 0 && delta < best_delta) {
-				drv_data->freq_m = m;
-				drv_data->freq_n = n;
-				best_delta = delta;
+			if (freq <= req_freq && freq > best_freq) {
+				*baud_div = MV64XXX_I2C_BAUD_DIV_M(m) |
+					    MV64XXX_I2C_BAUD_DIV_N(n);
+				best_freq = freq;
 			}
-			if (best_delta == 0)
+			if (best_freq && best_freq == req_freq)
 				return true;
 		}
-	if (best_delta == INT_MAX)
-		return false;
-	return true;
+	return best_freq != 0;
+}
+
+static int mv64xxx_i2c_clk_notifier(struct notifier_block *nb,
+				  unsigned long event, void *arg)
+{
+	struct mv64xxx_i2c_data *drv_data =
+		container_of(nb, struct mv64xxx_i2c_data, clk_notifier);
+	struct clk_notifier_data *ndata = arg;
+	struct i2c_adapter *adap = &drv_data->adapter;
+	int active;
+	u32 control;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		/* The adapter's bus lock is not available during registration. */
+		if (!smp_load_acquire(&drv_data->clk_change_ready))
+			return NOTIFY_BAD;
+		if (!mv64xxx_find_baud_factors(drv_data, drv_data->bus_freq,
+					     ndata->new_rate, &drv_data->new_baud_div))
+			return NOTIFY_BAD;
+		/* A transfer can be waiting for the clock framework in runtime PM. */
+		if (!i2c_trylock_bus(adap, I2C_LOCK_ROOT_ADAPTER))
+			return NOTIFY_BAD;
+
+		/* Software completion can precede the STOP reaching the wire. */
+		active = pm_runtime_get_if_active(adap->dev.parent);
+		if (active > 0 || !IS_ENABLED(CONFIG_PM)) {
+			control = readl(drv_data->reg_base + drv_data->reg_offsets.control);
+			if (active > 0)
+				pm_runtime_put(adap->dev.parent);
+			if (control & (MV64XXX_I2C_REG_CONTROL_START |
+				       MV64XXX_I2C_REG_CONTROL_STOP)) {
+				i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+				return NOTIFY_BAD;
+			}
+		}
+		drv_data->clk_change_locked = true;
+		return NOTIFY_OK;
+	case POST_RATE_CHANGE:
+		/* Runtime resume can read this without holding the adapter lock. */
+		if (drv_data->clk_change_locked)
+			WRITE_ONCE(drv_data->baud_div, drv_data->new_baud_div);
+		fallthrough;
+	case ABORT_RATE_CHANGE:
+		if (drv_data->clk_change_locked) {
+			drv_data->clk_change_locked = false;
+			i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+		}
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static int mv64xxx_i2c_init_clk_notifier(struct mv64xxx_i2c_data *drv_data,
+				       struct device *dev)
+{
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK) || !drv_data->bus_freq)
+		return 0;
+
+	drv_data->clk_notifier.notifier_call = mv64xxx_i2c_clk_notifier;
+	ret = devm_clk_notifier_register(dev, drv_data->clk, &drv_data->clk_notifier);
+	if (ret)
+		return ret;
+
+	/* A rate change is now vetoed until the adapter is registered. */
+	if (!mv64xxx_find_baud_factors(drv_data, drv_data->bus_freq,
+				     clk_get_rate(drv_data->clk), &drv_data->baud_div))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int
@@ -853,7 +932,8 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 {
 	const struct mv64xxx_i2c_regs *data;
 	struct device_node *np = dev->of_node;
-	u32 bus_freq, tclk;
+	unsigned long tclk;
+	u32 bus_freq;
 	int rc = 0;
 
 	/* CLK is mandatory when using DT to describe the i2c bus. We
@@ -873,7 +953,8 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
 		drv_data->clk_n_base_0 = true;
 
-	if (!mv64xxx_find_baud_factors(drv_data, bus_freq, tclk)) {
+	drv_data->bus_freq = bus_freq;
+	if (!mv64xxx_find_baud_factors(drv_data, bus_freq, tclk, &drv_data->baud_div)) {
 		rc = -EINVAL;
 		goto out;
 	}
@@ -920,6 +1001,12 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	return rc;
 }
 #else /* CONFIG_OF */
+static int mv64xxx_i2c_init_clk_notifier(struct mv64xxx_i2c_data *drv_data,
+				       struct device *dev)
+{
+	return 0;
+}
+
 static int
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		  struct device *dev)
@@ -1018,8 +1105,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		return drv_data->irq;
 
 	if (pdata) {
-		drv_data->freq_m = pdata->freq_m;
-		drv_data->freq_n = pdata->freq_n;
+		drv_data->baud_div = MV64XXX_I2C_BAUD_DIV_M(pdata->freq_m) |
+				     MV64XXX_I2C_BAUD_DIV_N(pdata->freq_n);
 		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
 		drv_data->offload_enabled = false;
 		memcpy(&drv_data->reg_offsets, &mv64xxx_i2c_regs_mv64xxx, sizeof(drv_data->reg_offsets));
@@ -1042,6 +1129,10 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	platform_set_drvdata(pd, drv_data);
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
+	rc = mv64xxx_i2c_init_clk_notifier(drv_data, &pd->dev);
+	if (rc)
+		return dev_err_probe(&pd->dev, rc, "Cannot monitor input clock changes\n");
+
 	pm_runtime_set_autosuspend_delay(&pd->dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(&pd->dev);
 	pm_runtime_enable(&pd->dev);
@@ -1064,6 +1155,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 		goto exit_free_irq;
 	}
 
+	/* Publish the initialized adapter, including its bus lock, to PRE. */
+	smp_store_release(&drv_data->clk_change_ready, true);
 	return 0;
 
 exit_free_irq:
@@ -1081,11 +1174,15 @@ mv64xxx_i2c_remove(struct platform_device *pd)
 {
 	struct mv64xxx_i2c_data		*drv_data = platform_get_drvdata(pd);
 
+	/* Drain notifications before i2c_del_adapter() clears adap->dev. */
+	clk_rate_exclusive_get(drv_data->clk);
+	WRITE_ONCE(drv_data->clk_change_ready, false);
 	i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
 	pm_runtime_disable(&pd->dev);
 	if (!pm_runtime_status_suspended(&pd->dev))
 		mv64xxx_i2c_runtime_suspend(&pd->dev);
+	clk_rate_exclusive_put(drv_data->clk);
 }
 
 static const struct dev_pm_ops mv64xxx_i2c_pm_ops = {

---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20261021-submit-i2c-mv64xxx-clock-v1-5a0d8722b216
prerequisite-patch-id: efc747efca5603ae05baa198820d8ed7d5caa125

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


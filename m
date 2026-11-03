Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680668;
	b=n2nrcb6fu0iG/j8XCL0mCuNp3iVdwg5owwHdsIiL5r/Dn5ZmNfsQb1hI5/1mHDtCVOQz
	 VWyqw8M8x0mmBLqzQ856sVVxmHcVdZsaWfCPiUTrtk7ESPCv2NOo4PSICuNtoxJ7/D1Gz
	 KEQy+Dk7j2/R7R9NCxF1Dx4xKgUyYbVIlZfOHq9TsBrJZfuVKrU9mvYvLD2PUfvnx0q7L
	 dyzSDRJN5X0rj51X8TB1hRKCVCqFFMJDIoN1H3ZxahZSg2kQo9U/V/LvdapPGFLS1Q2Jm
	 5k34MuyuC6pf+jXKxXf+Xf6uO2QekY3qGt7UJRhusei1MVUurwSRQA3wBvmj2Aqp8yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jo4WIJkk4OXbIMa6R8ro6SOGlPV/YpmrPtjJSBWYj4Y=;
	b=4Hb29A+blHoIWf2sKgMYcL2F4mPIYiqi3Woiv02KDPME3nriGed1rQcf7Zv03YlK4Fv3
	 zyIzHvPvM7RJGjwT7nQKjBG44frNw3X6a06WSPfdVh1DcDtfDVX+Cgi2dw0jFQ6ByFgVK
	 akvlxwytrnoGOridSDeWV7UBLVYE18hwy8nMFnP52rY5zNeVXXKnmUXv9hV7LwPdbfQ/W
	 IJlsyFdzTHdm7nNC2BCwm1sKt4b1rXBo0MmvqkmwnT9R4XjEWvS9AfZ63P4gNGoJWxwtc
	 d6BNmFCl2SelIqbolrWX3FjjlzOngYeqQ1go8Nnu/CFYfVvia9rWXVc+D0tW8w8QQFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AmbUkAfW;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526B606A336
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D526B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AmbUkAfW
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so139155a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680667; x=1794285467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jo4WIJkk4OXbIMa6R8ro6SOGlPV/YpmrPtjJSBWYj4Y=;
        b=AmbUkAfWH/aHll5wwtKyCf3h/YxREBZB4SoHP35ZJnJFg2nT0liZ5haulkB8ixoFwY
         GqkHeF8k6mClL4BJi0MfUiZe85cemQ8MSvQKiXUeqNeUd+HvoEtwr+c8aJIYGnIobh0A
         wyFpdUtZafSQLgGKUJTweqSIlcRfxbm+V5SJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680667; x=1794285467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jo4WIJkk4OXbIMa6R8ro6SOGlPV/YpmrPtjJSBWYj4Y=;
        b=EWxi8VH594Jd7jeWk8U7bbtmx6bPb91m2hn+ZIQeNm7NdSFX+l4KKDW71FoIbfllvg
         QqpP8Q8H9c0aeEw4st/OKkFOodVjS3qNUdulFaY8fCWgk5DzI9bDngUqGG+zbsbmgwsK
         dkcmaOevlS9gr+JzpD5GrJEEiFxW+wny7FBwNJytPo6zmWJ01eSbYOwJgkOOyKtpu8JS
         N96pp+5N+1EsHLk+Ct+wTwgcs276dwHGQp0/HJsj7KYtjOiuv+gG8kisoayBJPw8vQbt
         HgUkFHYn55hmCMTKCULNJLCPp1Kw798TMQQ6+Ql5mJORkszY3lpBT61aQCAoPec4w5ci
         G+Tw==
X-Forwarded-Encrypted: i=1; AKwUvBw8UMAMjAsN53qU21S3vnM3SUb8eqMOtwloOY8JZn7KMsxQSsVFk1oBiBozxrgM06j9fKYqeXgZGpw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QalID092rla54waaAl2vCp88fJzuWSHPbhXEIj4WBP0U423UX
	YxNFfvsAtJdv4hHWwx+zZ1L8LsamM4OkVucodCsUYT4jMm4CuxxvDFgVuErRxjr+aw==
X-Gm-Gg: AYBFou0zwcp6CMwhgTyC9yZAlQbQtZ6QuE7xbSYHJ8SApndCTVNhNgj9nqrn8mTh/85
	w9cLbGba30406EM3cFwmiZRM2QPqF/uCTkYQME3Yn5rhY5lHkpQv0tiulSzBTkjiVScEgfo5B9/
	lHmv6jns8UimwAqXaX+vjTQkG/VESpq9HsQ6ital0xPa3JaNDac8dACDzlLVBDCIBvaE4yjPzTZ
	pG/eJWktpDQ5z45mwjqyKAPn7Nn0z1HDmNJFKS7oOjy8FyzmEVQHSVmq6kxXaZ5C9Rm6v9ac4pm
	xb3wrpnt+KnWcqwYUOxHheg/d4ju8vrtlpcXOdgITQ1ASkqrFv/a61a8RT0Lm2EcA24cGN76ehN
	p2GnpYpASDCXh+ZZWX7097hxU3HHzQm/7RlGIV3uJ44DDPiUbksiVZChCZ37nn8jaPvpUat3wOb
	UDiiSa0/XzTVmqe4Kh2iLly0NijjTey7AF8zjpTBBpRlylUmCMMJWTgkovsqgzPS+sEyUKKHBmL
	DKi+eGr7Pbm/YLSkfWHi34ULmg2VLO531XF/qwcbC6iUP+oyVa92mJvCd3ui8I562MAX0t41Bqj
	3o8z4LHAcnbKCuTUX2hZbVZ6kFmme7mwpsTk9HQIoBtYLBeUbd6xVA+q3Yuf7O8qGWy5XeG+Ev5
	Z4sSfTOXY2wSIC4eMPl01d52mhFMxwr9yww==
X-Received: by 2002:a17:90a:d610:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3ae896d7b4fmr6163052a91.7.1793680667117;
        Mon, 02 Nov 2026 20:37:47 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:37:46 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/8] regulator: core: Add "enable and wait" functions
Date: Tue,  3 Nov 2026 12:37:25 +0800
Message-ID: <20261103043734.2179858-2-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In device power sequencing and initialization use cases, it is common
for the driver to enable the regulator and then wait for a certain
period of time to pass before continuing.

In cases where the regulator supply is always on, or has been turned on
or left on by another consumer, the driver could shorten the delay or
skip it altogether, provided that enough time has already passed since
the regulator was _actually_ turned on.

Tracking this requires support from the regulator core. Introduce a
"last turned on" timestamp field to the regulator device, and "enable
and wait" functions to the single and bulk regulator consumer APIs.
The existing "enable without wait" functions are then converted to
macros that expand to the new functions.

The timestamp is updated each time the regulator is actually turned on.
For regulators left on by hardware default or by firmware, the core will
set the timestamp if it detects it was left on and its supply (and their
supply, and so on) is on as well. This is unfortunately best effort
only. The core can only assume a dangling regulator (one without a
supply) has power. This also applies to the dummy regulator.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v6:
- Update function call in rust binding

Changes since v5:
- Correctly assign wait_us to all bulk consumers (Sashiko)
- Check _regulator_is_enabled() > 0 to check for enabled regulators
  (Sashiko)
- Lock regulator_dev on final _regulator_is_enabled() check in
  regulator_register() (Sashiko)
- Make it clear that _regulator_is_enabled_recursive() assumes that
  supplies have been resolved (local AI review)
- Consider supply's last_on timestamp for regulators that are already
  enabled or have no .is_enabled() ops (local AI review)

Changes since v4:
- Try to update last_on timestamp for regulators that were left on

Changes since v3:
- Added __private modified to regulator_bulk_data.wait_us field and
  switched to ACCESS_PRIVATE accessor for the field
- Moved wait outside regulator lock scope
- Moved "remaining" value assignment closer to conditional
- Fixed variable unit name in regulator_enable_and_wait() prototype

Changes since v2:
- New patch
---
 drivers/regulator/core.c           | 129 +++++++++++++++++++++++++----
 include/linux/regulator/consumer.h |  21 +++--
 include/linux/regulator/driver.h   |   2 +
 rust/helpers/regulator.c           |   5 +-
 rust/kernel/regulator.rs           |   2 +-
 5 files changed, 135 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 14422cfe80e2..071f9f8185f6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -99,7 +99,7 @@ struct regulator_event_work {
 	unsigned long event;
 };
 
-static int _regulator_enable(struct regulator *regulator);
+static int _regulator_enable(struct regulator *regulator, ktime_t *last_on);
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
 static int _regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags);
@@ -1677,7 +1677,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		    (rdev->constraints->always_on ||
 		     !regulator_is_enabled(rdev->supply))) {
 			ret = (is_locked
-			       ? _regulator_enable(rdev->supply)
+			       ? _regulator_enable(rdev->supply, NULL)
 			       : regulator_enable(rdev->supply));
 			if (ret < 0) {
 				_regulator_put(rdev->supply);
@@ -2188,6 +2188,45 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * _regulator_is_enabled_recursive - is the regulator output enabled all
+ *				     the way to the root supply
+ * @rdev: regulator device
+ *
+ * Only intended for checking regulators that have been left on by
+ * hardware default or firmware.
+ *
+ * Assumes supplies have been resolved. Must be called with dependent
+ * locks held.
+ *
+ * Return: Positive if the regulator output backing the source/client,
+ *	   and all of its upstream supplies, have requested that their
+ *	   respective device be enabled, zero if any of them hasn't,
+ *	   else a negative error number.
+ */
+static int _regulator_is_enabled_recursive(struct regulator_dev *rdev)
+{
+	int ret;
+
+	ret = _regulator_is_enabled(rdev);
+	if (ret <= 0)
+		return ret;
+
+	/*
+	 * If .last_on was set, then this rdev was either enabled through
+	 * _regulator_do_enable(), or had been checked before as the target
+	 * of regulator_resolve_supply().
+	 */
+	if (rdev->last_on)
+		return ret;
+
+	/* This is the root supply; we can only assume it actually has power */
+	if (!rdev->supply)
+		return ret;
+
+	return _regulator_is_enabled_recursive(rdev->supply->rdev);
+}
+
 static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
@@ -2373,6 +2412,14 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		}
 		rdev->constraints_pending = false;
 	}
+
+	/*
+	 * regulator was left on but not enabled with .always_on or .boot_on
+	 * constraints, and thus .last_on timestamp is still invalid.
+	 */
+	if (!rdev->last_on && _regulator_is_enabled_recursive(rdev) > 0)
+		rdev->last_on = ktime_get_boottime();
+
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	if (!do_final_setup)
@@ -3064,6 +3111,8 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		fsleep(delay);
 	}
 
+	rdev->last_on = ktime_get_boottime();
+
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
 	return 0;
@@ -3133,16 +3182,18 @@ static int _regulator_handle_consumer_disable(struct regulator *regulator)
 	return 0;
 }
 
-/* locks held by regulator_enable() */
-static int _regulator_enable(struct regulator *regulator)
+/* locks held by regulator_enable_and_wait() */
+static int _regulator_enable(struct regulator *regulator, ktime_t *last_on)
 {
 	struct regulator_dev *rdev = regulator->rdev;
+	ktime_t supply_last_on;
 	int ret;
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
+	supply_last_on = 0;
 	if (rdev->use_count == 0 && rdev->supply) {
-		ret = _regulator_enable(rdev->supply);
+		ret = _regulator_enable(rdev->supply, &supply_last_on);
 		if (ret < 0)
 			return ret;
 	}
@@ -3180,13 +3231,26 @@ static int _regulator_enable(struct regulator *regulator)
 		} else if (ret < 0) {
 			rdev_err(rdev, "is_enabled() failed: %pe\n", ERR_PTR(ret));
 			goto err_consumer_disable;
+		} else {
+			/*
+			 * Either the regulator was already enabled somehow, or this regulator
+			 * itself has no on/off control. Either way our timestamp cannot be
+			 * earlier than its supply's timestamp. supply_last_on == 0 if there
+			 * is no supply.
+			 */
+			if (rdev->last_on < supply_last_on)
+				rdev->last_on = supply_last_on;
+			if (!rdev->last_on)
+				rdev->last_on = ktime_get_boottime();
 		}
-		/* Fallthrough on positive return values - already enabled */
 	}
 
 	if (regulator->enable_count == 1)
 		rdev->use_count++;
 
+	if (last_on)
+		*last_on = rdev->last_on;
+
 	return 0;
 
 err_consumer_disable:
@@ -3200,31 +3264,49 @@ static int _regulator_enable(struct regulator *regulator)
 }
 
 /**
- * regulator_enable - enable regulator output
+ * regulator_enable_and_wait - enable regulator output and wait for time
+ *			       passed after regulator actually enabled
  * @regulator: regulator source
+ * @wait_us: time to wait after regulator actually turned on; 0 to not wait
  *
  * Request that the regulator be enabled with the regulator output at
  * the predefined voltage or current value.  Calls to regulator_enable()
  * must be balanced with calls to regulator_disable().
  *
+ * If wait_us is greater than zero, then check that wait_us has passed since
+ * the regulator is _actually_ enabled before returning.
+ *
  * NOTE: the output value can be set by other drivers, boot loader or may be
  * hardwired in the regulator.
  *
  * Return: 0 on success or a negative error number on failure.
  */
-int regulator_enable(struct regulator *regulator)
+int regulator_enable_and_wait(struct regulator *regulator, unsigned int wait_us)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	struct ww_acquire_ctx ww_ctx;
+	ktime_t last_on = 0;
 	int ret;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
-	ret = _regulator_enable(regulator);
+	ret = _regulator_enable(regulator, &last_on);
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
+	if (ret)
+		return ret;
+
+	if (wait_us) {
+		ktime_t end = ktime_add_us(last_on, wait_us);
+		s64 remaining;
+
+		remaining = ktime_us_delta(end, ktime_get_boottime());
+		if (remaining > 0)
+			fsleep(remaining);
+	}
+
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_enable);
+EXPORT_SYMBOL_GPL(regulator_enable_and_wait);
 
 static int _regulator_do_disable(struct regulator_dev *rdev)
 {
@@ -5394,30 +5476,38 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
 {
 	struct regulator_bulk_data *bulk = data;
 
-	bulk->ret = regulator_enable(bulk->consumer);
+	bulk->ret = regulator_enable_and_wait(bulk->consumer, ACCESS_PRIVATE(bulk, wait_us));
 }
 
 /**
- * regulator_bulk_enable - enable multiple regulator consumers
+ * regulator_bulk_enable_and_wait - enable multiple regulator consumers and
+ *				    wait for time passed after regulators are
+ *				    actually enabled
  *
  * @num_consumers: Number of consumers
  * @consumers:     Consumer data; clients are stored here.
+ * @wait_us: time to wait after regulators actually turned on; 0 to not wait
  *
  * This convenience API allows consumers to enable multiple regulator
  * clients in a single API call.  If any consumers cannot be enabled
  * then any others that were enabled will be disabled again prior to
  * return.
  *
+ * If wait_us is greater than zero, then check that wait_us has passed since
+ * the regulators are _actually_ enabled before returning.
+ *
  * Return: 0 on success or a negative error number on failure.
  */
-int regulator_bulk_enable(int num_consumers,
-			  struct regulator_bulk_data *consumers)
+int regulator_bulk_enable_and_wait(int num_consumers,
+				   struct regulator_bulk_data *consumers,
+				   unsigned int wait_us)
 {
 	ASYNC_DOMAIN_EXCLUSIVE(async_domain);
 	int i;
 	int ret = 0;
 
 	for (i = 0; i < num_consumers; i++) {
+		ACCESS_PRIVATE(&consumers[i], wait_us) = wait_us;
 		async_schedule_domain(regulator_bulk_enable_async,
 				      &consumers[i], &async_domain);
 	}
@@ -5445,7 +5535,7 @@ int regulator_bulk_enable(int num_consumers,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_bulk_enable);
+EXPORT_SYMBOL_GPL(regulator_bulk_enable_and_wait);
 
 /**
  * regulator_bulk_disable - disable multiple regulator consumers
@@ -6251,6 +6341,15 @@ regulator_register(struct device *dev,
 			goto del_cdev_and_bdev;
 	}
 
+	/*
+	 * If no supply was given, then the last_on timestamp could not have
+	 * been updated in regulator_resolve_supply(). Check it here.
+	 */
+	regulator_lock(rdev);
+	if (!rdev->supply_name && !rdev->last_on && _regulator_is_enabled(rdev) > 0)
+		rdev->last_on = ktime_get_boottime();
+	regulator_unlock(rdev);
+
 	rdev_init_debugfs(rdev);
 
 	/* try to resolve regulators coupling since a new one was registered */
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 56fe2693d9b2..0b83acc015d4 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -145,6 +145,7 @@ struct regulator_bulk_data {
 
 	/* private: Internal use */
 	int ret;
+	unsigned int __private wait_us;
 };
 
 #if defined(CONFIG_REGULATOR)
@@ -192,7 +193,7 @@ int devm_regulator_bulk_register_supply_alias(struct device *dev,
 					      int num_id);
 
 /* regulator output control and status */
-int __must_check regulator_enable(struct regulator *regulator);
+int __must_check regulator_enable_and_wait(struct regulator *regulator, unsigned int wait_us);
 int regulator_disable(struct regulator *regulator);
 int regulator_force_disable(struct regulator *regulator);
 int regulator_is_enabled(struct regulator *regulator);
@@ -209,8 +210,9 @@ int __must_check devm_regulator_bulk_get_const(
 	struct device *dev, int num_consumers,
 	const struct regulator_bulk_data *in_consumers,
 	struct regulator_bulk_data **out_consumers);
-int __must_check regulator_bulk_enable(int num_consumers,
-				       struct regulator_bulk_data *consumers);
+int __must_check regulator_bulk_enable_and_wait(int num_consumers,
+						struct regulator_bulk_data *consumers,
+						unsigned int wait_us);
 int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
 				   const char * const *id);
 int regulator_bulk_disable(int num_consumers,
@@ -410,7 +412,8 @@ static inline int devm_regulator_bulk_register_supply_alias(struct device *dev,
 	return 0;
 }
 
-static inline int regulator_enable(struct regulator *regulator)
+static inline int regulator_enable_and_wait(struct regulator *regulator,
+					    unsigned int wait_us)
 {
 	return 0;
 }
@@ -457,8 +460,9 @@ static inline int devm_regulator_bulk_get_const(
 	return 0;
 }
 
-static inline int regulator_bulk_enable(int num_consumers,
-					struct regulator_bulk_data *consumers)
+static inline int regulator_bulk_enable_and_wait(int num_consumers,
+						 struct regulator_bulk_data *consumers,
+						 unsigned int wait_us)
 {
 	return 0;
 }
@@ -676,6 +680,11 @@ regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 }
 #endif
 
+#define regulator_enable(regulator)	regulator_enable_and_wait(regulator, 0)
+
+#define regulator_bulk_enable(num_consumers, consumers)	\
+		regulator_bulk_enable_and_wait(num_consumers, consumers, 0)
+
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_REGULATOR)
 struct regulator *__must_check of_regulator_get(struct device *dev,
 						struct device_node *node,
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 55cc519103ed..eccb625423c8 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -658,6 +658,8 @@ struct regulator_dev {
 	unsigned int constraints_pending:1;
 	unsigned int is_switch:1;
 
+	/* time when this regulator was enabled last time */
+	ktime_t last_on;
 	/* time when this regulator was disabled last time */
 	ktime_t last_off;
 	int cached_err;
diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
index 9ec5237f449b..b1ac904fe33f 100644
--- a/rust/helpers/regulator.c
+++ b/rust/helpers/regulator.c
@@ -26,9 +26,10 @@ __rust_helper struct regulator *rust_helper_regulator_get(struct device *dev,
 	return regulator_get(dev, id);
 }
 
-__rust_helper int rust_helper_regulator_enable(struct regulator *regulator)
+__rust_helper int rust_helper_regulator_enable_and_wait(struct regulator *regulator,
+							unsigned int wait_us)
 {
-	return regulator_enable(regulator);
+	return regulator_enable_and_wait(regulator, wait_us);
 }
 
 __rust_helper int rust_helper_regulator_disable(struct regulator *regulator)
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 41e730cedc81..1eaae86a2e21 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -285,7 +285,7 @@ fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
 
     fn enable_internal(&self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { bindings::regulator_enable(self.inner) })
+        to_result(unsafe { bindings::regulator_enable_and_wait(self.inner, 0) })
     }
 
     fn disable_internal(&self) -> Result {
-- 
2.56.0.385.gac671c819a-goog


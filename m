Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119162C3245
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474243; cv=none; b=GYEl//FvPvub1ReZc0bE2e9G9KgBH8hXoQcNMOZb2m8r6TN3/uBpqKQDwBsIQGBWVMHSAUdGb8XxJ92mTDcS0GC4YuKQPfXS/utZGXJEDCTTj2uhSUbeTYir3Tik/ePQwA4GjXjz2VqDX31Jiv5vWIYtQIo/iYEhR387s2ztZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474243; c=relaxed/simple;
	bh=QuvLqztu7n4x7VS9RDk6Xi06jDDy2Ub0BO7TJXiOzLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lz7GqvgCLVMq73sX8vnECD5QYDli15wujMGDRLtrLPTbnh5QngrRylhvEO12TXeKcZeJFIumaiMYyzBwBEqCWOl8rAsOL1hPurOZ41saoEz2J6dUhHY44S5CNEadQ3+GoO3FK6jzD9RMOJ/j19OJubVuPwR7aUX52dvgNMimOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKoLkpJq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKoLkpJq"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b013084dc2so5179684e87.0
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474240; x=1785079040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1U4XlFDnYXrurhy3P+gmuMmaOpCiuKFSkl/ypZyvgd0=;
        b=mKoLkpJq/tX8FNamSe5JJ+plE2xAG0neyYUZFsgqZO+WHk+yLEaBaF2l7GEG/rwYCy
         KV4gWgnJCKi4J/nas36hpjKaz2XWHhfiRTQVtxtw/vP6ors/3Tkjxz8dPnrRec76pPf7
         TL8YxXrmZ1cZ9/lc5MJakGXKiML42VTbb4kCKlWUYOoSRAvsqBrVyVeQ0x8U3jqz3Jr4
         4Jlbz2GyRFjiFnfQOqg7sAlocGmTZo3X4pQzYM8K3Mwxf+Qv2Icf0uXnWYp75dA02dtb
         HUMqjSXfm/TI+fOg4IMxVxecWTCiQgV/Iq2rBMGz8qEOy9irraPt29fjQzN/7cdJVXmT
         iYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474240; x=1785079040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1U4XlFDnYXrurhy3P+gmuMmaOpCiuKFSkl/ypZyvgd0=;
        b=OpLx/LKWrA7CtYsd6TDECj6FkaOuKLWKltc0TeOah+ErXBCN/zUKem4J8RD9FzUIHG
         KfwpsvfGNtEi3O5FjOATCm7f2I5sdVTAT6fVSuwL3YDMudT/+hzjDUXa3257av5CdFRl
         D+ciy+J+oFCyWI+rirP59JIvsZ1ficrD6dZAvceesF8xwP2bQiVo5feFP96nvy86zrOb
         m82dbTgvoZCAGmIidbXFasjk+ON6lE6Wxol3yytfZi0bZLBIlifwihvt/kVn2otJBOIr
         d39BaVku/AUv/Vae3xVlP9QtzU0HaIZcMllSgO22awDEBsTs1hIO1D8qKhe6t6S3jYas
         fcow==
X-Gm-Message-State: AOJu0YzxvyCPcao2Rv1v1KeLdRn4WZz0NrZ8gPLZGIy+rFOpEFzNxtV0
	43B34sOeqFH0/VYBDTb5waxZnDKUeIqPDlTHrCqpBiZoZpRqcTh/8sY3
X-Gm-Gg: AfdE7cnqT8KgkTowR9Vwdh1aO6+91IfxzdHXeL9y4kYx4wPe9DD5nx7YpZ80Dn3gZDJ
	nnpc3+h68msNRiEUN1OqyWdRTW3ERN1q/zfPU/2gQron+4EhQMCjbOsv4oqlqCXA7jtf6JTsMft
	QK2kjLk/f+/QxEW/zxF247pN41GcYG9Gi9OwIql30oFmjI0XZOJEpXtRnzTy+koeHbD2R295rnc
	1STZuQgx+tkW4xZ0Ll7ocRw8tJlt2uubLBBPgqSVxVIEvyd0JDbdg7IdNK27pI5vH6UQ9feMphs
	29FeZfM+siuhZcgRaKvVpj/I0J6N5K5p1uwlWS8kd6Z3/TmfEVF5EIoT024UEnpyUyG6lS/V38c
	6rWWiuZBT5ltXfOnzc1Fv+vLWdKxweBIrJCLisEuTPl/I2mEZbnI46vNFJwMs4Re/dgexFRfwP6
	MeLDmX3Za882UoJdhgk45DzMwkbagMo8EJhRTWQxkHF2tj2+k1hLEAe6Yf/w==
X-Received: by 2002:a05:6512:3409:b0:5ae:b7ca:33ec with SMTP id 2adb3069b0e04-5b28f8550admr2242374e87.9.1784474239934;
        Sun, 19 Jul 2026 08:17:19 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:18 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 19 Jul 2026 16:59:44 +0200
Subject: [PATCH v12 1/7] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-i2c-mux-v12-1-a5010d623a57@gmail.com>
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
In-Reply-To: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=QuvLqztu7n4x7VS9RDk6Xi06jDDy2Ub0BO7TJXiOzLc=;
 b=kA0DAAoBiIBOb1ldUjIByyZiAGpc6najychFUf1agn36NniRGFSMFQTWS59H+RmRjFSDFoFh8
 okCMwQAAQoAHRYhBAVRoui2bLVNZMEsZYiATm9ZXVIyBQJqXOp2AAoJEIiATm9ZXVIyTIAQAMqm
 oQTG/BYiPkxnvB1hjpW5LPGujoqnOYiOZ7JZG1+ZmTAIb7as+ULc4C181rfnZFBZI60dg0hJW3C
 T2NgUzSnILXybiQJQ3oC78FNNtSSsSZUaUGwoWGRwUPk4IZ2Rp948QRpT30tQOcvh/POr3/ZPFE
 RQ0at3I31K61u1ZEvyhB45ivjNr9nnKNyUYbM6SgDh9c39fPxEdhdpdQmlQwzfTiVB19+URLGdB
 FoYMx28SDUNsSsBkQzJOe3BQsymLGMIyBZZcH9a9cmke2K3TMuPfLe1PfwqvWq5x02sANaWvv0W
 CDpVvXE8ojEaN/AmtJZeKe9XLqD7cTBG7UroIpCP0L2qG9LkUuavgNGiRKOzJ2eOstao5aXvkmC
 sa+mDEeLTWWqHgjN7kE0kuF8L52hjZa9Lmu9GC1eScm+nOIHwyUfoCiRQBrj2DdwGeywj+gxkRa
 Y7Xok1QrGlWhgNdcmMbR+qAfEIjQ5K7XTaQhixXl6MApMffiocgLC9w2/jz9D5hWPtjEsXMSGTN
 XNRv2jTNrVAHG0MXqUrAOXgXn9cCcrpG0GXDCef9sSiKyqS2pzL4FtcHQN6jRtLNz/MaOaP0URd
 7hGDFryHH7YviZQhD2/BFly/wvZtpI6ik3d5TDx1z/e4sl1XiV0JRXO5PaWVNivNM2090xJZzpl
 lzdrH
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

All devices on the same I2C bus share the same clock line and the bus
frequency has therefor be chosen so that all attached devices are able
to tolarate that clock rate. IOW, the bus speed must be set for the
slowest attached device.

With I2C multiplexers/switches on the other hand, it would be possible
to have different "domains" that runs with different speeds.

Prepare for such a feature by provide an optional callback function to
change bus frequency.

As a side effect, several bus drivers keep the bus speed in a
private structure and can now have this value stored in a uniform way
instead.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..b3b0d16b4ddd 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -729,6 +729,9 @@ struct i2c_adapter_quirks {
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
+ *
+ * @set_clk_freq: Set clock frequency for the adapter. Returns the actual set frequency.
+ *      This function is optional.
  */
 struct i2c_adapter {
 	struct module *owner;
@@ -742,6 +745,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	u32 clock_Hz;			/* bus clock speed */
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_Hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */

-- 
2.54.0


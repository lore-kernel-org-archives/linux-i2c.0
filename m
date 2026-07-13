Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045136D9EC
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927237; cv=none; b=CmXqC2Pc7t2N5NRQxz33xyMWmdv9nBn2muNBsMDcUeBfmMZZiLTy4Eh5c0QjkzXzEdujxFLGte6sR0CedmP+NcPmsoCUOYtmB05WzNaR+ZdrGAsxq8dRkTqdlR0B3SSea+OIryIFX6O8HclQ6futaTvMEDNC/0CwgwyTwv/HLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927237; c=relaxed/simple;
	bh=utkdIrJtEC44DqqTUyxORrRSv5x0AbtRsT4oMW64lXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HO+SPHfmD801XtjGzw4QuDhPvruuwfKL+MSQiI1BmYBq8f4rADP9rttpAFgiXOlD9p5uD7wLy7qdtCBytZYzaqngzt109MBvB8SW7WnpiDvLkuCZUMmS3ER/irAmrxlk9EK5RFOEybwTSQtv/otp8B/QDVs/Nld8aB25NgwJjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITMCwiBx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITMCwiBx"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3995e22ef81so30678711fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927234; x=1784532034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUX26WpwvVrJFwxAmnUDIQNXofqL2zgl9QzvPbM33SE=;
        b=ITMCwiBxT93dvKJ9SyrgqrBe/As8DmTzHw3Tl792dkFjzkp5L5ygZ8ttikeH0E2nD1
         SYqEm3DcglGkgcB830KHzn7Gk1opS8SBP2cYmby559QmBmrmjCk8CrVR6QfwjcuPqeMc
         ExR0jcqLFl67leBy8KFOvMpISNaAJn/KW19Ct6TZm8vYPVQEpicmvP9QK06Vw1hOSPHg
         et9VAv2AoWMa5MlFmxbLJf9eh03SwE8vhI4chLDQXpKcfhwdd3MW+oL2FG3W3/IeKENN
         ObZjsnCpJOdUZXg9rNjYhuOZ+CqUgXbjC/o5S5V6gQ9WE1EZbbQ8bjeopTopJkgOS8NB
         g34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927234; x=1784532034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUX26WpwvVrJFwxAmnUDIQNXofqL2zgl9QzvPbM33SE=;
        b=fS8tTqx/RGnjCDzJGv+H8X/nzwkAeEViGDmE7ZAS2CujJPjZEQ9pdL9MQzji2hHYg8
         yJGb8MQzzzPu6AK2QUpSLiYJozjatve7T7kluvKtyiBOaznSucuyn9nD5mnuF/K2Bm7A
         POfntk4C28O4o5Wd5y+aKy/aj9LMmqwIP0obC5OdzuFWRmT4jzi8/hcCHnzul6xS7A38
         gUB13WxTPYZ7lSXaQYJsv+GVuiosnHHHWy+UhxIvgr8fw0pYm4M5zpqdGw0MsrbgTtyg
         OjnTIirOTrjQ5bjZdmjwPE6bFkDRcdEWApo5LAjLBylFngzLWaIov8p1cXMtP6TgLGDH
         EiLg==
X-Gm-Message-State: AOJu0Yx4kHgVQ6sUXRAg5wjqp7ApIAYzu4xA5ZEjk2yI7XB7DIwYvqry
	3LRy1js/6zrjUdy5GHPgPR5JgWmdBIeuJzbTvYaHgh154leTJZAJRw2n
X-Gm-Gg: AfdE7ckBpsoBV2WJCZO+FKthSfNfhZxTpZdhhC59+FC2e1xpeUPyL+RHdIQ/+JgEKkx
	6oDlSWO1L7C07eYeY5kVMhXjMTF34uWALqV6biEBLJtOH0CyxUMS++KBe9ap1uiDar9Hz8OT9pD
	Dctvcy+vARh5Qhg+raOwiAn5QVQF2DJQQDqeZsk9HkK+kx+7bX54YT1PmVNpwcAVJVvKoRc99fF
	5ua396o13QNGtydWZpnW57uPpDALpnW9o0hRHsbcSTIKbdFVR/3YC+ANFMGugBIFVacBxoe1q2k
	2NBCwvBxPinU+7EL8oeCljnzv5Rl/RaWoKQflwkpxMKros3aXx9PwhtHPzXiy+CGdmYshCWj2Jk
	HS2EKEo2CR1tk1igmIyRBCec0DIH8L45lmluThOvRrVddKWLTF7PkBlf53miw24dG1WTbncbCIq
	4sgpcRuiSIR/bvJvPqjKIrHwRLE56V944sx8gv2S4fWDFyw4r/57qTzdpvvQ==
X-Received: by 2002:a05:6512:230e:b0:5ae:a4a4:b6ca with SMTP id 2adb3069b0e04-5b023d12238mr1708807e87.14.1783927233848;
        Mon, 13 Jul 2026 00:20:33 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:33 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 13 Jul 2026 09:19:57 +0200
Subject: [PATCH v11 1/7] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-i2c-mux-v11-1-72bb8af8ee8c@gmail.com>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
In-Reply-To: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=utkdIrJtEC44DqqTUyxORrRSv5x0AbtRsT4oMW64lXM=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJGxwTjAtaPb0x5drXc0YkmoWzNJ/oOfKfU+v
 Up1Vt+tNK6JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRsQAKCRCIgE5vWV1S
 Ml3vD/9bNNLgaY8rXBnkrdoKHbiEb1/KlJz8oezgUw8JKMycE6i5sYg9soeiO7PosGFTsdXXEiV
 7z8Ff+3WT9gywMHcNHEnjfDK3XzJsUreSOK7pe8qsmdBFsxA5TMn5dUGj6a2KMVYrXB1qrMXqLE
 Lkg1zc7KRwXnlm9fe/595rL0/4YD57hlyR2XPUyAsmomk2b7q2vj5LwoTCOkDFOvqMHtDOm33bv
 PLurGaVJWJXRdSfRbtSCe3RMNuBrNolJE6JuRJJakIWtzx6funBlavwO+Qif9sOYX1uOKoKdGmj
 4XbLzxw2YwWpo3tgEtu2WIcwTW+/tNAQ2gqV6CA7fDBMPXSElclnAYXk+x0DFuqeAP04SfDIvh6
 eiKhJZAaG4+92N2MlcD4llb7ZK86bkigpmGlOhZ7OoA4PpJkoGVLJ4BADpKkYY5SpBqA+jew7Kl
 +OyqMnYZ9Xm9z+J1jUsertIuZS12CLPEc6VwU1oXbyijaPbN9djHkdIkLKy2Zj/5vAfB3XCH9Es
 fypF9vGE6zGQWXjr8uUM39x2Ra5WXMSI6kXCuF6F8WLA6dkhLI1FtDH2As4D7gA0SrhrCFx2dLF
 B9xjAlyz3Q/Z8gXfyEFA2KjkStyfrSYZYJ0DjEDfFdS9TT/vj2ipv9CVRyeoNvg6lIcTWhpKqe0
 1e6ya2D9fiWDixw==
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

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..c5ba07f03ada 100644
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
+	u32 clock_hz;			/* bus clock speed */
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */

-- 
2.54.0


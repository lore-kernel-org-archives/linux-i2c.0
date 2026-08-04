Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78424396579
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834871; cv=none; b=V8te7MiLA9EJytgaIsphT0pB9TczHnfzrG/CrSix71zIwlq/bDV2pJ+Ya+oErLOOaygKEf6dsZbA1V7waOkM+5mduZwLJTxgBM8myPH8a+orGQeWIbRDdVJixKAHLElxEZRW3syMNDadTy+9aipyQrSx88ndnTVM1hgm9SZU6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834871; c=relaxed/simple;
	bh=Ny2IHw3Be+jCLEHkmhEM0ZyalB4GFDyOyjID/4NK4nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sLStTTgNgtT/fDmrvnEwzzNX4w4cSpSkls1p+x3hEYSM7OZT4eHKRIx1Xi42oEj2M7T5W6KLb9hJodLAbAOmWqnq/0YgOyR0blUoDBc9Gi7IFVaQogyZyYppdQ3evSljT3ZS5lJEY8IOhfGcTcHfm8ghS8RyKIju4332PsMjY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bisdn.de; spf=pass smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn.de header.i=@bisdn.de header.b=CTsoEgeE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn.de header.i=@bisdn.de header.b="CTsoEgeE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f611b3af9so595428f8f.3
        for <linux-i2c@vger.kernel.org>; Tue, 04 Aug 2026 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn.de; s=google; t=1785834868; x=1786439668; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6J9elifCKAWEzypuHq/Sr8Czg7s6Stu3N7kACkBl3bI=;
        b=CTsoEgeE4VQ4wJ8KcDBnIPqBj7eXMjFBJluBG09l7UE1U6DqmbChF+1Wi8liWcrvPl
         x3CFudsq9eJuY0xy/j/TwdKsrrQtSbfwykjFZjsNpH7scP1MS6pnSeMpJtPJqicqINvy
         bIYIYH82u5tVWaJQK9x6QuYCjLiJhvA8aqAJgMOf/Wh49x03SAeuiSi308LEadyRNSzy
         6NeAUMW6ZNP8hndj2MkT1I770BJvoRBy376SGdaHUri8XSDVlWPUtrUDwM5ufCvBRWLN
         YqxElNkQDHqq1QF7T4Np0PwgNhW4eq+KiuXHWDpa9F8Mr8JhemImcrHpvOoFetiI2vws
         g12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785834868; x=1786439668;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6J9elifCKAWEzypuHq/Sr8Czg7s6Stu3N7kACkBl3bI=;
        b=F0nrbapNtFfm0oxMpNUx5bZMGp5NhXpFvIWo1OicByKp4QxBrIU/yp1rKCFuDtaH92
         e9QaXDnTz0biDZU30b/Q8ZrjRB9z9y7YoY+g2jjgEiwrtExU3YaOqfClxx4T/URwevTk
         MTNlKqpH/5kr8IqTRo9QoC07lhl8AC6Blx9isyxpFiPs1NNWlZWroTBx0nHxvCAf+VNH
         zLWIgttVPSq3366aCnsPFciE0+iu2nbBdXc8xIxsQJRFELdXn2v/Mlqw/a6qy6J5zRz9
         nsUvbHlXcG/v1cEKHc5/6wdOZCFwSUs5SMxgUBfPv+hC4OygB5DI+TwpTau8nT/BZyMW
         ziLg==
X-Gm-Message-State: AOJu0YxWvNthP0A5ix5VHEALnrHWVgD/XAhI4/09X2tIOV+cIJosjB4L
	bunnWL8nkcUTESr7TLi+S0ifEufwJRqvZ7E2V8e2Pd81C1FrI/zGCX997M0bTsh1A4Xdb/hJD5m
	gj0aB39lmcU3OHLtpcUEbfFr6SfxzK0tOPq4HKt2/Jz+IcClzb2Dx4pJ9IL8UppBNZq+0
X-Gm-Gg: AR+sD13p8KExUZuQ7ePjsT2GPHqgfl8QKKPP2OIm5u1CayE+FMPc4DQLfqgMbWzJWE3
	AjK4T47y30o+EU0auuZMZV4RUJ3vrxyfIJtq7zwiKY5Pwd7aeQqmaTvceSvnJ7cO7ytGX8EmdZ5
	LHMqX/zF2C0oLu7E2tNh5Mc1Zomtq5p1w1cuj3++z2HG3zlNo8Kvi+HXXRFSE2bL6zAVkvt1oCR
	jcS3EmfpZjb6tqosPkqsUPBbGf33vruRyLu6JNKHdI83mVwuZ6SZSD32RjnM/8qrf9l5dUuo3ua
	72TDEyX0P1UKkAvPVHvPDO8SpWbxW4C1HOj18AZl9S4Syj1jWVx4Y08ecu+mNuWhia6Qw1p3VRP
	pxr2KqyCNf1AlSGkvyFjPgiiYQGf3I9oIVUON01ZAlO34AYpa8qjJhiNT0CXIrqmcEBOdnEQttV
	4QHiknVpyLWibkPwVsLupbTmhpunypig4cc5oaMhcy9Qa4WeFbMMB5x6Ab5UICxF4lNhhhGHAAs
	YgM0jejOz5fizjXK48aCCRvlvH1mWbTUFOCACF9NcKLFoj+OTkDiRk=
X-Received: by 2002:a05:600c:c494:b0:498:8e6:d463 with SMTP id 5b1f17b1804b1-4980c657c57mr147306445e9.1.1785834867640;
        Tue, 04 Aug 2026 02:14:27 -0700 (PDT)
Received: from localhost (dslb-092-075-058-142.092.075.pools.vodafone-ip.de. [92.75.58.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm42625623f8f.0.2026.08.04.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:14:27 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Andi Shyti <andi.shyti@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: iproc: recover the bus on transfer timeouts
Date: Tue,  4 Aug 2026 11:14:05 +0200
Message-ID: <20260804091405.171214-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

Just resetting the controller is not always enough to recover from a
timed out transfer, the bus may need to be cleared as well.

So add support for generic SCL recovery by switching to bit-banged mode
for manual control of SCL and SDA signals, and using it when SDA is
still low after a timeout.

Clearing SDA does not reset START_BUSY, so regardless of clearing SDA,
the controller might still need to be reset as well.

This is loosely inspired by iproc_smb_sda_low_recovery() from the
non-upstream iproc smbus driver implementation [1].

[1] https://github.com/opencomputeproject/onie/blob/master/patches/kernel/3=
.2.69/driver-iproc-smbus.patch

Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 92 ++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bc=
m-iproc.c
index 66bb3bfdaa4c..1d3732c76c09 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -15,6 +15,7 @@
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
+#define CFG_BITBANG_EN_SHIFT         29
 #define CFG_SLAVE_ADDR_0_SHIFT       28
 #define CFG_M_RETRY_CNT_SHIFT        16
 #define CFG_M_RETRY_CNT_MASK         0x0f
@@ -56,6 +57,12 @@
 #define S_FIFO_RX_THLD_SHIFT         8
 #define S_FIFO_RX_THLD_MASK          0x3f
=20
+#define BITBANG_CTRL_OFFSET          0x14
+#define BITBANG_CLK_IN_SHIFT         31
+#define BITBANG_CLK_OUT_EN_SHIFT     30
+#define BITBANG_DATA_IN_SHIFT        29
+#define BITBANG_DATA_OUT_EN_SHIFT    28
+
 #define M_CMD_OFFSET                 0x30
 #define M_CMD_START_BUSY_SHIFT       31
 #define M_CMD_STATUS_SHIFT           25
@@ -715,6 +722,76 @@ static void bcm_iproc_i2c_init(struct bcm_iproc_i2c_de=
v *iproc_i2c)
 	iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, 0xffffffff);
 }
=20
+static void bcm_iproc_i2c_prepare_recovery(struct i2c_adapter *adapter)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adapter);
+	u32 val;
+
+	/* enable bit-bang mode to allow manually driving SDA/SCL */
+	val =3D iproc_i2c_rd_reg(iproc_i2c, CFG_OFFSET);
+	val |=3D BIT(CFG_BITBANG_EN_SHIFT);
+	iproc_i2c_wr_reg(iproc_i2c, CFG_OFFSET, val);
+	usleep_range(50, 75);
+}
+
+static void bcm_iproc_i2c_unprepare_recovery(struct i2c_adapter *adapter)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adapter);
+	u32 val;
+
+	/* disable bit-bang mode again */
+	val =3D iproc_i2c_rd_reg(iproc_i2c, CFG_OFFSET);
+	val &=3D ~BIT(CFG_BITBANG_EN_SHIFT);
+	iproc_i2c_wr_reg(iproc_i2c, CFG_OFFSET, val);
+	usleep_range(10, 15);
+}
+
+static int bcm_iproc_i2c_get_scl(struct i2c_adapter *adapter)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adapter);
+	u32 val;
+
+	val =3D iproc_i2c_rd_reg(iproc_i2c, BITBANG_CTRL_OFFSET);
+
+	return !!(val & BIT(BITBANG_CLK_IN_SHIFT));
+}
+
+static void bcm_iproc_i2c_set_scl(struct i2c_adapter *adapter, int scl)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adapter);
+	u32 val;
+
+	val =3D iproc_i2c_rd_reg(iproc_i2c, BITBANG_CTRL_OFFSET);
+	if (scl)
+		val |=3D BIT(BITBANG_CLK_OUT_EN_SHIFT);
+	else
+		val &=3D ~BIT(BITBANG_CLK_OUT_EN_SHIFT);
+	iproc_i2c_wr_reg(iproc_i2c, BITBANG_CTRL_OFFSET, val);
+}
+
+static int bcm_iproc_i2c_get_sda(struct i2c_adapter *adapter)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adapter);
+	u32 val;
+
+	val =3D iproc_i2c_rd_reg(iproc_i2c, BITBANG_CTRL_OFFSET);
+
+	return !!(val & BIT(BITBANG_DATA_IN_SHIFT));
+}
+
+static void bcm_iproc_i2c_set_sda(struct i2c_adapter *adapter, int sda)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adapter);
+	u32 val;
+
+	val =3D iproc_i2c_rd_reg(iproc_i2c, BITBANG_CTRL_OFFSET);
+	if (sda)
+		val |=3D BIT(BITBANG_DATA_OUT_EN_SHIFT);
+	else
+		val &=3D ~BIT(BITBANG_DATA_OUT_EN_SHIFT);
+	iproc_i2c_wr_reg(iproc_i2c, BITBANG_CTRL_OFFSET, val);
+}
+
 static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 				      struct i2c_msg *msg)
 {
@@ -803,6 +880,10 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2=
c_dev *iproc_i2c,
 	}
=20
 	if (!time_left && !iproc_i2c->xfer_is_done) {
+		/* Recover bus if SDA is held low */
+		if (bcm_iproc_i2c_get_sda(&iproc_i2c->adapter) =3D=3D 0)
+			i2c_recover_bus(&iproc_i2c->adapter);
+
 		/*
 		 * The controller may fail to clear START_BUSY after a timeout,
 		 * reset the controller to recover in that case.
@@ -1064,6 +1145,16 @@ static const struct i2c_adapter_quirks bcm_iproc_i2c=
_quirks =3D {
 	.max_read_len =3D M_RX_MAX_READ_LEN,
 };
=20
+static struct i2c_bus_recovery_info bcm_iproc_i2c_recovery_info =3D {
+	.recover_bus =3D i2c_generic_scl_recovery,
+	.get_scl =3D bcm_iproc_i2c_get_scl,
+	.set_scl =3D bcm_iproc_i2c_set_scl,
+	.get_sda =3D bcm_iproc_i2c_get_sda,
+	.set_sda =3D bcm_iproc_i2c_set_sda,
+	.prepare_recovery =3D bcm_iproc_i2c_prepare_recovery,
+	.unprepare_recovery =3D bcm_iproc_i2c_unprepare_recovery,
+};
+
 static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	unsigned int bus_speed;
@@ -1163,6 +1254,7 @@ static int bcm_iproc_i2c_probe(struct platform_device=
 *pdev)
 		 of_node_full_name(iproc_i2c->device->of_node));
 	adap->algo =3D &bcm_iproc_algo;
 	adap->quirks =3D &bcm_iproc_i2c_quirks;
+	adap->bus_recovery_info =3D &bcm_iproc_i2c_recovery_info;
 	adap->dev.parent =3D &pdev->dev;
 	adap->dev.of_node =3D pdev->dev.of_node;
=20
--=20
2.55.0


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany
Phone: +49 30 610 816 100
Managing Directors:=A0Dr.-Ing. Hagen Woesner, Andreas K=F6psel


Commercial=20
register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569 B
VAT ID No:=A0
DE283257294 <http://goog_1008408251>


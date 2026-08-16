Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9821465B4
	for <linux-i2c@vger.kernel.org>; Sun, 16 Aug 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786897082; cv=none; b=JRvFDN9kLLqhZbu/2dZCGTX6CQ47Gbo9pulhP+uuAxlSmsgl4RIKt0fdjKXDE47fAUfcxKGDbszLtAFK4KQhwe3MCtERY9LFxvI40JH0JHmdgGNyXDCS9HIPeUcyjBufRssnniQnU7GBRYl5o4el4p3McejAFJNVNolFMyN64cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786897082; c=relaxed/simple;
	bh=K/62F+/xXCSdmMbTfj/WLQCYB1Y1dk2E+VHYhtxdO24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uh4A9sAXwTCkW0og6GnGWABO6s/eGJhYHc37cdU8xyiflxl+1zfTgqfncXVlqGlvzIhml6T3Gx2RT8uqYbWxYwmRRY1ou2VMSHhds7z66klFHaZLw6bApjSLdrOYeORZVz5UWhOdzrmyaoVkb+3riz+3vydfPUOqB3foQdpySJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+KG9ASt; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+KG9ASt"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4560d6f82edso1902019fac.3
        for <linux-i2c@vger.kernel.org>; Sun, 16 Aug 2026 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786897080; x=1787501880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=45Lc9/PgciOys56MUK+9hC9sYi2ea1eUa5elSIvnsws=;
        b=l+KG9AStAxk5QkO2irQFNsrPIVKz9UlR0z2tHUjYv6oZQIBhyLH5rLjSo+1VgByPBs
         lMrnw9VXMN93i9HHYdgAtxvpYKr+J2IDMhP6ApK9IVv2o/CQdLR+F0y91AoFB48yzdpl
         0YpRc6Wv4YHKpzBfo352HNbn9HOSWW4knix/B6MmgbUQiEAlEEMPjHIDmVmk80pzLu+k
         FxmmmSpl5Y3d4giQcHxyRWtTgupo0vPMfG/LvBoMlO5vFkzxX0IJXpcDWoURmSwubLEV
         b1fIzT5Bl6MeyWBXY6aUqqlSS3vLQiMt5ilPHs50mrHGGELjYa2widpuTUzb4uKCxXQd
         BqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786897080; x=1787501880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45Lc9/PgciOys56MUK+9hC9sYi2ea1eUa5elSIvnsws=;
        b=QHrgIm46GQX+EqVMwwx5+BdpjtdA1hXoEYW/5D8JwYd/PkdntiwUuswZLiseHzKVMG
         ieQkMHbqGpYqHua03kgSldQy7q2oJ2fxjDjellUNjBLIu3g9lRZRfIGrigMFFOfRaQvf
         YnSRs92Wd16WllAHYjTjdDrO0j4uj3S7RXda9xgHxLHmbyuiLvXfVMqtrUA0SSYUuFTI
         3jtZxzPU+JD6NXDgV+BKC8naDqKbwHmPgYCHUw+Ip0GEEG7QCsvXZl8WYNFybcwSLP3h
         Ln+0ZXwhlTjVNTLrfX9stMuNAnrPFDwYHO6Ra1rZRlSygr0gANKmhgV+b3ebLryOEPhk
         UdZw==
X-Forwarded-Encrypted: i=1; AHgh+RrsFsyxz3MwVTrhQAfvR3kGelsOm0BHprMScEZvXo9KWfSyK7h0Y7aewjuK+vRBJFuXjPnBry4AH2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4O5XgmBIeux2CdsFO2xzChwxnQQzgosAYanMEJ6ENBNNEJnv
	P9w2RM5tWtDyn2Uts68Q9QqmnQGcS+RsxWHz/oLjniGausmh2WVOGO8=
X-Gm-Gg: AR+sD13hVz4ieSUGPntlKVH33c8YSHk+BZUJnnrcVlLcN/YRiPjyQKIUIBuyrQVk4rL
	Eau0wSszMMte6nPMoXmUwr8P9K1dXHw01/J4bgXFxWIxVOpFzmVqD2/xR2BfOfuPwmBAy8HrqMW
	W4Ncwwq931Hv1s+JQTc/fpEpgbThvuu6EDqE+NW0onOlsW4HJGYePOecdNwNlHfdfQFXIKyNTaQ
	usbn86rrCK05pgipzQREpPCh+54R3YurCK+7kxA2UTWKAYqtIJUOTeJa+pxxI5laIVkiN/XFn85
	4H7vOmxH7SMlECMeOk50s650Fkca5Hoc1W69bQ2ZAOiD6e/BCiDEbM6Mayigibd5/3aRjvAh+Tg
	Mp0BjGxPMZiNx2/nFBKnOJxIzZGsImebpxIEMeZuH7JoRd2NpgUDIBx5CUtlsb5pac2Iw+vebfV
	aF7bhmpsAwxgE2dyV+j2reb7f9jakz9el+HKmSHSZtMSyQ39Y6Y39zf7Y4BigAn9009AlL2hC4F
	PqEp2X4bVj7RgINSIlOeEZxIZx/MmJsRmzJhpWTc88x0Dsw7xslVg==
X-Received: by 2002:a05:6871:e010:b0:43a:5226:55de with SMTP id 586e51a60fabf-45e921f5e39mr16679940fac.14.1786897079763;
        Sun, 16 Aug 2026 09:17:59 -0700 (PDT)
Received: from codespaces-a1fa80.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net ([23.97.62.128])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8f8edaf8sm7825538fac.1.2026.08.16.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 09:17:59 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: bence98@sch.bme.hu
Cc: andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] i2c: cp2615: handle allocation failure
Date: Sun, 16 Aug 2026 16:17:51 +0000
Message-ID: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the result of kzalloc_obj() before dereferencing the allocated
message structure.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/i2c/busses/i2c-cp2615.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 951de6249..178a35d0b 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -125,6 +125,9 @@ static int
 cp2615_i2c_send(struct usb_interface *usbif, struct cp2615_i2c_transfer *i2c_w)
 {
 	struct cp2615_iop_msg *msg = kzalloc_obj(*msg);
+	if (!msg)
+		return -ENOMEM;
+
 	struct usb_device *usbdev = interface_to_usbdev(usbif);
 	int res = cp2615_init_i2c_msg(msg, i2c_w);
 
@@ -172,6 +175,9 @@ cp2615_i2c_recv(struct usb_interface *usbif, unsigned char tag, void *buf)
 static int cp2615_check_iop(struct usb_interface *usbif)
 {
 	struct cp2615_iop_msg *msg = kzalloc_obj(*msg);
+	if (!msg)
+		return -ENOMEM;
+
 	struct cp2615_iop_accessory_info *info = (struct cp2615_iop_accessory_info *)&msg->data;
 	struct usb_device *usbdev = interface_to_usbdev(usbif);
 	int res = cp2615_init_iop_msg(msg, iop_GetAccessoryInfo, NULL, 0);
-- 
2.53.0


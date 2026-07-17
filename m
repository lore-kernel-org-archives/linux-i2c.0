Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8C3ACA59
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278516; cv=none; b=N6JWEjCfAdopa+xUy/bY6743g8VRgNyY+xB6mFUkkrepqgtgrjjJMEJUwQfr7CRbPJt0fnKTt+lcjTR6jl1FniRqNmODMp8aBMchJ3d7IUaS2tPZ+sl5Nw+Cnwmh0eZNLPBPrbaUiNM6/urZ0bkRMXxmhUvJv8IcHHe8S5/nIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278516; c=relaxed/simple;
	bh=iZ1Dch1YLOVoNX5Af1DO+jUyz5lVxIqiOw883wUrgeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HlSdHtuU05DPUlsgCXI3V0ZCv2+4m13c2JfXdhGDMP+9CecI2Uexuu7G/igEPsBPXsUbVl2vUkw8be76E5UdC3VVHIpi8Sf3WdbUMdPWgEBCZJ2OYhDrdGiWqpWs/x/zMWNh+nJUC2mYYLgQu9B7cGHNMRq/sXB2iRLxqgpoeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bisdn.de; spf=pass smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn.de header.i=@bisdn.de header.b=C6lFTz1B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn.de header.i=@bisdn.de header.b="C6lFTz1B"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f611b3af9so11499f8f.3
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn.de; s=google; t=1784278512; x=1784883312; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UqB+ZcdPBHABzE32jG4dg74lCIilLL5SjMXqW/Mf2cY=;
        b=C6lFTz1B0IGaLeLYqx+Fbq4i7UbFf+VK/wOWQ/EYO8N6VT8OVpUFvjnwqfsoquB53f
         5Jv1gbF7aAKCEuxfL8pUd5dW/7GdDxHm9KBZhuqNoZynzALinH7ORFuaGwIl+XFdI7qZ
         5d0XdctFFvJfr/DmkOwLgmJ4qL6rM/2J7Dm+/2mCE0Z9evdFAPxmyZ7X7VLHgcp1bEBD
         Q3ya5e1h5uLbZCfJAih5Mf1BGQ392JEA79NOPnwSlbF4Y5KqO180y0Xp67WLlUNmYG5O
         M2ecCVT31i6upZ92S787NxlDn/iTYscC7yXnm5ndhJO8fr0J4GU4fJ0vSlrEjKTYiUJ3
         vWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278512; x=1784883312;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UqB+ZcdPBHABzE32jG4dg74lCIilLL5SjMXqW/Mf2cY=;
        b=r13F2DkyWJuQ9pU00rjqXmW2ZAdbnD9RZ+Dta9a1/1ZOh6g7TWZKmiOcdStKaNbjKi
         DoG079MyG1pFcqSjGeu7PMClT7rWR6rqU3Rvuq/4v/JELi5LNyqBZGxsSod884+IyHYp
         184j9jpGCkYHTMIplVtS0WmD0YiVTsi0YHFbxed5+ZogvmqKHEpmaizq3mh37DFew//K
         Hni0oDcblog4iJJn+JwhfQYuCBctzPaEX84jRriHBLF3bfJkV/GoXe5V68RiHgg5IStL
         BwOiWABBExJz6p6C1buk7YL0GUV6EEWc5VpqZIqU7jVNVFw4jkNr0aoY2N9ma1vBMLUU
         R88A==
X-Gm-Message-State: AOJu0YysgeYpfiTkVyu3ARZOe6FZVxIsbYtDaXsTdyBYBphEM5GbUFO5
	aRMCLle6llgvBecfVVQ46yCNjZdWJgk8u8uCh3yGCy0BEVFY9AEGJrqZMqrIX1p+rrIS0TN/vhZ
	DConIxsq7nhxrEPYdsTP/CFKLBpe373M1cOiP0fqFEiiuJhzIyVXYMNI=
X-Gm-Gg: AfdE7ckI1lD86wAasQ6szMdBxaBSsemq7LkRc+1JGDJhco82f0m31m6ENDc9FPBPI+H
	Dz41dKs6zO5VjG7pAbDYz3af7WUQUox7P4I11vL7gI38QyFUnfGg3woT5NKLaSqiBnFbPdPoCvU
	Pix1araDwO2Rg+rY2iVZCRSTor8faCgrl8PE3v7uIDAv6QZ6XI8wb6oGKlML5kv5T5ZY2bsqJPZ
	4CO+fWtUeW3ag3C2GqlW/cHuhudl1dAXG9TCHTeC/Kuc1DvcfnC0Ub49dIOUoqG5qKON2e5dqXE
	vQv/xr9l9e7G3/7UarbtebvIPZ3rPwzKdrYtpAvCK39dGw0IUMINV9lWuvv6wiF7ZgmKPZ2w8B1
	hsioXPeuoEkxZUY9LSaDu/KkZ/Y9kAJx8fkQ+tp5gFYWX7t8XJpEA5RVZjz7wgovFFOi/P5tWU6
	1PUgFvVtnhsC4vG05dfXWMyUyy7r8s/xut0HDqHDHAesEqVCuc1wcvT3ev
X-Received: by 2002:a05:6000:25f8:b0:472:da70:a45 with SMTP id ffacd0b85a97d-47f62344544mr1249749f8f.8.1784278512306;
        Fri, 17 Jul 2026 01:55:12 -0700 (PDT)
Received: from localhost (dslb-002-205-021-241.002.205.pools.vodafone-ip.de. [2.205.21.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52f81sm2193727f8f.9.2026.07.17.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:55:12 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Andi Shyti <andi.shyti@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Kevin Cernekee <cernekee@chromium.org>,
	Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: iproc: reset bus after timeout if START_BUSY is stuck
Date: Fri, 17 Jul 2026 10:55:07 +0200
Message-ID: <20260717085507.34209-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

If a transaction times out, the START_BUSY signal can stay up, and
subsequent transactaction attempts will fail as the bus is still
considered busy.

I can easily trigger this by attempting to read from an address with no
device, e.g. when running i2cdetect. After the first read times out, all
subsequent read attempts return busy.

To get to a working state again, the controller needs to be reset to
clear the START_BUSY signal. So check for START_BUSY still asserted on a
timeout, and do reset in case it is,

This is also done by the original non-upstream iproc-smbus driver
implementation [1].

Works around situations like:

    bcm-iproc-2c 1803b000.i2c: transaction timed out
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    bcm-iproc-2c 1803b000.i2c: bus is busy
    ...

where the bus never recovers after a timeout.

[1] https://github.com/opencomputeproject/onie/blob/master/patches/kernel/3=
.2.69/driver-iproc-smbus.patch

Fixes: e6e5dd3566e0 ("i2c: iproc: Add Broadcom iProc I2C Driver")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
v1 -> v2:
* rebased on current master
* reworded the comment and the commit message, as I found I could
  trigger this intentionally

v1: https://lore.kernel.org/all/20230904090005.52622-1-jonas.gorski@bisdn.d=
e/

 drivers/i2c/busses/i2c-bcm-iproc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bc=
m-iproc.c
index b5629cffe99b..86ca4c2221c4 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -803,6 +803,17 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2=
c_dev *iproc_i2c,
 	}
=20
 	if (!time_left && !iproc_i2c->xfer_is_done) {
+		/*
+		 * The controller may fail to clear START_BUSY after a timeout,
+		 * reset the controller to recover in that case.
+		 */
+		if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
+		       BIT(M_CMD_START_BUSY_SHIFT))) {
+			bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+			bcm_iproc_i2c_init(iproc_i2c);
+			bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+		}
+
 		/* flush both TX/RX FIFOs */
 		val =3D BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106206;
	b=n1Q+wOmIoq0Rpk0V9ePBYsfdp9hXQNTWykQPndb5HZ/v+9ZlIrSNdfhk1oKhjAfiXge4
	 G1uvckrIVrvLkCoCGcmt8RIkykJTxe0XV63yIUwtttjSOyHMN7kFMeUJ7XOCKnD79P6rI
	 LcrK2C6sqTxwTQ9eYgz1GsBai2iUyZ5GgBpvm67/lY0Ftug7t1NAE1glEps4JUMiZP5/i
	 eruMpYBeZ1qn3l1CRhd+lfR94PH25K5swvsZnGj+Xe/tTuvEUsKBOHiOohSB4lqGHyN2i
	 lxh9dRKN9oP5BwTvN6sQMLDnf8VZFhR4VXkxCuOF/reNK0hiYh6+AfZvuinnwtKC6wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hLnRhQt6R6QlcHHkp+GjQqkxHgrrfDhfoOqqq1YK7Tg=;
	b=iDcckonvzpf7Kfee8DDq6rJOb0etYSVa2lQq592yFyyyLD+dWkQg0dRwhzRqu0463/kr
	 aTHsPgCJpqiDJqD6GRwJ9Sc9mmBqDCZNzs05/925GdjcQu0p8xHp+fjo4fIbyRkqoLFa8
	 jDo108ohUsouI+PwT7tmlchvER1y4rDsCRdJpCr9oV/h9zrPP2oTfiEKu/x5g+qmWHvU2
	 dkK5m3026FoZzmSD4mZMs9bh1XnrTgpUtfzTgX11WS3P2tq0v1Ub4HLKsFUxvYWYFvBld
	 Wllf1FzFn/R9GAMmGmij1prgZs6oJ1OytA70+HHpRgTt7s/Bf1EROccN8SG7sAf5N7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FB6wfNcv;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF2606A31E
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 13:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64FF2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FB6wfNcv
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070781f63so1565129b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793106206; x=1793711006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hLnRhQt6R6QlcHHkp+GjQqkxHgrrfDhfoOqqq1YK7Tg=;
        b=FB6wfNcvoG0w0vxD6sIq7kwJVVwDOE/1ARVVI3JlwNjepj5ELUOoJNyiKDkDwOMZp8
         z6BjKDcdV8hxF28yBYezS3Oso26PivIC8AB0/W72rPi6THN5plvXsM2ZMqfu+SUFJ4s9
         1ej1ChZ41hbPZO4J02LXHewt+TH9Z82aiz8a+e7KL6JsP55yCkmQ3MPKBsP3+EmnPiNa
         Ktk6pbpoHOEATXUnbEZV9k9FqwT2ReLHd7/0ZsOx4VMUcsgw3tWtO/uk+u7tVs0WuHnr
         XDy6U3GA8y64lK827Fm96tNSxqWi9g5KBkyomOZ2a41rUkKWF00rKPsfcqrH+8aWBCAc
         cgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106206; x=1793711006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLnRhQt6R6QlcHHkp+GjQqkxHgrrfDhfoOqqq1YK7Tg=;
        b=YVY2mKUiP801/Tc9cTr75nd0M0BLs1NYPLs4EvpICQU6l7fNWtISQ1usbN1NckdO/D
         Akeuhy+B0xc9o3SqhQbkM4Y7XirEkUKuQZRGAJiIl32DhlCwWhDPrAdp5/87bfczhxSJ
         wPdwrgbCNBc5Z/oRc/tbiKiylDIdyy9W5KUbPThds9H7W0QbOixHpYyULBDiHetptVtD
         /29LxI+ubZmtjngodXyXadvqPbYRmIXzlEEffkHbDCAo9074d16wtE2Igu22uHVE0YFS
         3XwkDO/jy2Iec3lo81g+QuM+c2dRuEv/rgXhk4CE+zyzs4cunWZQXG+vxYZasEoxaVEO
         tXmA==
X-Gm-Message-State: AFq9FYKVR+lKutAq8oNUvyv6AODhzVxeFlj0Ek7HlXpVNfkgZD0DIz6r
	xeye8zUXCysPY7dsUe5wwBUmR3IqpOzeBnzNqM99pSQnj5nI31VP11vf
X-Gm-Gg: AYBFou0lsBgDW1SdMseDGhN1jQo2fjccJrdAdgmU8/tB2H/E25kfvlK9oavKrqxMAKB
	6MdHxSaIzUgFor0Spy0P0KJmg4XA+eaHwJ4xATaVN107TcS6FiS1/ikZFXA+8S10niKOrlNnDHX
	IYntJMfXIS98Ea8YPT4zc5phZOgsqJRUZgsaslJocRYx26rtFPiGl29UqqflI7VGTGmn4ujI2oz
	TtWgaJ/DScI8vSZBcxB37teQ0Hx+yXmrAM8AEf2to2KNX62nA+mkWr4YFq2nzGW9gRETgKgyFcr
	Xuw4KCizo10pm2S+5/treTqayHF8LhP8M9liBvy7ntAR7TH0cCcLntRdJFpXw9AoJ7TKQAyHX6f
	FT+jFzB578Bti3YHV1MSRE2QsudJKSVaoLi6SFPe0WNUYsFUbtzEabaVBh1j/Ay321drxG/cQzT
	/0Zn9pNx5PONFkIiFGF4/3gdVyNR/Z9s/7qDUcXKB8cEP/imuIs3zqk5adhd6y+OQg+yo+78/5c
	zTtfVmlexnAu99EwpV/fWLQenAfSS9UcVt+FYR78TPEN2pL/mlTzvNlS7ctCoLivKK7zqjQkmZz
	G29KVj+DxRm7quWfcPgahf8xdS6A/qC6Rb+DKU0Idk0epupfcxxdFxvikCFu+7HfEpXIFYzdOcq
	8JiYS8vx7p58p
X-Received: by 2002:a05:6a00:240d:b0:88b:9eca:951a with SMTP id d2e1a72fcca58-8a364e63374mr7663867b3a.1.1793106205299;
        Tue, 27 Oct 2026 06:03:25 -0700 (PDT)
Received: from localhost.localdomain (111-241-72-23.dynamic-ip.hinet.net. [111.241.72.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c100a13sm2380712b3a.52.2026.10.27.06.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:03:24 -0700 (PDT)
From: Stanley Chong <ale.sarick@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
Subject: [RFC PATCH] i2c: algo-bit: return -EBUSY if the bus is not idle after STOP
Date: Tue, 27 Oct 2026 21:02:05 +0800
Message-ID: <20261027130315.390-1-ale.sarick@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.2
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

When a device on the bus holds SDA low, bit_xfer() can still report
success. i2c_stop() releases SDA, but it never checks that SDA and SCL
really went high. The caller gets a positive message count and a
buffer full of zeros.

I found this on a Raspberry Pi 3B with i2c-gpio. An Arduino Uno pulls
SDA low on command. With SDA held low, all 12 test transfers returned
success. One of them is a write to address 0x70, where no device
exists.

This patch reads SDA and SCL after the STOP condition. If either line
is still low, the bus is not free, and bit_xfer() returns -EBUSY.
If the adapter has no getsda() or getscl(), that line is not checked.

I chose -EBUSY because the I2C core already uses it for a line that is
stuck low. i2c_generic_bus_free() returns -EBUSY when SDA is low, and
i2c_generic_scl_recovery() returns -EBUSY when SCL is stuck low.
i2c-aspeed also returns -EBUSY for its SDA and SCL low timeouts.

The check runs in the bailout path, before post_xfer(). At this point
the lines are still in the mode that pre_xfer() set up. So the check
reads the lines the same way the ACK reads do during the transfer.

With the patch, all 12 transfers return -EBUSY in 0.2 to 0.4 ms.
Normal transfers do not change. When SCL is held low, the error code
changes from -ENXIO to -EBUSY. See the questions below.

Signed-off-by: Stanley Chong <ale.sarick@gmail.com>
---
This is an RFC because the patch changes the error code in some cases.
I would like to know if this direction is acceptable before I go
further.

Test setup
  Raspberry Pi 3B, kernel rpi-6.18.y (6.18.34+rpt-rpi-v7)
  i2c-gpio via dtoverlay, bus 5 on GPIO2/3, udelay 5 us, timeout 100 ms
  Arduino Uno as a slave at 0x48 (LM75 format, 45.0 C = 0x2d00).
  The same Uno is the fault injector: it pulls SDA or SCL low and
  releases it on command.
  Each case: read 2 bytes from 0x48, write 1 byte to 0x48,
  write to 0x70 (no device), read from 0x70 (no device).
  Note: the Pi reported undervoltage during the tests.

Results (stock = rpi-6.18.y module, patched = this patch)

  case          stock                          patched
  ------------  -----------------------------  ----------------------------
  normal        0x48 OK (0x2d00), 0x70 ENXIO   same
  SDA held low  12/12 success (0x0000,         12/12 -EBUSY, 0.20-0.34 ms
                write to 0x70 "OK")
  SDA released  normal immediately             normal immediately
  SCL held low  4/4 -ENXIO after 0.87-0.88 s   4/4 -EBUSY after 0.88 s
  SCL released  normal immediately             normal immediately

Questions
1. SCL stuck low: -ENXIO becomes -EBUSY.
   drm_do_probe_ddc_edid() stops retrying when it gets -ENXIO. With
   this patch, a DDC bus with SCL stuck low is tried 5 times instead
   of once. radeon and amdgpu use a timeout of usecs_to_jiffies(2200).
   That is at least one jiffy: 4 ms at HZ=250, 10 ms at HZ=100. I have
   not measured this on a real DDC bus.

2. Some DDC buses read low when they are idle.
   In bugzilla 200045 (the 2018 revert of "i2c: algo-bit: init the
   bus to a known state"), radeon buses 0x92, 0x93 and 0x14 read SCL=0
   even after pre_xfer() was called (comment 14). Today such a bus
   fails at the address phase with -ENXIO. With this patch it returns
   -EBUSY, so DRM retries it as in question 1. Is that acceptable, or
   should the check be opt-in per adapter?

3. Rise time.
   The check reads the lines adap->udelay after releasing SDA (5 us for
   i2c-gpio at 100 kHz). The I2C spec allows at most 1 us rise time in
   Standard-mode, so a compliant bus is high by then. A bus with weak
   pull-ups is out of spec, but it may work today. With this patch it
   could start getting -EBUSY. Is that acceptable, or should the check
   wait longer?

4. Recovery.
   Neither algo-bit nor i2c-gpio sets up bus recovery, and the core
   only retries on -EAGAIN. So -EBUSY goes straight back to the
   caller. Should bit_xfer() try i2c_recover_bus() first when
   bus_recovery_info is set?

Build: tested on rpi-6.18.y. The same change applies to mainline.
checkpatch.pl --strict reports 0 errors, 0 warnings, 0 checks.

 drivers/i2c/algos/i2c-algo-bit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 7ca565c..c36787e 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -132,13 +132,17 @@ static void i2c_repstart(struct i2c_algo_bit_data *adap)
 }


-static void i2c_stop(struct i2c_algo_bit_data *adap)
+static int i2c_stop(struct i2c_algo_bit_data *adap)
 {
 	/* assert: scl is low */
 	sdalo(adap);
 	sclhi(adap);
 	setsda(adap, 1);
 	udelay(adap->udelay);
+	if ((adap->getsda && !getsda(adap)) || (adap->getscl && !getscl(adap)))
+		return -EBUSY;
+
+	return 0;
 }


@@ -586,7 +590,11 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,

 bailout:
 	bit_dbg(3, &i2c_adap->dev, "emitting stop condition\n");
-	i2c_stop(adap);
+	if (i2c_stop(adap) == -EBUSY) {
+		bit_dbg(1, &i2c_adap->dev,
+			"bus busy, giving up\n");
+		ret = -EBUSY;
+	}

 	if (adap->post_xfer)
 		adap->post_xfer(i2c_adap);

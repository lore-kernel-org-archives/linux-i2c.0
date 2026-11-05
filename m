Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793923087;
	b=bSpKShGlXYq1NsuhjOlDWC/xF/JXuMFbZ8Iu02ahehbnLqWb039HvEBNvUp5pQB7b8N8
	 oncwO+nPr3dLW6R+vK92PIxVgWugYXKQflsROwWRYqS4UBKcbtGX0WuVRmylALIazRbxy
	 7tzSgUVcjKljfmv1/uQ4AGXkUW961DVENal4TNAqKeU7LyleOfv+dRMivRTitvcXumU5p
	 WbLghqRQjm4/yuay5JLFzoDpA2r8fvDzK59vGfLettjg9jwCCHmsc13gDG0/K/xtLh4sF
	 CcXrS3hCLiHXZx3yQMwyCSQT/lWuQFZa5YiQMTBazKJ3J99D8TodQqfBZiKWPysR7+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
	b=JjaZhdoSgUs04NyJvV1EKyRK1QdZQEushrNZoYMxbX/aZrwB+qCxQowk7W3LqS7hmB2X
	 8AWiCo6xkb8VvML9BsKidzFHUSIb8rrebrtgiNlyx9jZjenl7QJFyrR9xNV0wMRCjKmqX
	 qcQsb4Z4Ohr3S0Ma3p40ClB60UXMjRciX2CMkiF48JI/jW4a0NQaWcTW/QdwwawY2IFXJ
	 wH1qGuGsITcaOlbsUDFMTqHahJarpzJGpfrmbmW/loTal7Va4S4QdAi6jrImrTx5HymoA
	 WqBmSpw/fxYWpeltAavCno1vKbRgjBzEfhZl+SR7sgytEpkTuWeT9zqGNFVF+kQ+5pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrNx5BFC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C0606A31B
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 23:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C7C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrNx5BFC
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-677bc4704cbso111672d50.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 15:58:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793923085; cv=none;
        d=google.com; s=arc-20260327;
        b=Bz5M8zsNBe1KdT56xKAxkEzT7wO4C8/2rCKtCwSL0ztgOcKEUa964sFiyJJIBUI/3c
         tD7R0ZQVp/Oje5BqZMque2sglN1X1hAJ1w8Hh2WCbYKtNoywI/U+nFe7MHxvkkV6jOB2
         tadMBeSYKpl4BCcpTkV9mJl8GvlQIXis+ws+G8dLPxNh/X0Wp+UEpQ9J2uDcZtwNzI1h
         SJN12KieOilFYfrxjQgTHc1FvkNf2WwnQLjloYI4yRxi0m3POEs1QP1FW545iXce8zxF
         NHM4QFkeNnhe4KVw0TWvHzJTMvbBu7AZE7A3oXHXJaeHXiKvLNoJkLJzjM6JTxBdcKal
         DZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
        fh=7RCDoAo3uZAe8F3MBmbC/d1cw2xPu06bOMnvHKb+UOc=;
        b=RkHPfpSmC/Q+vAr/xB7Bwh3KMur0dGQxM2v2rL1IhnMgiz0Y4xq1Rm1b1Q0lqnqHNc
         t5eO/T5Q9tW1CVz+ePWOSZbGFeSc8xvJoPf8Ru7gOE/+hlGjERAnL7L4DYmjL4QwGdDl
         NiyG4oAywkABZqwXdjGFEdXFHmU+vjS2Ts7vVJk3NT6tQHO2C4rcPmuZlUvB2xekCrac
         LsS4Mc+1oHnAlFh/ylxm2QUYwTXjaUcnNPIkrhRrfuSLMM+6DUUr3JFv3Op8+TAp7oZd
         1qPo3SrPRhJmu+HlYtOLRmfNDJlohqDZd2y59CHgQfJh51ggDyQC7OcuzhldhI08MAIu
         sV+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923085; x=1794527885; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
        b=zrNx5BFChjEJBx+SuRxoN0otzqHKhH2fT4AvDDlpZ9rPTl3+yIbJX5oczuvoad9E/m
         kMUp6n8JDWGVgwkJrkGIEFh10J7VwdfQqeULVrSPlkmE5glTmo4XE79138anRCfCBv2+
         3tpEuQ2YwYS5PyqDZ53YNG5DiY7bvm4hOTl+uaeE3DV8h1TUCUKjR+oByBa6T7eqsHZC
         k83ZVvRcCcO2Bw7fM14BWQRNfHi3Sf94h2xMZ6Fk4vQQ09ACiRBqy+hOCSeP9+zht0wx
         P7Ft2zKm4KGD+6dUAdsPRnp8LLMKVKu26TDJQRrLI6iYENWgmkpjClT7kp7Wnd+kZp0k
         EOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923085; x=1794527885;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
        b=VRcUVeMrpFKcugDFKwsalmSjRf0EYmMHgmuWXDYYUNo3rgFdPh1OS+qGnnSCnW/3u8
         p/kfvXZBoeb+4zlN7lBGP9wD6R97RI0lfxt9CgX6v3SWShoRDXChJjHtsz8mlmY9MXED
         0I8Y4mSSFCQ+nxQrJvRn0X9VF3xlJrJjuzmdCFFs7WdaKsE3sp+e5iTwF5i7qQLTys/1
         KPPRwYuBW1IveozmEDmyJ6fGmkxtpRcMAFiJKibO3AFj32ZjEclkn6JWeXQ6hJqPg4ik
         puUvDNt03Pm82g4ZQ/GoPW8kZ+kJO3l+CgY/FZplwdbsqy24L3c1lFJfJ57VpSuEc7J/
         VTkA==
X-Gm-Message-State: APuU4Z9nbvdY/DheCJcXyed/jgjhY7NgaIcK1JwbwIiGqYrOtKcew4eU
	ZeaJ+mWgQzqSmUQpKqAzld7ptfXB/R66Y97cpd8ZT6j5AvWdcnqQZUjhEHDPBivBFfas3DcgEbR
	sfUOH09rmu9p9NQt6dhYDwz7LDyqZy6B6ZLnQ
X-Gm-Gg: AYBFou2vUBV/WRNL1DIgMxdGdQJiIMHx6mwf1YOWcdtNNSwjvkDtqncvSaHVJQlxrje
	uxPtLpiEKoTV+niWGVmKR/h5bE03OQPJEyZ/hcOTntQMSHXlpO9w6cfRipbUOqq2TuRRmVW5/6w
	bz24d9D3CLD7agbW1y6Nipf0ifI82kMK3fKtWA1WZTM4gn8SpKiCmEFaL+Wb3Rg7ANVa7L8W6Zh
	q2sSc8IrSJpZBtjxFKEuafuSN/NZw0TUzUV6NqLuQ6t8zXyJTMjuLf1m/iruImDRXuBeM7AOtyi
	Sfj1lPGv3wdzF4gawSb0PhvOXnOaQFCiDQzCWOVE/oD4EGz62OpncHFYalu1AekILv/EaodRG0t
	l3V7Kv4+h7eO5WdVdVUaP78qnNyflhhL2MCsNx1O1FomOKEHmen4pMbG0wZJ2HrxXEoEz+O/ipm
	quIbop05lPmc/Nllsk
X-Received: by 2002:a05:690e:109:b0:679:a03c:3cef with SMTP id
 956f58d0204a3-67c145a92c4mr346898d50.102.1793923085400; Thu, 05 Nov 2026
 15:58:05 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: vincent PEGUET <vincent.peguet@gmail.com>
Date: Fri, 6 Nov 2026 00:57:53 +0100
X-Gm-Features: AclHuK-qYGEy06Wq1pgxZHpoH2Atm80TMREYWlZFDbKoGtmR3hU-o0hHAhimcho
Message-ID: <CAOUhbe=K-pQZ_ZJs+sQiSRP9rrKOyjM=bF9fhHHK7deqf1kwHw@mail.gmail.com>
Subject: RK3328 / ROCK64 V2: I2C0 timeout with Argon Fan HAT (rk3x-i2c, kernel 6.18.60)
To: linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am investigating a persistent I2C0 timeout on a ROCK64 V2 (RK3328)
running Armbian kernel 6.18.60-current-rockchip64. I would appreciate
an RK3328-specific review of the observations below.

1. Hardware and software

- Board: ROCK64 V2
- SoC: Rockchip RK3328
- Kernel: 6.18.60-current-rockchip64
- Driver: rk3x-i2c, built into the kernel (CONFIG_I2C_RK3X=y)
- I2C0: ff150000.i2c, adapter i2c-0
- I2C1: ff160000.i2c, adapter i2c-1
- Argon Fan HAT connected to I2C0 at address 0x1a
- I2C1 has a PMIC at address 0x18

2. Device Tree and clocks

Both I2C nodes have the compatible list:
"rockchip,rk3328-i2c", "rockchip,rk3399-i2c"

Both are enabled. No explicit clock-frequency, i2c-scl-rising-time-ns
or i2c-scl-falling-time-ns properties were found in the inspected
nodes.

The inspected driver source has an RK3399 match but no explicit RK3328
match. The RK3399 compatible therefore appears to be used as the
fallback match.

Both controllers report the same input clock rates:
- pclk: 75 MHz
- clk_i2c: 150 MHz

These are controller input clocks, not measurements of the physical
SCL bus frequency.

3. Reproducible I2C0 failure

Transactions to the HAT at address 0x1a consistently time out.

Example write payload:
[0x80, 0x00]

The trace shows:
- The I2C0 transaction is started.
- The rk3x_irq handler is entered.
- rk3x_i2c_fill_transmit_buf() is called.
- The transaction eventually returns -110 (ETIMEDOUT).

Dynamic debug captured the I2C0 interrupt pending value 0x90 twice,
followed by a timeout. No subsequent successful write/STOP completion
was observed in that trace.

This confirms that the request reaches the interrupt handling and
transmit-buffer preparation path. It does not prove that bytes were
physically transmitted on SDA, nor does it establish the electrical
state of SDA or SCL during the failure.

4. Comparison with I2C1

I2C1 shows a more complete interrupt sequence in the debug output:
- ipd: 0x10
- ipd: 0x05
- ipd: 0x21

I2C0 instead repeatedly showed ipd: 0x90 before timing out.

The inspected driver defines interrupt bits 0 through 6:
- START: bit 4
- STOP: bit 5
- NAKRCV: bit 6
- REG_INT_ALL: 0x7f

Bit 7 is not defined in the inspected driver source. Its meaning in
the observed 0x90 value is therefore unknown; I do not want to assume
that it represents a particular hardware condition without RK3328
documentation.

5. Questions

1) What is the meaning of bit 7 in the RK3328 I2C controller
interrupt-pending register? Is it a documented status bit, and should
the driver acknowledge or handle it?

2) After rk3x_i2c_fill_transmit_buf() fills the transmit buffer and
programs the transmit count, which hardware status or interrupt should
confirm that transmission has actually started or progressed on the
bus?

3) Is using the RK3399 fallback compatible entry sufficient for the
RK3328 controller, including interrupt handling and timing
calculations? Are there known RK3328-specific differences not
represented by the generic driver data?

4) Is there a safe, non-invasive way to determine through software
whether the controller sees SDA/SCL high or low after the timeout, or
to capture relevant controller status registers without disturbing the
running system?

5) Is there any known RK3328-specific I2C0 timing requirement that
would not apply to I2C1, despite both controllers using the same
driver and reported input clock rates?

6. Scope and limitations

The investigation has not established whether the failure is caused by
the HAT, the physical bus, the controller, the Device Tree
configuration, or a driver/hardware interaction.

I have not established that SDA or SCL is stuck low. No physical
waveform measurement has been made during a failing transaction.

The system has been kept operational. No raw controller-register
writes, forced bus recovery, driver unbinding, or Device Tree
modifications are proposed.

I would appreciate an RK3328-specific review of the 0x90
interrupt-pending value, the expected transmit progression after
buffer preparation, and any known differences between the RK3328
controller and the RK3399-compatible implementation in rk3x-i2c.

Thank you for your time and assistance.

Best regards

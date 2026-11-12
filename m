Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794484501;
	b=q5SLC1ZB5oLQdpWYB7R68B3DHW9mFJaEPTV19dymI5kzkbxMxX5vLBpDwCFMDSRb+HKT
	 2//hVGy2p3aWtiLxybs1H8nKSHwZmitFqfW6t5iFybpaCEkcuVdKFtWOeol6Lajc0Cqe2
	 4Svrkpk9AYc3hFAXJ5taEzaPZX8QOSbpBnKgRds4Mhnqs3rEi60VCdX6nsazSYoOJRoMW
	 Gzqr8gavlwxTD7tV+vLBuLm5uX1229jTe6640d6a58dZglS/I1YeGOvtospxfTvf/L22Z
	 qxaFhA6EbrchgJhu3CGS+mOoM90DWbtC44HIdZbF2Np3nbtZ0fOcuiR2CLsDJSLlg8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
	b=z7nH7wmIXVxx7kGgn0DAHBTTcaYXmWKkWbU7O/j65SSKdng/gk9boxlbblx0yrggR9hz
	 J62I07tDSf2VVWmLWVyVtHuJ4hKX/iWeeAruY6lNv58i5MhnXAOra5jn73xMm6Z+9OQ0l
	 EXgow/0bE46SuOWWkinr2unBN7UHQe8AN26SD0r9YlKzGjSpJvQOYjLyfstLOs2NqjJCD
	 2iNsLV0s7FBBTwzs83ct9Xa6o0jFiljHgHdbKKUAQ/V0+OR92Agkw0mYiN+Ul9P0DnUD8
	 OmwhxKDCAffgzU6R76RQe5wsHveYXOQLn0AmFZm8eRm01oXxQYKJQCswF54cHKNHM9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cE59H31y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7924606A32D
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 11:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7924606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cE59H31y
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b335eeb340so35886467b3.0
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 03:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794484500; cv=none;
        d=google.com; s=arc-20260327;
        b=QX60TG37kiDljfUuCvJ8Bso0Eh3fowrUTODZL9lnE0jSOuMbpQizNWtbiIFLYM0OCD
         f3/RDy36W6SICu50xWoIeR9ZzxIOFxcQLMLUY8hSNWmgvH9BEww8geGlVmdL6ihxMs/D
         wrFnPX/hSM4PhqlzX/2BGtRhJ4NnwIuMSjt4FYBGOnDmIgA09J99qZ2c0Rz2WFU+s0tD
         va2vnLnhzVD8CQgixx7lBCm/D+kYKObNwdgRIRhmEROehrK8va4YrnyXQXW4DGa4jaXV
         xZSlQbjEv4rvnbB4D7j2EERDP7hdMG3sxGCMW9puafwplLaXKRVfSNYl5kSyKdHi4aci
         lvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
        fh=7RCDoAo3uZAe8F3MBmbC/d1cw2xPu06bOMnvHKb+UOc=;
        b=TlfScB+ycZSKIJN4vIv1MZpx5vnQEk58EVC59fMb79cN3v4A2YIcN8YHb06Dwd9M60
         GhtXqr1gfa/eQ5D23tgQ37BZQAefFObhYJKVyN1F5LX+hsRYLCoCqTmiEvoyJQujFq4D
         f6N6EfH1l1o66DFrc7x4Bw4f+7nhp/U6ChW8i3Pfm5ERKiSJv+10cx3oQs6423keDpyR
         HxTHqXxytarXOap+RMZbAd8H+By17IKIpF4/QZxDOvZypBIMCijIRZ30YvL9Gcslvye5
         0fIlLMYEwTC1eovEdBxK89ESt0kkdA2LkJWGsNKZtK5jBLfSbLr3XwJq7NbxkDFtmLCQ
         hwgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484500; x=1795089300; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
        b=cE59H31yJMRud5Qz6OEiDuEj3rrFtded7WJRkwUwpZcSiF5Zf29OLFWbqYmKTfbWOA
         o3jqlofdHFFv+dlfN3AmWItEgOvjYmRD0hJYoX8WSXtLy1CDhe4iGja72xHmA8Vfeisl
         KK6C7+c0COtNqijST2pr1+LjEQyQ4Gy/MF0NTcpJ5JdWneiWE648w/Xmnvuu9AFEbO0v
         XL4UZQPfWToQhpKOiCyjKWueyHh26tKiF1HSjM806dZpvycDXAH+RBmbof18k+AD8ank
         rE/1/YNKvBb1It5zxZwPTpIYZxmU1aBmPNVorgwRbvHfWjzVOWSoGioDwZTjaA2RSg93
         zVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484500; x=1795089300;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYnLQqJvBsP6aFfbT+g6Y59qF51TrJQwUhwSuZqsbN4=;
        b=Lkos/C564VtjGIG/AkMjI3PBxGZ7iuDnxT+0ckUslS40ISxa+FTP7ZsHdTp4VPCVaM
         M9Grc0ZbzqtKBC2b5lEXuBHFym/5HpoPQ8mQ9J11U+1e/go4SY3uMimenuRZ8jzQqp4I
         vu7cDnc47NJlPqX3mQxftdRqtiYCJqmYQR8pAFERYM3/L/ZR4jLWlUX+hqJu60aIPPD7
         Wuzl1rBOwPhMmAm6fhJgfLzutOj+wk9b4Xjc8q0AtU0ZtlpO7mv/F6YMSF0a8l6yfxKk
         uz6cM+zcY8MAfdEh6ZXsqG+G821ZcVrONKbISg88TM+yKL7lGkg3/BotJCKzW3nREbOy
         fZlw==
X-Gm-Message-State: APuU4Z+wItlu00Iy7WXYsuiidW1GR1FvkiLFoP++QUPy9sQROAJwXn4f
	YZ5JyMEtVAGmgSVd6G8FDw6StDOfeZFpzwW1DszAoQnRy3CxX8K0tzqbkVkL4rzpm0wDilOfSEI
	B0DuGsVxlo2NJbhWiQY5tKClek99wVEDviypibTo=
X-Gm-Gg: AYBFou1St8JzVsDFB13SOh5sS0i/gDMBCyiWjDf6u3CKaE/Iaf+SGOVNeBQu7QRhk4Q
	WZIQMG3V/qBgxnUGOj8fp50g5NsG47zpNtSn1fZ8I6PWwpIbFkXktuKEHyzHmzkQ2fg18mnWYpc
	3RJbrnMTbGxM6LGtCxggJYzbOpPh0XpJBP230WEmov7CFuLczozJ+pbRpy8WYgD909bxO8JpS3u
	8iyrg1/QwWGztnKBAYFnejpoFOhCGQTiY3LikSkzQqoX5M/jnHgl44rrZICU8INSqvwfgUg6xUh
	hLbbd3Hl3GpNltC4PZexCMqdkNeLSq8L2dxMjCkgZ2cD2F0jDzKBvWiV0BRyFTc8ursynD1vAMx
	N4G2yj3m23I04olcw/tOUOetKZ711mUGpKb3fdAa1rNQJywtclTJatFy/6S+2tfQ8D/1s2c2UX7
	rSbb/2oDan+Is6kfIE
X-Received: by 2002:a05:690c:fd3:b0:8b3:5a55:5e4b with SMTP id
 00721157ae682-8b3a810fba6mr33535617b3.56.1794484499767; Thu, 12 Nov 2026
 03:54:59 -0800 (PST)
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
Date: Thu, 12 Nov 2026 12:54:45 +0100
X-Gm-Features: AclHuK_-nDBRE9BBOepLRSzwa3gT07siKZvXI7toLM4fLj0eUBkOtS9WU7VvTb0
Message-ID: <CAOUhbenp+ugcJ2B7v87jjigKcSeWAVrmNrD7RkLGi648MDx+_g@mail.gmail.com>
Subject: RK3328 / ROCK64 V2: I2C0 timeout with Argon Fan HAT (rk3x-i2c, kernel 6.18.60
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

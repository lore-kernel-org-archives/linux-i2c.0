Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370752;
	b=LZWzjA/aNf9w/jX5GvrVnjggyS7sn7/hpwU1pX3W+VFCS3I8sOs9HyQC7QVZuIThDBSJ
	 S4p163mmPOaeYJaR2XOshP5TUrTXOCn94p0CycTs4zTOJHj1U3l97CFg+BtGgJSOzElJO
	 RIu9gtnr6IyDZPwrI5/6JvsyexPf5L9q8fVw9sqQaGXMDqxLrgdHb7vsB43J9LSOZvZWs
	 FqFC7toT9uRoUtEGQFU2TlwiYhc8hUak8jKPi1fONxphSDa3+AmVsj2Hqs9jB3GoVt83C
	 a7k1V5jcDaV9DuGUtALv7rMtw7AAR9bmPQWLK9shrMDwHF0rlsYSsa5WXzM8QwdvzQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vu++8Ba/Bm4EE7sdE3e4HVCSisYhXOFP70NUkQ2QJtY=;
	b=QcFqdth6dJcirHAbU/rDSMgvHAtquwXvqHjDFLmoOKttbmL34npO+SwyEaq3ktDpW84j
	 SfCk2uq08EhScwUE6vBSW7j4BqbTgnJd3WhRzHYnwCWYYaI+JdCeUv1/BobK9g2pv7YCH
	 goS/O9yUkf8IyN09P84DBlBiFddAnKlcOyz3UxUbiBVmSnfLm/D6szbSNTH16Y/9pAmb9
	 nDdmYECeiA8tsxxO/qAC/mWelFqkcKPmpfuM/v1p4+3/9k+xvH3Vee5O/sc3e7satXNHw
	 ymNS2TQCZRhnFXuaX7r7/bHZGoAObh7nLcyIHpNELK4yKoDrnPM+aC4dBTIC4Xi019w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=btOAr4KX;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284AE606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 04:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=btOAr4KX
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3720addb068so5037880eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 20:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370751; x=1794975551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vu++8Ba/Bm4EE7sdE3e4HVCSisYhXOFP70NUkQ2QJtY=;
        b=btOAr4KXKOXZYd6QGYDneGd727rwdK3NisYiebGEWByer2tQ7AqTluKE+W1Q+0bZ43
         og52mf+TCcVjX7LTOzJDiXB3C62cdthQEUjUnucOLOfz0o+wLrt+wcxRFjPzkjT89fD/
         WhuEb0DqxKH0IKhe0Fq5b8MFiJsKe1UfWfJJJhuMdFAbAgnPkRGLyTadSc3AosrmW5W/
         704YQv9/F5ogaXmMWjYgIVdyxhIO+TsGXqp+aBbZfu4ZK1KdOuAjVQPXBvy73R0PGFCg
         DeTNbbpBGInZHIB9lUJa4yX2pb9vh0Q5FipvPAaWd7JQJjwDGTP0heYOvcSPPRQ6LGzE
         Y3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370751; x=1794975551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vu++8Ba/Bm4EE7sdE3e4HVCSisYhXOFP70NUkQ2QJtY=;
        b=h5y+S+wm5ga8WFfdV1RbP/Zd1uiuJSQ239CcQ3g0/o+omfcRKEhVmYAxwwYNWEWXCl
         ubeeq1VpZjc2JkMgKd0VNOeKMVAH7NLXb93nsNy4b6JojiBCD0d+jPcyJpGiMDjTTdsC
         WxW1KIuCOB0S+YWkbt2H5PX2+cuNSh+Rbl7U7vAcAf2RqsZvVT/+iFoUtBfi5ieNvojc
         /Lif0Mu4TWmM6j60ESLF76de7ckM3vuKfYXYvboiSMD6z8Ln3T2Y/6LIKfqn3xWHJcDP
         7uKOeY3TW0YoAV65vdb+Prq7gj+X1t9GTf/w7Cg7/ojCIJyMIN4oBZ5y63v+U0cn+eBc
         5y7g==
X-Gm-Message-State: APuU4Z98e5rz0R8jrKYGBMwxTiDHVsvnaa2PAvMy1omrnpgSlzdiGdh7
	/OQgkGhqMut1m8ZVl7i2DcUx6pUDQs4+DblNzR/bJoLAWwoZkgySFJdZ
X-Gm-Gg: AYBFou1SL3HfLM1149S4hLrBeMRo3HW709RGkhwPJgv9yFajjpWgRS/Ctw5bvvLvC+w
	Ls+ZqrPB8F0brubKstfZa1vGXxedww7Hcz9PJPwjBsqYHalpBC5GRrUmEqzCJTibYRU9gmr4EY4
	TqklH0GCjYSwcOL8KQDzyXgruvGJx8tZ+4grAbljha04OgKy/Ioc6Of6T1jYDqOa/ufKn5nx0zI
	UIXONy0MOZu+fw4i2LrKTbTqXXcs3ihV2t6/q3t2IvAJDCliJyXfPv0kg+cE7B4yq17iK7hIaM0
	pxrw9lyRZsNw5ZaRNbdS0aCNCG1KpQASBBZankSKz55X79XHUJtwvPMY0MpUoxcauttYUkMQWfc
	9Zzrp3vQq45nohGaeaOeXOwoGua4sNtds/nvB8gDC1fEzgSSI3Y9Kr99rzrXQcgmmCvOmdXUSss
	xU+lcA7T3TRqjcrswArogMPu/YBZS292Jrtr5YE87Urm/5nevkbamNomL9QJtLeQYuMRenUOKZF
	JCRtfckvqo6SL7TI1TEFWidBTSREeYuZELDSYBtQdUJDJA0Cv0FFAouhV44E7GBoiRisme3F85s
	lGD5AFmhVkV8yFHcWDy8+TnQ3s0coPUh9gle+ZK6BKr0zFQiVNuS8P2mZKFoQBRB9xL/SZ2dt7e
	GcE09aG1FKZ0bAqrpMAYhdjVGLhgG2sqIaRV8uV2p8LgiMjme4rt6kRempSoKoCKXuqtK+YygZ6
	LBhVGYodKlqzaLLqhcGg==
X-Received: by 2002:a05:7300:6dac:b0:369:f9da:a70f with SMTP id 5a478bee46e88-37685b7f916mr2766572eec.17.1794370750970;
        Tue, 10 Nov 2026 20:19:10 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11820704eec.15.2026.11.10.20.19.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 20:19:10 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org
Subject: [PATCH net-next 0/3] ptp: ocp: support the WiWi production Time Card
Date: Tue, 10 Nov 2026 20:19:00 -0800
Message-ID: <20261111041904.48916-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The WiWi 2163:1008 card has a Celestica-compatible register map behind
a LitePCIe bridge, but subword MMIO can cause a machine check. Teach
XIIC to use aligned word accesses on request, test both access modes,
and bind ptp_ocp only to the verified 0x800f production layout.
Other boards retain their existing access modes. WiWi devlink flash
updates are deliberately unsupported.

Patch 3 consumes the platform-data field from patch 1. Can the I2C
maintainers Ack patches 1 and 2 for the series to go through net-next?

On the hardware-tested base (4dd16e31135e), the driver bound with
64 MSI-X vectors and registered the PHC, PPS and three UARTs. The PHC
advanced 3.000429460 s over three one-second reads, within the host
monotonic brackets. SPI NOR and two at24 devices bound. The card was
UNSYNCED at probe; no PPS lock or UTC accuracy is claimed. Rebasing
onto the base below did not change the driver sources or patch IDs.
The rebased series passed x86-64 module/built-in and i386 module
object builds and four XIIC KUnit cases in x86-64 QEMU.
Full W=1 allmodconfig and allyesconfig builds encountered the same GCC
format-truncation error in lockdep_proc.c on this series and the clean
base. Neither full configuration is reported as passing.

Codex assisted with the driver changes, tests and changelogs from
the supplied board layout and crash evidence. The net-next series
does not include a firmware update or front-panel LED policy.

Ahmad Byagowi (3):
  i2c: xiic: allow platforms to require 32-bit register accesses
  i2c: xiic: add KUnit coverage for register access modes
  ptp: ocp: add WiWi Time Card production image support

 Documentation/networking/devlink/ptp_ocp.rst |  35 +++-
 MAINTAINERS                                  |   1 +
 drivers/i2c/busses/Kconfig                   |  14 ++
 drivers/i2c/busses/i2c-xiic.c                |  60 ++++--
 drivers/i2c/busses/tests/i2c_xiic_kunit.c    |  88 +++++++++
 drivers/ptp/ptp_ocp.c                        | 198 ++++++++++++++++++-
 include/linux/platform_data/i2c-xiic.h       |   3 +
 7 files changed, 374 insertions(+), 25 deletions(-)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c


base-commit: 97ced2c090bfc2156db31fca9f52cf253e4bc186

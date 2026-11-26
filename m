Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699920;
	b=FHTtA/lsACEh1oTGtliWvIA2LRHVgJzdsUdqjw9+59Y3ieFfGA67Cd7b8b+SzLj89kZB
	 l2tcYmP1/wGXzEtv7RsgJkd6s8DmPKsr2c5ZV85kb7RrkEhoU8L7qvOL1eSyMscLNqDe7
	 KteVBwyncnJOTdc9UJ9ApIAXlLp9JthMMeLvgQBVz6xWe2813TlKc+X63G4K2XMa+zt2m
	 N0AfxxYSgwD6oySNoBsD9dpkOuCkKjPULqOn2NO8lLm5P+foL0bbJWqREqtrZkre0P/a9
	 V9K59kNHUAjy/dig0FJY0lG+dELNXRIW7ekyzDcRlUDY2cP+pX2uPpqQnZcOjn0FtUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O61FDlwjHKBDnCTbb8aWwb1F9/n+IACrfnZVxf0Y28A=;
	b=P7bcrSKnm4ZVjh4Dc+5azfTIMudHO4ZRHCvu5ptfrNRbNdEw0D69oYyUMruPqdQCGxxn
	 xzP0yV8B/eIwT9Epp2P15iWDLx/6aO6icGfkKFH8JQlbPFw2xoATmeFSOfdqj8q5JVxPA
	 bJdBQ+7Rz2io2D1iF1nx/q2zMl6DJOOqx1VYLIclTpbdnE5LHylgiBZaF+GiKybd7mr97
	 1xpwE5L3eHARteF2e2rwtYCXwMt8DDo4zJSpaSOoJK5jl5ZTz+9aL8Mj6kgeenOj7OZdk
	 ErtrYKZwkPthP6xf05dOCoGu+Mwrf4qrU4gxheooL7W3QhQHdrp++tu4X8SS1sN09rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdSwlU8B;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F1606A33D
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 13:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F0F1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdSwlU8B
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2af4c8d00so6656347c88.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699918; x=1796304718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O61FDlwjHKBDnCTbb8aWwb1F9/n+IACrfnZVxf0Y28A=;
        b=pdSwlU8BdoCVHBBNrELrT0pqFgmmPZpC7zzITXacmHK/w/QFes/gumIDPg93npLdjh
         W0f6aU0w7gB2faGLA/43zn9xB/CibYNQvB5Gggca4LYwEOQEnxhUvgiYAa6aor35j+Un
         jJo4fl5fsax6zJXFwezfZoE/uVUMVjehew3PY26JadHcJy8a8UrO5ZJzRvxSYuZu4Z37
         9e0gUUtck8cc1Ax45OZ9H97uq6SJgsQYNM1PJHwzT1wYoJZTapkquURbS/IamMHVawwA
         Or+fX4lQbTr2qLguralc1DFjjh0f+u1jCVeEWzc5NySvxdjC9LGSgZbtLA54/tByKdNZ
         +j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699918; x=1796304718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O61FDlwjHKBDnCTbb8aWwb1F9/n+IACrfnZVxf0Y28A=;
        b=OnN+Xn3grvU1EKB9txtOezVN5FFlZJQsr1g9JpAh7R9ZMBJ2JdM8QBHQQkmSsqVmd+
         181nrDAVmScLW2UA2r92aY1aWBALZGGhH6hxy3T6ge6+sjbRTTXyjXUmbLJidIgE97/u
         BEImHjDrh9UnBdZ1SrvC3ZBlwUWZz/LC2yI0KZ0X6WKTdmvTm7ploV9c/W3qj6aPw7kU
         hv38JM8nvr3NmV3ym5F4x/e+R5focdWx+hE6u8jbthon3mEAjq3mCorfptSA7CBccGfm
         LKwb0Op/vX4J2whv97WlTJx1dGrza/Mya1QEwupsbBW6i3ctsTeH3BE2/wIM/FlG7ulB
         AaFA==
X-Forwarded-Encrypted: i=1; AL+hErHW26/rPG9ef0qtfMQ+FawJErtR8I6dDP1gKkCBoDP52KFSMsNAK7NcybWdu4M7EWVbqYtvP1xRMmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8utbWb4zvsSyhPRTM/6RwbyLQEv7Ms+DjUxRtKhOPiTIhW5FxN
	zEHTXXBjzIZ7fG+LeI3lcjopOMP4HltN4gxjnrOV/zvm3NGq6V/0ngE=
X-Gm-Gg: AZFdTZcxr1hfIxYnzKmDiLI5Liv+x/I788yzM7i2X/VpoxE6M8eJFR3xoTXqocxyzul
	npnOLBxvtKyiEavhZqSerAj8jsQYe3rC53Y6lpZV+oZPqC47JrrPazb1DlaILxT3ZtEWsL6+PE7
	tdpA279DMJ3Z1q5cXvaQEzA7Jv+re6MAPn0sYs0edPgogopxn048kKt+iBo0KS/j/nOftRjcCYW
	myb98R4uT9Qz+p42HcvtGdrpsGiVEG1zu+1rQshIzRV+kl13pZMFXDjJEmeh2lG9ZRp+MgTK0lf
	BoPCFlT/Z3R0xwmtS8GRqfOKb/7Kf0aMFB1Wf2EcFzkNkRgza2EWRiVlc45tgaA3LUBWmMnVAsg
	mKHl4ZItuB+erdh/6OdPaUW6cJNDyh5CZyzef6ZVWgClSMeQWiYn5qEYofRqZvma6UndwvggQPo
	1zUdMjEZb0hpQrdo4TzDyMMOPacDGUuNdbHyTsJsm0PLtgQV80RUCQ5+CBXDP3XCYVPF22nw3I6
	Xb5jYN+hZCYX5qfLMc7P4DYVbMUF1vnns7Kd3EtzB+u3hYioDRahHab4X0bOCy2cebe6aAKQbiq
	CWqVNXe/sqDcIb6obFVCH6nzERALZWRVwyPn4fba+BWMv+71TStrqtBSPahfflBZ6oE=
X-Received: by 2002:a05:7022:ed02:b0:149:50cb:2175 with SMTP id a92af1059eb24-1b5568fda53mr20186467c88.33.1795699918133;
        Thu, 26 Nov 2026 05:31:58 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm22321547eec.17.2026.11.26.05.31.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 05:31:57 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: rcar: release DMA channels when host notify setup fails
Date: Thu, 26 Nov 2026 21:31:54 +0800
Message-ID: <rc-b1-20261110-vc-182-eee62ef398fd@gmail.com>
X-Mailer: git-send-email 2.50.1
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

rcar_i2c_master_xfer() requests the DMA channels lazily, on the first
transfer that finds priv->dma_tx or priv->dma_rx still set to
ERR_PTR(-EPROBE_DEFER). Clients probed while i2c_add_numbered_adapter()
registers the adapter can already issue such transfers, so the channels
may be held by the time rcar_i2c_probe() creates the host notify client.

If i2c_new_slave_host_notify_device() then fails, the out_del_device
path deletes the adapter but does not call rcar_i2c_release_dma(); only
rcar_i2c_remove() does. The channels then stay allocated, together with
their DMA engine references, after probe has failed and priv is freed.

Release the DMA channels right after deleting the adapter, in the same
order as rcar_i2c_remove(). rcar_i2c_release_dma() skips channels that
were never requested.

Fixes: c4651f11d09a ("i2c: rcar: add HostNotify support")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_I2C_RCAR=m, CONFIG_COMPILE_TEST=y (object only; no new warnings).
No hardware or runtime test was performed.
Needs a pre-Gen3 R-Car I2C node with the "smbus" property and dmas, a client transfer during adapter registration, and a failing i2c_new_slave_host_notify_device() (e.g. a client already at 0x08); no in-tree DT sets "smbus" on an R-Car I2C node.

 drivers/i2c/busses/i2c-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index fcb15be59cb5..b5c964c367e7 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1241,6 +1241,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
  out_del_device:
 	i2c_del_adapter(&priv->adap);
+	rcar_i2c_release_dma(priv);
  out_pm_put:
 	if (priv->flags & ID_P_PM_BLOCKED)
 		pm_runtime_put(dev);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47

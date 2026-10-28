Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201678;
	b=yRmNUfVFqzebCkBvztOCJ58QeT2BMD4JvTZn98X/9E2VK3QXF/yeotd3cZVk8pVXuT1Y
	 84LCB+oMBVKG1Da7nA6NXjsurPFmAhWZmoj1UNpz1KrI2ckIZtyHXNRrRetaBBeR9HNeX
	 j66JTZLFIudMkkwWOJ90o0lDwxbPu0pPNx27JAZWESXv7k/CjDzLgzrofVuWyW+x43dys
	 a8Eh2DkWNqOvmENgqMT9lolrSiCAvbHM+4SRZgS0FGr1RQE4ge9ZNhlVns4WMCqYvHzGw
	 ZOaz0Yzy6kTdDzyEFs5CNk9BsCY8oeB6lCnNxYN96JKpA8NjmSUF0gnxAK1RELxLuUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nwQvp5gT0x4Cpwf86+olDk4WVML2oNByPo4ORkg5KCw=;
	b=oHTXJ7by0Acv+NnrRLKCPFb1hkMPexzeB4jjoJaeXMMucYCxT6DbVZQ/MD9dWiJsIXMH
	 dIfnM+72Ka9Xe2QNZf9TdG2A3cLP1tBZf9ERLxRQHJsYaeiFKLbUVxdapoNOJnZ463Rfi
	 P4cKF9w9vzyXvuTjLIrlRLE+andU1qg+15XtNyaqLuDfJfef3sJOh4iiKq4WFd6uqTI8S
	 +wUYSEkXYtmwkjAQlCj9NsDInzDkPyskxO3gjrAtoGTkUbPFJkA/eAefpfvWBAT7e2aiC
	 b/DRlLvII3MxAosY00kUmn/QmCR4Do0GEh55R1Vh6e0tly12mF5l1aF9N286Qw2ZAyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQMZ4hD4;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6A606A321
	for <linux-i2c@vger.kernel.org>; Wed, 28 Oct 2026 15:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B6A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQMZ4hD4
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48af4ba4425so37032f8f.1
        for <linux-i2c@vger.kernel.org>; Wed, 28 Oct 2026 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201676; x=1793806476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwQvp5gT0x4Cpwf86+olDk4WVML2oNByPo4ORkg5KCw=;
        b=CQMZ4hD4sVB4t0bzFakBLUKjDTrGYS3mdtMI0Mk9SqITBCUJ/Q5kUsVwo/cjdYl4r2
         Gj0jSmbHV0IcRDbeLEBRdiwmYy/TNMa2GgVWaNLuOEQu7p/KcrRi+NDnoxlrCtoGmnCf
         iB7fUXehopDG3JisGR1WTJio6CfokUl6bMkicidOn2udHddVNf/YNyxFbsOgoEhgCG3l
         SKFemmXOBmpAZzo/oXCybTSVoMI3mlXcweJM8J6iZZ3F1gg69y+WRkI3JkMB2k5uslJo
         Q6cCnuME7SfxFb98pVAlp80QGk9J/k7wKCW3HE3uPvCRav3rOG0jEQuGee/+B6/Vshjy
         szdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201676; x=1793806476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwQvp5gT0x4Cpwf86+olDk4WVML2oNByPo4ORkg5KCw=;
        b=ql2ZE6uix9hzPpTceEjQ/fSXgtaNfwGlEdWqfWnFSaXQYkU0k8jJBsTpfqfIiKPaW9
         JLimXgH/Op7qfMj6/8cC2JDvdZ/OEqe0cLxD25bDHns3m45ZLqKpOqQtwLuYQ/FIOH14
         dkXbjpg49F0uBEzMRRhjjFppPJgqaquvJvbo1Hv6wIauD3dVRnMKio16ieqHoDR0UC15
         cByGyiC/NTuswmqafR41VmKsVwJx/T97wPOVms0NEBjGGf8rUlkbnzWb7liQu/tZIhaT
         TKMqJ4rES4qtI1wJ/f1BLojeTKm2eW1IqMJQBpyKlH8FM/xXN86KfI36jui0NvkRRuBr
         U+KA==
X-Forwarded-Encrypted: i=1; AKwUvBykTU3C0wshRaXR2Fe4fgFAZsC6/H24xbCVXhGjpdEOAwHMsA+0fNuTlNuiEqRzULi3gBSmyeDBvxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGQAXoyIOBT5yN4h8L4QkUWzEVqXRIPlRmjgUQWDA1xoJy+1iq
	4JvzvdnD5YGyhrqQcQfnqY4SEsNoTcEcFzsd/JldOIGQ6eWJps9lRgCA
X-Gm-Gg: AYBFou1xnmGTFt3x+ZE2Ps/+mG1b/Dbife5eZSZQjz7y6IcQiPDEpjM6tNnry7xCa0t
	oSiu3iMMXLzP1k+einDUk7Z9ztOjeiThF0zQboxOMjjzuZuELm6ltFloGmrA8QU1MNTg9SUQ5yG
	OPd3MXGFFvTtMPGA/mLeqOP5CQr/9Sos2/Zm7zuGgHeDoSqaFmIkmvEQzwfpS55qDH+RmxjUjhI
	KK6Z+lvClBAPvDSAA/1R6brlJVyo5R73h8mLa6ajKTfOXwff8j/tJRClPOfLQ61m84mgMNyprSe
	e8NDZwsop3BxqGOmRFmV84XQgZ48nSFvIRKYs3wUw/yP7XgzME387WHezPkG5rutxcD9lxOXPNj
	GgcEPizy/CukGIFjox1Yfm5ZXmT1t9OSOFJjyaSxVje1s1e5aLuAq871Qxfg8Iwv09PDM3TLFPa
	cgreSVZgJbJ47E/xMyDeMO+ZJrrGRB4fa/BLs9oLVAoDDhFvI4Pb9GzbKoKE/VL0EgwBeaNaadu
	RGO6aQUnx2c/bWs7KsMGGmOiXXJhcRYDs2eMAmFEBjTgjLP8LxJ5Cq975zqB558y77ucGNDZxpf
	wlitcToZlry6FuFk6K41s2kJV1GbJFFG8Ph5sKu0TzLCu21DmLNpq6FrIdZVZPWgh5Z8VR9iz1w
	sxeYsmF01W0BV1kIyZ9eoL3k=
X-Received: by 2002:a05:6000:2ad4:b0:48e:60aa:793e with SMTP id ffacd0b85a97d-48e60aa7a9emr3918828f8f.3.1793201675959;
        Wed, 28 Oct 2026 08:34:35 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm14428423f8f.13.2026.10.28.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:34:35 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Akash Asthana <akashast@codeaurora.org>,
	Roja Rani Yarubandi <rojay@codeaurora.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org (open list:QUALCOMM I2C QCOM GENI DRIVER),
	linux-arm-msm@vger.kernel.org (open list:QUALCOMM I2C QCOM GENI DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	dri-devel@lists.freedesktop.org (open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH] i2c: qcom-geni: fix double free of the DMA bounce buffer
Date: Wed, 28 Oct 2026 16:33:52 +0100
Message-ID: <20261028153353.69651-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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

geni_i2c_{rx,tx}_msg_cleanup() release gi2c->dma_buf through
i2c_put_dma_safe_msg_buf(), which kfree()s the bounce buffer when the
message buffer is not DMA safe, but leave the pointer set. gi2c->dma_buf
is only updated when the DMA setup in geni_i2c_{rx,tx}_one_msg()
succeeds. If the setup fails for a later message, the function clears
only its local copy, so the cleanup helper sees the stale pointer from
the previous transfer, unmaps it again and frees it a second time.

Clear gi2c->dma_buf once it has been released.

This bug was found statically and compile-tested only.

Fixes: 357ee8841d0b ("i2c: qcom-geni: Store DMA mapping data in geni_i2c_dev struct")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a431e98723ef..78701310936b 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -500,6 +500,7 @@ static void geni_i2c_rx_msg_cleanup(struct geni_i2c_dev *gi2c,
 			geni_i2c_rx_fsm_rst(gi2c);
 		geni_se_rx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
+		gi2c->dma_buf = NULL;
 	}
 }
 
@@ -512,6 +513,7 @@ static void geni_i2c_tx_msg_cleanup(struct geni_i2c_dev *gi2c,
 			geni_i2c_tx_fsm_rst(gi2c);
 		geni_se_tx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
+		gi2c->dma_buf = NULL;
 	}
 }
 
-- 
2.53.0


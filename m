Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700674;
	b=vnIpD+usaJHIEOe2i2D53eDc3jXJWdayw+zeh1v3Om4kvqudHZZeHBVdHJ99v98VTJL8
	 Uydno63krIdO2NgN1fAP9+RnAk3iRnrg7/RBAWbCYKJ5GIrBfZfquNTm+EXWzoeMKfK5j
	 HL3kqOCjeFpwPEyW9twsdqElCuqjBZ3aNjWheKl4lv7oMA8hCuIWEKMVjZAR7y0VOt14a
	 G63E3UbApzZe82pbkMKbFb1kVxtWETDabWpadb1mL7U13v3ZD30mfLEhl1qxsryk5EIBF
	 153L0mT9FI6gr1W98KNNdg4tRkypOSPOgge2uxBz3pRFG9sNNr5H2LtJTqEgiSR3HyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700674;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=jY7SRS8EY4WvgV5Hy1de+tHZT9Z4JJSU2OV+0aUvWLY=;
	b=vDrN/sXRWXIX1egKRyawhclzYvUTn8QfSpCOmEAsv3sHq5k3gaLiwIOP6nGPtq12Djm7
	 +JXaichv8DFwaMWDoDh8osO6z2HMML26s6Y9gJL9ccv7qjvze629+i4pZXw4gMbE7uhum
	 faom9u6ovtjvLRP7mG+fZL6R2VJPNkQfktaUpxSysSPXXmH7rXvS0W7atndAHXT7mNrsy
	 9jL/sJEgWgk2NW7qhmg/t9b87E5oJ2OkvliHl1JpxOVe951z2FlXVxiO/MQ3BCru5Xkru
	 dFQksDd/brBIWkwJMupbuDyk9ahS6TLNUTGiRAuTZQaUuMV+ENpJPjtueacPzOPbZSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=ks9M+NXe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aJHgQI0K;
	arc=none smtp.remote-ip=103.168.172.138
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E519606A31C
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 13:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E519606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=ks9M+NXe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aJHgQI0K
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id 7A40713803F4
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 08:44:32 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Thu, 26 Nov 2026 08:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795700670;
	 x=1795704270; bh=jY7SRS8EY4WvgV5Hy1de+tHZT9Z4JJSU2OV+0aUvWLY=; b=
	ks9M+NXeZToCkNeyCEcOiO57Vrff20M6XgsDpWwrzz7/99elcZw89qmkkNU7a8XF
	W9knFLhuXGK5+nHGGqTzHbcNNrAjH5T7S6wKwx0NhagvoKM+3vuEmzAD2UBbK7BL
	lAY6zCiBnAeiawp6a5hPfjsoYWe/eMmx4cgKjN+dsJtPteiJRAsCP+AF9Luy6/9p
	97Ycl3hRWouLImTT2i83xFXLuFoPBdf4Ha3hI+0VAVw1RZ0l1mFrQnAkJOOWy+Lb
	vGqI0JoWdgEzBCkT0dtrf8uThSHpndUoSSFcQPAExQYwPVKx3Z8nSfUQ1+q4ta3m
	TNMfi2OP8RVYW7NCfaySlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795700670; x=
	1795704270; bh=jY7SRS8EY4WvgV5Hy1de+tHZT9Z4JJSU2OV+0aUvWLY=; b=a
	JHgQI0KIdaNNSs30w5t4TZxOw7mXGverwiNhoRJwNZ5K0QO5ncWRRUf/SzZ5aduc
	PoNa6uKtipFes1JQ8AB2zSzkSr5AlgpJxyDHyRF28uqBlkUs+BDr5lsQiCy9VQIR
	0S5DFK5+ALe2/wuyVfSAGq8ti9UMeBpzNe6JMAPbKM3bMBbi921J56d6Bixpat47
	48bjiokL645lklxXX6UCs9LTMl6XxKdexXwnwyxueK4NHxbWsWNjmp1+6dAvT60h
	+KejqD3f9gBejuveG/E7d3v0VkLzI6APPJW6IlyflLpttsByx1FV/21sgUdpxwdF
	HInHpoWLG5ZzZhDpDQxBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795700670; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MkkCFi9bhzWGRgI54wZ63k4fZGfi3wuJlivdw1Q6yBoBxwx
	A4VspLzeLE7zFo47530bTJLUHcz4NMlxzXvP/9SJ3+zzw87NEVALaMVYk8etOVyQ
	mRNJQ27g1eFTHTRSCJ9aFmFr5ZBco5M4YNxZ+S/lfRmDmolspQum2HP9oKCrDEKp
	OSXsLZs8gBn+mZ7Z+N771etg4T4rwWHAd2LaRR6km90Qp9/BvwslV+3JRfQVlbN2
	w4uHMCKc0AJCAGNe6q89/zfc1JVd6Tadk9mKQUjapkY+/SEnhawbnnPjxr2u/KMd
	mlEViN9MC7tb03U1cjtm2dRv5ApZV+5hwYIMeCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CH5LxRj4t7fUnkD/K9gm9IqfmmHJlbgLCoYZhkvySOA=:STMR6hsVSFCsgck2T08ksDap6/kwxk6X43QzRdvj+Ck=;
X-ME-Sender: <xms:uzcIa441yI-H9ilfRWxqDlaJNCtYtgrLA-OrB2ZGeFyC0r2AIdW2sg>
    <xme:uzcIa0s103boGVZssNZZSPCpa7HdvpqSqt7uFKFxjHLN71lhp7BfWDsrkAHODfvwV
    RwjqE4LlAKS_jJWTnqCIHlHDeEEBx2g_xymND0oaVEWUw7HsXamNhU>
X-ME-Proxy-Cause: dmFkZTGiE3u+QPdbaOCW+PkpYwEs1CFrKcWeYM604yYgXfDsFBYxjQMMgVHFUqRERJSYUt
    /ekq/G541e9LXNUlfiNzNnL6bc6s2cb0zMshW18VpRzvQ7HeH/Ln6Tt/ynSpgqqra0JECT
    rmKMLIqvOUhCilWj57mKJrc5kCRWZNYAlx2nukAIuKI1u4P0xSQMv9WgfAth0Q+Xq79OKf
    TkIHs07z8Z+owMB3TsrNFLpWsCJ+NmMR3MgmsfERXWGjQW08bTNiXtdRV7kTGoJz7E8t0f
    ngz8k++2bURX45zZ4HIhEFCJFbozNAJp9cA9UOBTUHdGxmFw51u8dux9bu3RL3FcVbRsc+
    7eukkmksuIMCal2gD2+cEbcxEmUp1HCvGB31duJJFfmu+PPQwCG9YsbVeq3k9IS/7CWBf4
    eRfxo/0C7F3xL/nHQ5eFHLVLJPFUdh3cy41hVTN32NlVi0ypseK/tIr/zcPvs+qnNGHS5b
    SQGoALwIMnb6XpVlbhkmuKwlad0nEHNDVXn7ESM57qqrv3VewNzHwCKfDpq8vqaO49An1u
    uivcraA0Yo8Ej5eW2hOz3XAsT/5LfQmDSkT4qcE8HvQUrUjvO4xyumB4Gl+roeHnLwneGi
    k9fRwqa1zy+T3KPtgnzteySuaOXRRv59Ad3d+M07BkFpruUfKG3Hs0NSB8Iw
X-ME-Proxy: <xmx:vDcIa32ztnOw2c8OL8LDX6_BPg4e_qYIpXhE0qZdrgJc_nHqwgpE9Q>
    <xmx:vDcIa7Bv1VQzRSGPzFoDIlllQp1VWmz-P0ytFDP_231LFfdUNDY-XQ>
    <xmx:vDcIa8Ld-PiqDL785CuVC334lstFkfK5mDRQ9ptlppHqm4hrksMRag>
    <xmx:vDcIa8ltrFVYQAeNHmRHkdsenv9ZwOT6yz1mHbqd7BYbJLbFJDCQvA>
    <xmx:vTcIa_ScZLEsLt_j2TAlpzjoYZ_qNrbGQXJ84YkdY55tZ4HjUiRRmiwg>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8FE88F800A1; Thu, 26 Nov 2026 08:44:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AsmFC5iU653B
Date: Thu, 26 Nov 2026 14:44:07 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Yige Jiang" <yigejiang86@gmail.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Andi Shyti" <andi.shyti@kernel.org>, "Magnus Damm" <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <ec57d879-3b89-43d0-855d-723086e0a9fd@app.fastmail.com>
In-Reply-To: <rc-b1-20261110-vc-182-eee62ef398fd@gmail.com>
References: <rc-b1-20261110-vc-182-eee62ef398fd@gmail.com>
Subject: Re: [PATCH] i2c: rcar: release DMA channels when host notify setup fails
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Yige,

On Thu, Nov 26, 2026, at 14:31, Yige Jiang wrote:
> rcar_i2c_master_xfer() requests the DMA channels lazily, on the first
> transfer that finds priv->dma_tx or priv->dma_rx still set to
> ERR_PTR(-EPROBE_DEFER). Clients probed while i2c_add_numbered_adapter()
> registers the adapter can already issue such transfers, so the channels
> may be held by the time rcar_i2c_probe() creates the host notify client.
>
> If i2c_new_slave_host_notify_device() then fails, the out_del_device
> path deletes the adapter but does not call rcar_i2c_release_dma(); only
> rcar_i2c_remove() does. The channels then stay allocated, together with
> their DMA engine references, after probe has failed and priv is freed.
>
> Release the DMA channels right after deleting the adapter, in the same
> order as rcar_i2c_remove(). rcar_i2c_release_dma() skips channels that
> were never requested.
>
> Fixes: c4651f11d09a ("i2c: rcar: add HostNotify support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Thanks for your patch!

> ---
> Based on linux-next next-20261109 (630059a5a632).
> Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_I2C_RCAR=m, 
> CONFIG_COMPILE_TEST=y (object only; no new warnings).
> No hardware or runtime test was performed.
> Needs a pre-Gen3 R-Car I2C node with the "smbus" property and dmas, a 

Why does it need a pre-Gen3 R-Car I2C node to trigger?
Pre-Gen3 I2C controller do not support DMA, so this cannot happen?

> client transfer during adapter registration, and a failing 
> i2c_new_slave_host_notify_device() (e.g. a client already at 0x08); no 
> in-tree DT sets "smbus" on an R-Car I2C node.

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds

Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819593B19B9
	for <linux-i2c@vger.kernel.org>; Sat, 17 Oct 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259775; cv=none; b=RrZFTZDGumuDhQoEKcPf2IdIufM+24qLoK9nvdCKPZHik3THdLQv4Y9HctKRwmHKrx4bDv+wwQ62l7UhqvppE2riAgAqEOld0yxzPV2Cn5sVo+aisWWbHyQxHLiMrdsvEVo6pwVMS8ujkiF9KHjpJMFA2EAL9+B1fghdyzesTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259775; c=relaxed/simple;
	bh=4O7SgwgSc1ovT5bBu1/dCBkpGeekHsczWI3Nb65As9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eYQtlb3Zbz37Xrs0J8TwmFfqHTUq/vUxdmnWzlibnbNOHw/+vK8SlOzxMDkgpNKg5ly8Sb9Wj9OUolLY4PBsRDH5rV+CZsLJaptjqkES6xAxA/0cJfT2AUbwV5KdkP1kUyg2N6RqC6w1NUgpKwRJC+GxXPJP9Fg7NjrF8ZO9RGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=pass smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b=OWWVcwQA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eOE3Ah0B; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howett.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b="OWWVcwQA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eOE3Ah0B"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0746E7A00EB
	for <linux-i2c@vger.kernel.org>; Sat, 17 Oct 2026 13:56:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 17 Oct 2026 13:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=howett.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1792259772; x=1792346172; bh=M9
	JisLx10fezWwjt78ZTS8jo4wd2o0/pzRfhX2E0P6E=; b=OWWVcwQA9BqreaR5Xq
	iQ7zIzwLm57xPfw+XGLKs+WlyEYS4eSPI2pKJOeG8Qj/e95Lwp1db9IC8WEakpge
	h1Mq4Vabu3Dzs+pq8gnGjArw+TbDSr0LL7u5uK2m8TT8anR66RCZoNuub43MazIP
	5uAyOMQiBeRuTnh/eiZ3o1Bt1o1+sAUk4b55dROZon7pNCTJ49X/9eR/MHQ9VpPP
	EYctRiOyGttoH9Z5t1IEJQRuIFZYwsb01LjRZH3pR1Ag/8EeA+zQhgryZ8SN2vs7
	LNRR2xySE5cQk+kz9ada2eDLzkq9j0uvZ87gOg3BSq3S/qYTxJrSpFTuKnrGDdGt
	Nnmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792259772; x=1792346172; bh=M9JisLx10fezWwjt78ZTS8jo4wd2
	o0/pzRfhX2E0P6E=; b=eOE3Ah0Bq3f1jtOixDO0pWs/NsAj6aMDNIPosJPHPd+D
	njHT+jvuPxWEHhcxNAmQTm+vYje4N+qJ4dYpKtIxZkzNliH+FD0c1qkjnEqkv9K7
	aCxsTKJ5LbYPD3mg7KcbZbyrxPVZ3z1IwE6r5qgJTuheU5v45DnhCtY2+tmwAG64
	7Y0Q0FWPcPI7ghBP1HDcbaZgu4132af6L3eDfGlWVK4NDhoJchhKnvBk6dkciODR
	jq3GB2SaNFBnW5FoDZ1Wg1FFj64Zw+fBFE3d5Azo4uB1Nx0+1M+WF/0US5Unjd2Y
	NjZBEhe6BfqwTyFY2nZJ50CdBeA3Evc31Vx5XJG2eA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=howett.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792259772; d=howett.net;
	mf=PGR1c3RpbkBob3dldHQubmV0Pg==;
	rt=PGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mC8XFNz796XApHYx1gkEVczNH8gYvrdXpxnri3rt0MhnyOs
	/pCBiOa9c8+0gNLlAL6HIdVUp8+KzzSu1wIcAW3W1DosQUextOmIwV6XXm5gafYM
	92SiXPG8uhjcMlnUj4jEIMgrltkRb3kflhYYbnIdBQcNiVzSWFGg2n8BbGbZu3ez
	CaRi8kMjB7Kuv9M1rwK6JzPiWN32QF3Vrw6mgrHHXKawdinpq2MM8Z5gNXgC70z8
	VWHRzY9bO2blFCC/YokbF8CVnOxI3yadWdBYAMThP2bWcnw1vPq8cu4YIF0B3tNB
	im+9IyHksEJoUtDox0LBL2F11JcltFQZwe2/rPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:DQK1GDn24eIz1fxeuU2yFXbym7aVlf8m1O1XgL/tx3k=:4O7SgwgSc1ovT5bBu1/dCBkpGeekHsczWI3Nb65As9c=;
X-ME-Sender: <xms:vLbTalELNrEh_8V7eE9Bw_KOi4vxZOZRkVAFgmnTqnGAR7xv6RzNeA>
    <xme:vLbTajoHx5Jrj0OEX1w1eDU_U8lnVNZH2w5B010tjReGeJS6NJ43vTkJ_wKynuC9T
    FmlAlSBomJHrb9GVm_5NeuOUasdktYKSfKOwuWATbFz5g_YHP0XKA>
X-ME-Received: <xmr:vLbTaub-Kau1ZmWhAGIWjzr1uxFqvlZHRX5YltJoCVYZEQHGs9Tvk6GX0fgEnOvUuhc3QF9HT40U0a87e6I5EYjD7MzwsTFD2ARK9U68irR5bbFYs2Q>
X-ME-Proxy-Cause: dmFkZTFYebHspQRS9ORtrwYbR9zBGb4K6FX0HcEwTm6Lk+Q7kDDb4EYH2LB65nwuPGGWva
    wh4F9CgHudNmoSv9S3OkdLZAAbc35D3NcpH2x/TQ2CMpifpmlvD0x1Fqp7Lgn6WVKeEn+/
    OLhCXXc5yWh8R27t/5FcZ4zbqoki8EITp9TQKuG314mnESW7atkh/zPT8YyzuYweLcjwWL
    eH7VVoUWotOkQxxM5JjiMvNtnyGDlXiU4MwDLU2HhmwX9FF8v/YYDPjKtylHZ+/RnZB8lq
    GoAFEugaHPWPEoXkGx3ot7SlZq99aiJ+gG2IWp7SoX12sHeYLqktK544uV3pO6ngeI+xpv
    eiaQPo153WWclGnjJU5T1kkwBDeWb2fwAUtygun8LmIBd2cM5xW1kj4IRxIA/ltlR83aKT
    1glwgT6FJTofIna+VcLopqg7iRtded1bMPoM2DuDw/LwLdADqYFriGcx8qsaw2ewxvxWVt
    J08Vczl4ZiXjR5Cj4aN8sTeSCJIEcvnHhuzkEuhIIzh87OezZ0EKFCbcGp1/wmJsDjefxc
    eQQxHlv9dpnbxP2+xUH9l2rhbmpYpzhF3yUrg2HlRCxRczhuHl8t/0gNoSMdozdygtmsEw
    2mpsOsx5VKnRnKXndzsFaGtcwFeytAYT3/pF3z2IsK+C+jB4bs+1pH5Sf4ag
X-ME-Proxy: <xmx:vLbTasVKHJv17ckSa4P1dG3_aFT8aP-60QGWvHNHQvMKv9EsPrS7HQ>
    <xmx:vLbTan9K3UcjW89sGn_NYuLBpm_LQlKl2xkFPm70aWyFvVpRFEQFuA>
    <xmx:vLbTal_WCDgNWuLVOtco0CNUozw3Agyp-QNp37mZBwWZUKDeRJVPsg>
    <xmx:vLbTanR8NLl9ejE4i2qNvIUVcpX6QwZfWV3eWkdJd5TctSCAZOTtYw>
    <xmx:vLbTav8kwtSD49BZ8OGLpXBRsMGKw8D1NCg15w43d39bswT6N2RiV7c3>
Feedback-ID: i32264b73:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 13:56:11 -0400 (EDT)
From: "Dustin L. Howett" <dustin@howett.net>
Date: Sat, 17 Oct 2026 12:56:04 -0500
Subject: [PATCH] i2c-tiny-usb: add support for the Oops Electronics SFP
 Media Buddy
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-i2c-oops-electronics-v1-1-ce960f8f1b7a@howett.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IItG2V5EuNJm2I5JIxoog3
 t2oy7f4fwOhxCTwKjZItLBwDBm6LMD9uvAlZJ8NRplaK90gG4cxToI0kptTDOwErfdVbZ/Nw/g
 Ocjol+vB6bdv3bfn3Qw7OF+z7AZUZc414AAAA
X-Change-ID: 20261017-i2c-oops-electronics-5dd3659782da
To: Till Harbaum <till@harbaum.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Whinis <whinis@whinis.com>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Dustin L. Howett" <dustin@howett.net>
X-Mailer: b4 0.16.0

The Oops Electronics "SFP Media Buddy" is an open-source USB device that
provides i2c access, among other things, to a SFP+ network module.

It exposes a vendor protocol which is compatible with the i2c-tiny-usb
kernel module. Due to a bug in prior firmware versions, that protocol
can only be used with devices reporting bcdDevice >= 0x0101[^2].

[^1]: https://oopselectronics.com/product/SFPB and
      https://gitlab.whinis.com/oops-electronics/sfp-media-buddy

[^2]: Devices without the fix will crash and drop off the bus when this
      module is loaded, which prevents them from being updated.

---
Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 73355a56aabf..92a2633a028e 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -162,6 +162,15 @@ static const struct i2c_algorithm usb_algorithm = {
 static const struct usb_device_id i2c_tiny_usb_table[] = {
 	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
 	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
+	{
+		/* OopsElectronics SFP Media Buddy v1.01+ */
+		.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+			USB_DEVICE_ID_MATCH_PRODUCT | USB_DEVICE_ID_MATCH_DEV_LO,
+		.idVendor = 0xc2f9,
+		.idProduct = 0x0004,
+		.bcdDevice_lo = 0x0101
+	},
+
 	{ }                               /* Terminating entry */
 };
 

---
base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
change-id: 20261017-i2c-oops-electronics-5dd3659782da

Best regards,
--  
Dustin L. Howett <dustin@howett.net>


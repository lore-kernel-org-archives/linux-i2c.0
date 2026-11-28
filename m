Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795833153;
	b=Ij5LV5DKiZbirsgnzANWlMb5iIQvZsA1qXQqjcxhUGFE+2pmNlviU/vs9d1g0tJputBi
	 SmnIitTducvTGcX8LNVhVkCnFLcTDuPOMcR3m7l7YEyM1Kkwus8HZvm/xaufXsOT/vXgT
	 LlRNXeDEhWogQ5n9BS4Lo9ZzrxhyZvkKBkaWuRGoVoxJENzgDyTLvrDIFqIQHY3u0YCi7
	 0tlr4adxgpEq+H6feFkbvrfyLB4UK7ZN0Qi5LOlPulCrbObRivOcn9fNdVyVfEuKGbTFc
	 H0eZeOsjtwkNgeX0EG49q8mFVcR0phcrWWtOlBCMQDsnx3vDl/2ir389jp/N9w6ODtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833153;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q8zIFf5tvtlyEJ4ME+g/gWA0uOGMkjHLDM3DJ8Toato=;
	b=Mms14XY2EX4W/AVCE2A/FL1U/X6nrYInCexno8IGQbGe+N/Cn7vOKBP8E/YXAqgdixGI
	 kk89Sc1T0MvACv4xRe/5/PX2zl+/35kkLGrALG24P/oSiXwNt6m9NoxSI6q2yuclLPDIl
	 7t7IwUved/Bd2wnqi1rDDtp7Z4oNcB0+op6XZKyoAcOAp/jaG+r8++Gc8Z7GTZCk4YeL8
	 EV0RqQQdffAdiZvv3SbLOP2jN9ecxD/XthK6i3ILGAA395xU9vDHiF87XU3NTCqemJ+3s
	 +ytsV4Apzr8Jp3yGk/YFWxJSsr+7uuUqxcON9RZE1AjKOtEu20iBpBQym24lklcjMrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZIDRD/Zo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EEA606A31C
	for <linux-i2c@vger.kernel.org>; Sat, 28 Nov 2026 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIDRD/Zo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795833153;
	b=0Wxd3t1S3EZq2/AaQoj42wCd7eHHtBjGnIpL0EpInvgsObendbl2feVyQX2LLHaCKRxC
	 jI803y19t6212ZzYGl9v8fcc0bL46OdPTpN0tICQwGEZkQecb028Y5S5wwMFDOGchGwIG
	 0uzPruaOfHr0G9uUxkGzLA++Krlo/pgsmME5jl65xmMvbxeBYUoGGWzdTRA+nqJskhIC+
	 1tk4kFt2HHpaZ6K0vFVuDcgC13frANzUaYCn0qoU6rOddnF+ZTJYB7mNN+SkuPzoImMVl
	 Kr74t5VI3T63G1i38ecsqq0qcc12IdzUbyH+LljHesbZlBJXdtnxjBOjQ56WVpecPHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795833153;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q8zIFf5tvtlyEJ4ME+g/gWA0uOGMkjHLDM3DJ8Toato=;
	b=UmTQX+W19+kOHuDJDkLowuvGrKa4iyYpBK67+f+BWqwEekXiWTAh9/B4/DgcCYW0ORw5
	 3LoU8r7QN2nxW8++jV/MrmzCB6ebYzJwJwk3DsBLC4C3ELOShi5MxWgS2PXxJ72DB3dkF
	 0crvFQkkKJEtjC4O3mx+NCKzmdJIRLuzHmhVubZgyWJHFd3Xn3kXEjXEJzHqNWgBhdDve
	 MrOUWoywsVkREVVBuZzrkTVLAcop7ZyV4PIoDsLSulZEmELtOXGsNp1TADNNXWErszVnq
	 DDuM/M/Umst0ONQOjrOtXx/+S27KF3sa5Cmcxtu0R8a6NhuQuz0DMsojC3MB8QBSAIQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E61A01F00893;
	Sat, 28 Nov 2026 02:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795833152;
	bh=Q8zIFf5tvtlyEJ4ME+g/gWA0uOGMkjHLDM3DJ8Toato=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ZIDRD/ZodynJQnVWeBHm2+tJXeydFSCuPA0X0PMlGD7tQj72Zxd1i3r31J7ClkxEe
	 K5eBUggfkzNuhs2C0weIErJ3yK0QPMgnZaH6NL25oKVHZn9B5gvP6ASm+Ix1nH4kwU
	 PoZDKc2vUUupaOUed6jgpomMbMwef9subZACOh1UbvwAubFoR5ksA0Txxf2hHVEbCq
	 HBAIKkbMgWDVNmlsCVLBIjnFPxeH4AXO0rF6AvKiueb+uQfSj+HQ+UwC9RMTUy9Sxh
	 o5r1mz1Qfv0hlkjwCtANttnocSVDrKGUUBOdoVuabWLEhOjD4Z2pho44ood1KQww1J
	 azcDGDtM3p28w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7C3094DF3D;
	Sat, 28 Nov 2026 02:32:29 +0000 (UTC)
From: Felix Huang via B4 Relay <devnull+akafelixab.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 21:33:46 -0500
Subject: [PATCH] i2c: diolan-u2c: use get_unaligned_le32() in
 diolan_get_serial()
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-i2c-diolan-u2c-unaligned-v1-1-0c3621b7690d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMBCE4Vcpe3bBLFQbX0U8xGSsK2UriRGh9
 N0b9TbfYf6FCrKi0KlbKOOtRWdrcLuO4j3YCNbUTLKXg3NyZJXISecpGNc2q4VJR0Ni6b1HwjA
 EL9Tuz4ybfn7p8+XvUq8PxNe3R+u6AaUcgCx8AAAA
X-Change-ID: 20261127-i2c-diolan-u2c-unaligned-2599ede88a92
To: Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, Felix Huang <akafelixab@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795833227; l=1508;
 i=akafelixab@gmail.com; s=20261128; h=from:subject:message-id;
 bh=tWaQaBt3Y5jwyqbvYJKTgjkG1O2HuHP5e0f9pq+Ozgc=;
 b=O8fJvZE3M4Sj/iA8XY8eQleLHc/CraYpTj0bJDqUhBcvFDFMPKsXvr/HMA1O5QORNqsdKQpTO
 6w0H9ht2BijAC5iBFlpinuux7hBE6OEw7eiBpjkpljKFJ7vJEBhM3LV
X-Developer-Key: i=akafelixab@gmail.com; a=ed25519;
 pk=Axl3BM1UWa+m0/AWcEhRIdIk/WY9FnY4wZkyQn64uVY=
X-Endpoint-Received: by B4 Relay for akafelixab@gmail.com/20261128 with
 auth_id=1670
X-Original-From: Felix Huang <akafelixab@gmail.com>
Reply-To: akafelixab@gmail.com
Content-Transfer-Encoding: 7bit

From: Felix Huang <akafelixab@gmail.com>

Fix the following sparse warning by replacing le32_to_cpu(*(u32 *)...)
with get_unaligned_le32():

  drivers/i2c/busses/i2c-diolan-u2c.c:290:26: warning: cast to restricted __le32

This preserves the exact little-endian conversion semantics while also
avoiding potential unaligned memory access on dev->ibuffer.

Signed-off-by: Felix Huang <akafelixab@gmail.com>
---
 drivers/i2c/busses/i2c-diolan-u2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index d502f6e47..24db6d26c 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/i2c.h>
+#include <linux/unaligned.h>
 
 #define DRIVER_NAME		"i2c-diolan-u2c"
 
@@ -283,13 +284,12 @@ static void diolan_fw_version(struct i2c_diolan_u2c *dev)
 static void diolan_get_serial(struct i2c_diolan_u2c *dev)
 {
 	int ret;
-	u32 serial;
 
 	ret = diolan_usb_cmd(dev, CMD_GET_SERIAL, true);
 	if (ret >= 4) {
-		serial = le32_to_cpu(*(u32 *)dev->ibuffer);
 		dev_info(&dev->interface->dev,
-			 "Diolan U2C serial number %u\n", serial);
+			 "Diolan U2C serial number %u\n",
+			 get_unaligned_le32(dev->ibuffer));
 	}
 }
 

---
base-commit: f4585067150b85e33f60876149a6e742928da75e
change-id: 20261127-i2c-diolan-u2c-unaligned-2599ede88a92

Best regards,
--  
Felix Huang <akafelixab@gmail.com>



Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65B3438A4;
	Thu, 18 Jun 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801118; cv=none; b=BCQw96YtzFXbWHnUFToMg4hoFLlTkjrRImzwfw5v1OPIqrviHgLxczkxwiPtQnAA5eBWgQWcRrBvYHC2m6nETMJ1fOHvIvGHNHdBHMV5c05Q1vPqvBWZf2+QmAAQOa/45/RmX7QoqcpTMyhEpaKdQtCajKvHxdRpa6SKJuZxlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801118; c=relaxed/simple;
	bh=HyIYAhDN0g09XVBrkBGY3nkYIRPsnPlFZF+etGwnRNU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VTzGj+ux55e2HGftUN6YaP5h6HmqRtUhsStYZJbpzvntBpkh8ZpgCIaG/4rRWJGyYQiYehywyBlExT6Qel516iwKZbHvxp6ojP2E1wbS+FgWpe7wx7Wo2S8IWJuZNIfNzXMFgSJquxtbh/Ar8LxyPu1xiQ4Df6ZWOMzoIzCPcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=drm1J+tJ; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="drm1J+tJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781801106; bh=gKknWzmn5MmxSPM7x0Jr8IYqk59JnWapwuBsGz0cyDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drm1J+tJ4cdClVZ6KO0phEDYdw7xa0dB87JLtA28lTfaHtU27ey30NN02Nzzo1ca1
	 JEwpVd4a9AoOPwI26auif0tqd7IqbJmQJLm6Oqw41eKxs4PBS4Oh3rXm7IfgRR11Tm
	 ivcx/sq75+twcB1c0eNjUPRR6EIle3LCPLSZ9w6o=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id B3038E04; Fri, 19 Jun 2026 00:44:48 +0800
X-QQ-mid: xmsmtpt1781801098tz43o3saj
Message-ID: <tencent_EE0C00FD7E512B7FEBE18A9C207D74779C09@qq.com>
X-QQ-XMAILINFO: OOnbKU/qCQQlMjXBVSkar6F0HBSPNsDWB9fBUbIFV0L8SHiwUzBbT6zZQk5j3N
	 Fg7f4e5gUJfmuJQTK5gARgcA6eyiim3n7zynEuwLC4qjHuVUQRMuNISXuE0t6uPpufIQ2dKX8W7U
	 WbqcCUH2CD4/7DXqg6eKOSEbtZXoxbMv2r4x8Ho5WvmrteBeM6vS40kNv60JDa3LpyQhHJzgH2X0
	 uQaLTKBJijBkb02Ffj0Qxe3s5hNnaFN5AYdCbj1vUBmiZpQgisFXUoNvmk5oi0FBVI3DUXOqDH54
	 zPqwave7l1HI7USgQWihzwzMTsGc8Gp/bzxKspu26hjPpxgpjC7w33ZM7UoXEzbHzfHi8vEQeiw+
	 8aRmSkNCSjMnlwX0R4y8/S2FNo3VH3n6VRqCH+eAj2vJRJi6Xbe2ifIfObVDJ/98Qrz9V5EPd7rG
	 wb/2Tfd0vN2X6eFXOs7UG5Jhp/zatVUWUCc15ouau2YNyaGGidHvTBwQqR0oRQmnq2AxdpyGrFcs
	 K8jVlBVbIBpCSma/NfymP+PukAfNgs+4/fWSfF1oHoGu1WwOohLnL3QxCbf+sZSFR+QPp77cbs3Q
	 2OFrSXI+a0f7NaGreeJn+LLSrZEMAsuuzR6n6xzE1ylhNtwr+mLqgcSOLQTjf7u1BXCBGdQza/45
	 OqsM3SOiU2oDa8Wxe6xxdoPP3dTo7KbPcKAnQOv9o2Yri9ipVTul+iiSYz0ys9zVIednldtAov0o
	 Eb+oGb9EoxHELxK99dnQRjk3HG1quEK/78qPioNHoqsXpmNn8luqNOwoPMDpuhaXRgoeV91/Gatf
	 rFDuqf/TWuuliv5XYPtJBCxvakuzWAl0/x10O7TAztF21EMM9Y5amzvFFd92UQrDI4wQ1KAljd9z
	 U5RIJtvHrbcg3MB8OD3t/Hq+wS2WpLD6/R+ZmNeK6pMR1pf/mUZYixzBFFbPEs//We7quyVYil8c
	 /G67Uv42b6xkIs5HqraDu4gqyMkBfXKs5QjJ7BoJBFCt/XVOtBOPPQmq7Y8dm/dorUMIVQN+xHqE
	 Zi9BCxkqs6gg9jzRZPSfBmAT+usapFd+0PEQFca17OecGhEZUDWeeFIhpP+mOAIJsSHzUSMDkHHh
	 Wp+gY12V7RiXKCkNQiQlMgolI37Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jiawen Liu <1298662399@qq.com>
To: andi.shyti@kernel.org
Cc: till@harbaum.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 2/2] i2c: tiny-usb: check adapter registration failure
Date: Thu, 18 Jun 2026 20:44:41 +0400
X-OQ-MSGID: <20260618164441.3883683-2-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618164441.3883683-1-1298662399@qq.com>
References: <20260618164441.3883683-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_tiny_usb_probe() ignored the return value from i2c_add_adapter()
and returned success even if adapter registration failed. The
disconnect path later assumes the adapter was registered and calls
i2c_del_adapter().

Return the registration error and clear the USB interface data on
probe failure.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 73355a56aabf..df1694f721ce 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -262,7 +262,9 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	dev->adapter.dev.parent = &dev->interface->dev;
 
 	/* and finally attach to i2c layer */
-	i2c_add_adapter(&dev->adapter);
+	retval = i2c_add_adapter(&dev->adapter);
+	if (retval)
+		goto error;
 
 	/* inform user about successful attachment to i2c layer */
 	dev_info(&dev->adapter.dev, "connected i2c-tiny-usb device\n");
@@ -270,6 +272,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	return 0;
 
  error:
+	usb_set_intfdata(interface, NULL);
 	kfree(dev);
 
 	return retval;
-- 
2.34.1


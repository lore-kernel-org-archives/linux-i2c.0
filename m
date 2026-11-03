Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694605;
	b=V9k3mmjRD70ZdzrniE+23OnEoRBIys2m44+H/6teRZP6XeWSGc4r0NzH+vvD1HzHidil
	 bzbqvyElvGMhtHk6xO0I6WOAIOArwp3uP7KD/ILlFH+sVWbALvHE0O7yLAqTMKWWb5cKH
	 4tmXaUpmo1MoBCt4yt+zYY6nmHzxLlu2Cf6SZ7ACrGjffGiev6SVKdfS4GDHLC7azh1Uo
	 Fd2whgPOKRbJika4e1GgUkUfqJUTp1PowKanH9xlAaA7vEiKkhgbxXb5GhDsTLlLx/8Jr
	 Mc23p4iHzLg9sKOZWrI0uEuMMn+M+HJEdsnJBt7m2NYQD0a92QfxWAIkU0QzkvXK+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694605;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=UXMQ7hhiNiQ/jAk4pXl0gn07FcMfjNUnkmFpOUCMZD8=;
	b=L4Dxd8FoOjCpRc0gBqScViQGyddTOjXRlkxnGVGdMAfJdLc+R8UZHK7Jp47CQpga+2kc
	 gEZlkICf+InjdRZimYj4AV1YuxWt/FWh7ud067Gnn2DKRAKYZKlnkt9JKWvponKernbth
	 Uo7RqS3eelFxSkxEuxn8eDItY5D2eaxbDcsag6Yip/Zlqio2KpPhoNxkoXXhjz3Ie9pHu
	 dzFVPXWckmLjiHNSlxGhPMHnW8pBTyWCeH6Xvby452AR0XXiVpffZQVijCGs/wwq/7dvy
	 0HDeBB9ApHKniId2xkMV74R6gjL2Kqsrsf+0nkGIktzzjeTBIAYoCZGEDx/RcQYToSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840B606D821;
	Tue,  3 Nov 2026 08:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4840B606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694611; x=1825230611;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=q47mtdoDQRmiw7gaqC6BeePUyqDsQMH5NeO1kW62avc=;
  b=QmpaWbxjdcAO15lT7BasCGUqkOsE0e1B4Hp9tCBbEpmDo9WONb6B0Ti3
   FbkNnxwz3UNHaJmVKaGGPOJzBC6fcKOArS5woRvPh89w3utsGfjgC77Yl
   vodFDqiIx6k7JMrBnAwXPTBFL4AFI4WmfOIn6QpBbNvEWhhVxpStf6WP2
   IoYj7gxXDizh2nseijuZUSF2pJEKM2sCE4fpNY+LEiz1h8MB4CYa0B5Bb
   5OgCK/Kl5duvuzit23qb1HEES6MwZkPB5pbCcog4TM7d8bEAIYszwnZqd
   O2wVzK5r1ssO//SWVDxY7F8K5zG6+JFFgZSGo4vKX3dDiXOdQULwWBTrb
   A==;
X-CSE-ConnectionGUID: ZOE9ffQ1SGCOr0FS3GFOkA==
X-CSE-MsgGUID: /urnmpQnRyeSWzfImvAQqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:30:03 +0200
X-CSE-ConnectionGUID: F/KqzQK/QC2763Ssv9KmXA==
X-CSE-MsgGUID: HqLe6wGhRn+svd3Djuf20Q==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 03 Nov 2026 10:37:49 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:55 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:42 +0200
Subject: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

In nmk_i2c_xfer(), pm_runtime_get_sync() is called on start and then
the controller registers are accessed without checking the return value.
If pm_runtime_get_sync() fails, access to the register of the device that
was not correctly powered on may cause a bus fault or other unpredictable
system behavior.

Check the return value of pm_runtime_get_sync() and it if is not 0,
return the error immediately.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index d07246d11b35..361a5fc6a587 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -734,7 +734,9 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
 
-	pm_runtime_get_sync(&priv->adev->dev);
+	i = pm_runtime_get_sync(&priv->adev->dev);
+	if (i)
+		return i;
 
 	/* setup the i2c controller */
 	setup_i2c_controller(priv);

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619961;
	b=RsOidf0WibP1aQs36yZB3mvJei344EynmhjRVxVxNuuzfCmK+ex7yYJXA92QeevvQ4KF
	 Be/gVUGSzQJilodkET9Iy5YzwcDzaIfcEZOKFe4ceByLeLFssRk7KzpcjpdEvcmIJd741
	 lbX3OrQ9KH3E4HFOEFrqs+ZrffxwpK7oDeshdlhi8d3O0fXaCX1ftEO6QBH3O/3Fso639
	 VD31+uX9NLvx0X+w+5u3cBb3Xxj9cfrfD16rfQlyfiGWCDaiInpBVEkKMXi4yHBUiyTOt
	 ALm49eCAbMdFL/fulcLk6TaWhf7HRK1XvjCBQgMh1FraYWdw+aXzvGb4wiLesL13RkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619961;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eRzF381QNOZkPq0trg2/WcC+oDPGrsVRqUo8LjDXywk=;
	b=m5zkra+M4rj6XuMG6CPyPfpJH3g/mRiQpPqDq9pyMcYYIQ9v4VXfcjiely6NHLkLMKgV
	 s/BwKnsN/EXFHTwrISlIO1a7KpSa1aIDd6Id87VLiTALaosjp51aRHQ+ysjpu+kxOXREZ
	 qHi6xOKj2D69KAeNhA9gldDb/sxZbryMEQc0bdeu4v0XOuVreIPAv29qw6c4aBEdUe/N7
	 96DpYYkR/NutwF5Y1ocYeMbS2K4+peypxtjwbAdej/SuDip5ZoUVv02SjmBHi0C4swJ+N
	 85BuOWzZ1PNralIk10b7vVceMS48Os3eLJkMhnTRy/ZwAOQKNTxPtsv9WWqN1r2TO6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=wqBA6WON;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40809606A883;
	Sat, 14 Nov 2026 01:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40809606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=wqBA6WON
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1794619957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eRzF381QNOZkPq0trg2/WcC+oDPGrsVRqUo8LjDXywk=;
	b=wqBA6WONOSUlzyxvMy7c+WVThleiBphmKvGbiu1HTuokroWG+a3As8lYgpI4Uxn283gyHE
	lATdwcSbOVgDOQgYiXP6rmmXnooXl7Xijw4iv1TZgABq1S0VZmhF6yCwfODH0O9iLpGTnW
	6qKCxTB3PZGnicOznunSqpOHvQQrOei70GkvHN8g7ah6xS7brjLcI/XKYOItclp0SSfzGT
	iSNjtG0py+Myc79YvR3CxYH09YUzZaS0TdH9fpLe28u6C1hexSBy8cu7yzB6FT1ItGrV/8
	rus1n5zq0BRzIamcrK/i/iTU6VdSjgO1eGLdFzLO1T4dCi6icqrff7BhaVxyNQ==
To: Andi Shyti <andi.shyti@kernel.org>,
	Ajay Gupta <ajayg@nvidia.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: nvidia-gpu: Log transfer timeouts at debug level
Date: Fri, 13 Nov 2026 17:32:35 -0800
Message-ID: <20261114013235.1239905-1-hex@freenixos.com>
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

GPUs without a USB Type-C port, such as the GTX 1660 Ti, have no CCGx
controller behind the ccgx-ucsi client, so every transfer to it times
out and logs:

  nvidia-gpu 0000:01:00.3: i2c timeout error e0000000

The caller already gets -ETIMEDOUT and decides whether it matters. Log
the timeout at debug level.

Tested on an ASUS TUF Gaming A17 (FA706IU, GTX 1660 Ti): the error is
gone, and the timeout still shows up with dynamic debug.

Assisted by LLM.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206653
Link: https://lore.kernel.org/all/20200921180840.GA18032@ninjato/
Signed-off-by: Hex Lindqvist <hex@freenixos.com>
---
The ucsi_ccg errors that follow are fixed by a separate patch to
linux-usb. Wolfram suggested dropping this message in 2020; debug level
keeps the status value.

 drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
index 14c059b03945..987dd3edb0bb 100644
--- a/drivers/i2c/busses/i2c-nvidia-gpu.c
+++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
@@ -88,7 +88,7 @@ static int gpu_i2c_check_status(struct gpu_i2c_dev *i2cd)
 				 500, 1000 * USEC_PER_MSEC);
 
 	if (ret) {
-		dev_err(i2cd->dev, "i2c timeout error %x\n", val);
+		dev_dbg(i2cd->dev, "i2c timeout, status %#x\n", val);
 		return -ETIMEDOUT;
 	}
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8232A3C9;
	Sat, 27 Jun 2026 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578360; cv=none; b=ZsdsOtE58iGLHcJZQ/VTtAyTxiA7lq73i2ENtGx/XXAMef1i2QaBrETuWJ3ywsWrDFxbxL3Hva3RyzPZ8j+CiLiQTchT9N6MkN9nteGlITMa4TwO3OMMrd3d55mfv/wXTGjBFedzDCs7rvbAm6a/MppQPcBoxChRW/cDgnhsLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578360; c=relaxed/simple;
	bh=tJw/IQnUkpR2skVWIyp4rINEMIXy0wSUtdbjtxYBCwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PMJL1MUxgxKEmXNpdjLTVzxhfu2tPXaxgfG5dubl5W5/43+9Ghg7tjKDfGdkjivrulO8MWSgTuQdJhrPChTvimwyauRGjlG+6/tHcQNojHkQqiAJ1zbu9xBgJ23TrO0AlJOEA+seRrm1ywQ2qoQyeiTi+9NH1+t6PjWMHVSs5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaB78VWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaB78VWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEBE1F00A3D;
	Sat, 27 Jun 2026 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578358;
	bh=+bAZ1jDI4RpDJAVSi5J690qMjtgmVlvlPyTfsWt9wH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UaB78VWfmvoYyJMf/+fnNOpyp2B/xy7+iIl+Zv1WnIGbuwZL1RFtwSQzfrltvVGQk
	 OO4iZYvISDSeM/u2Dj9O9qY3c+S5jJQSaIzCYCKFXF++U7u2/X2vA+uKOBLbhBJ9/h
	 0/d4uWzUvlL64MIB4UXCKQZ5nNoVBjajwl9BdYFpjxCZb/8ehg19dZJPd1Z1gODFdh
	 BiZEzP5I5I+nEun8oCn7fYV41jO/uMsXv9N98mzG7GA/2rrK6VyeQ5Q5ZSgA/GRMD5
	 hNEXmyUU4+vSe4RAAiFahacSn1Av9fpPo/W6f7NZlNC8XmZgE3DYYJvKLewcHED/pd
	 ShJNidBHEOCZw==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Sat, 27 Jun 2026 17:37:31 +0100
Subject: [PATCH 3/6] i2c: xgene-slimpro: Stop writing PCC shared memory
 signature
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-acpi_pcc_signature-v1-3-c1b7268d4fdc@kernel.org>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
In-Reply-To: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 linux-i2c@vger.kernel.org
X-Mailer: b4 0.15.2

ACPI specification defines the generic PCC shared memory signature as
the PCC base signature ORed with the subspace ID.

ACPI 6.6 added clarification that the signature is populated by the
platform and verified by OSPM.

The PCC mailbox controller now validates the signature when the channel
is requested. Stop rewriting the signature before each command and
leave the platform-populated value intact.

Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index b29dec66b2c3..f77d5b3a863f 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -174,9 +174,6 @@ static void slimpro_i2c_pcc_tx_prepare(struct slimpro_i2c_dev *ctx, u32 *msg)
 	u16 status;
 	int i;
 
-	WRITE_ONCE(generic_comm_base->signature,
-		   cpu_to_le32(PCC_SIGNATURE | ctx->mbox_idx));
-
 	WRITE_ONCE(generic_comm_base->command,
 		   cpu_to_le16(SLIMPRO_MSG_TYPE(msg[0]) | PCC_CMD_GENERATE_DB_INTR));
 

-- 
2.43.0


Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898134C8FF0
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767015; cv=none; b=grKhlD4HlDxOZaBhdqNOxLMXHaUSgjHfH2MDY5XxbEDe30JceQmcdNYqYW47FSROaDtpS+orjc45Zf27MHdD3iowH73jihHnsxw8aZkYsv3jI1NfLOME8LOnT0YLzk3FnPR3OvLdPeXEaENsdTtEtcnw9PMj+GuezIFqhpA6ywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767015; c=relaxed/simple;
	bh=PTm7KfAf22Pq8oTJK9JiCTt7+1syK75vpiOwmFtY9J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J72IkJgW8o/2iITK7ZtL9b9lDoHqNBWezU4sIUNZv9BW70Z8qe0LigSt7BSV+EqOLroznidCyJOmuJlT4T+mgnqQ2ZEHEp41Vs3liVvjH1Pmnkq/Wp5xPJHRDGwKOfmq2UVbTLAwa9/VlkL6+TgcSgayejyoXCSUc6FlnsHSK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUvQzYJe; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUvQzYJe"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso1376154a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767012; x=1791371812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wY93XBZD56JE3eyu1OkHEle/LlbtoW01BFCKk6aYmNc=;
        b=FUvQzYJewIwlr6o5zL/7Vg5RevxVcyF8QJ3I+yogBzB1R/B4ZN1xDLpG0gKYTmvwUj
         YfPtQ310owCh1dWR6H+YvKehCnuPF0VthJ3IWL+vr3ubtkW+wWV8m9n0tk97MIH++6RR
         JmrOWoPwfikZa8JAd1fmznCHBol9FBxsOY7QFA7UdUY19u46i/6QoyQrJpys0hsonB/F
         uCG9RMMcPyUbPLTmWMCKyJONY3dyWFY0sH061xGl28Nn69iPJLLYMQKxce8gCbw8o9ie
         7bOrbW0MfWCQxuucAbqdY2S3ClqR4zIb666W40k4MUwc9kIp5NiX3kaZjTQMch/ltGmv
         bsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767012; x=1791371812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wY93XBZD56JE3eyu1OkHEle/LlbtoW01BFCKk6aYmNc=;
        b=gOC4LY/GBnDYgifr0WKQVauBMMTuAJMFGlQOroQBvwePcsIpZKCC1Br/Exf2J00qTR
         0jwOJkHDqHOqz2rtrJGtRNmm8Djo9EAavaPlZkT49hxDdwH44pziKGmmEtIBzRxHdcoG
         vramz02ah2ztRff1n5jdApaPwPuCQHDU6jNzvwr9NlUjvyXlZEvdwKzhEU3Rna+WfjoL
         UYNcIMiJ+ele8AjxDnT7hs1FcavZ+jZ6RfnxA8dC9C6d1QtJj7TAgDfNxmf6Q4LhyTYa
         jV7VZm3JvmHjNo7BnQFT2nIyfkSfEGiLGd06fC4dPmo3uXdGJo921jsXO35rPXZVkL3P
         doIA==
X-Forwarded-Encrypted: i=1; AKwUvBwlHyJVsQfVKrEhyDBRZXpYOHBGRXmlrPrQFqDOpz+KKJE3+1XFTCX9MvIdztxOXrNxb7feUYLdhlo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/SMpRrcEwehYx4a21cLVhEJaQFTvB1AORbRmdQVPfDD3zIkgq
	DuPRLeCT3SlWDIaQ8ctwpAzOzMrIsE+xNfteILSp/6UBgbAYlBNe4Vl1
X-Gm-Gg: AYBFou3AK0R1O9euhVluS1/HCHOTbkCEVfrb03dYDaF714mX8J4nLwJHMlBWtlmQVML
	OrGyOd4UCq//3BokAIuGjjirlnwJ4XezJXlUO9ie716NX6R0W6ej1OJlWC9ifuQi/VYIgP2oaJS
	HCVEIVQU91Iu1w8P2r4kG5FIkf1/LZ9U7OTnAcQ7+mJXAbAdNTJa8/dS3WBzDMgs51hU7Ni8Jrg
	KbBvTTR8a/54JyElc6tGaqWb2lQIskwHSAc5UNlfM+t6a+zTsGfblZM6dyxOJhOk9mySTLde+nd
	uCswoBLS6i2WeuIWsZSVB8cE0W7dc23UpW0qULU3RX2sHJditCG2ftyCtUM387asXeXoYf7Iz1/
	+drIT9tdp1+i53EZOPN0vX08dax8oBnFSNrAR6sn2rbmPwdzDBdKQ7ytmald/tRaaw8lGebqS9T
	HM9lMQPNCk6hq7Bz/kNzpcg84zG78PGFMfRs8gQc2qqhk3852SIHQKGJ1qdYjUShspPv3a8tOKb
	QNgQ5lpJu+1eQalt2XoiETgIx8rdKkAzWY2tkFSzKt40IJC3SBwYFR7b3R6+Z8654ihmLTHudlZ
	SEcl60uEIJMZSzJN5teGkxPonO6J/ufaQY64Bq3t7bz9m0g=
X-Received: by 2002:a17:90b:5830:b0:3a4:a045:27cb with SMTP id 98e67ed59e1d1-3a4d193d3a7mr590091a91.46.1790767011654;
        Wed, 30 Sep 2026 04:16:51 -0700 (PDT)
Received: from rahuls-x2elite ([110.226.112.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce40a6d5sm2873273a91.15.2026.09.30.04.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:16:51 -0700 (PDT)
From: Rahul Pon <theflyingrahul@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: qcom-geni: release runtime PM reference when set_rate fails
Date: Wed, 30 Sep 2026 16:46:41 +0530
Message-ID: <20260930111641.1134-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

geni_i2c_xfer() takes a runtime-PM reference with pm_runtime_get_sync()
and then returns directly if the set_rate() callback fails, leaking the
reference and keeping the controller resumed for good. Route that error
through the existing cleanup path, which drops the reference and resets
the transfer state.

Found by code review; compile-tested with arm64 defconfig plus ACPI and
W=1.

Fixes: 10e74f4c5046 ("i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms")
Assisted-by: LLM
Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 6a39e21d5e..ed6495ef81 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1003,13 +1003,14 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 
 	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
 	if (ret)
-		return ret;
+		goto out_pm;
 
 	if (gi2c->gpi_mode)
 		ret = geni_i2c_gpi_xfer(gi2c, msgs, num);
 	else
 		ret = geni_i2c_fifo_xfer(gi2c, msgs, num);
 
+out_pm:
 	pm_runtime_put_autosuspend(gi2c->se.dev);
 	gi2c->cur = NULL;
 	gi2c->err = 0;

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.53.0


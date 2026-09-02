Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DA3EDE7C
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384307; cv=none; b=mNid+77apFeWC1HjXzmD+wJGlRtBv0EEN7BhUV96wrXCcXuqZ1xV0nApTfRitDF7t5GjFnhy7D1mNscb9ISrcyXaT+zWrZBQyrchKWUV6EvYy+I/duYRuqMH6YIynBSjuVMhFnjWrvB5332JZaHu8STurnDTcLIytW8tADenju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384307; c=relaxed/simple;
	bh=TC6K4z7ck8SSx5BuirQQfQ7OTQjsbasn05mpdHufobA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Egt728rCkmGtu+Pt85+ZnYq/nPwQ65h5XiLxzz5PvZ8hTc3EYFBn9cJKCperM+ITCiNMIgz6QX5MOYfdYiYq3eQYKT2OSXFPu6QwJNiz3ZnXYqv6IicnnNzdMHQ68lCuHYmfvFbejPqqrE0AOnf/wwKTYhJ/1WvOgUEs9D+k1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/XoD/QN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/XoD/QN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so1301277b3a.3
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788384299; x=1788989099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J5D1dk8TTzni4YmYfyjK0gzjxKAFCRBFSbYWu7aGl84=;
        b=O/XoD/QNgJwKDgH9GWtt6yf2dlOWchDpgl3FXS/MUqrZv1FLh48/suVWfzsQo0x26l
         ozEraiYlB2kX2+XVmUf/vRCR+kJvauRMTUviEvYr1zh2ZCRUgtVapOGJRQxX7k9s1bGD
         bjMMhkVQxbw80NVoQZGKa6N7iAI+ydH6Log/1aZuUTiVftCSN9l34Rw1R9cNxvPfRvX+
         RqHCfRz3gZvHHQ6hhUuMQ0EhllK3xgvw6D8K7E//n8N9WjIqeiYgmBsfEgqG24Xl9Hjb
         9/aYFTJLZe/+WHpTwahWOkfZlirrm1WTlsXBVK69L8UkjmfXCognEiP2gF1BMPJeblxp
         nasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384299; x=1788989099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5D1dk8TTzni4YmYfyjK0gzjxKAFCRBFSbYWu7aGl84=;
        b=lq790Y6oFDIhW71Y59Yh3KrALfpjGhf0jQdMilJoRag6fxS1/2faX5uGHa95Kaw+rr
         OIuhvVssYrnmAt88jub1V45IRyqCrgQrbzuRxykoGHm0GgG0DF/YEkCEHLYaZQSHCi0D
         Avil6o9Wgq9VwIt/oQmlJxGaQrSPIZJvz1iJinIWwgeVtVKAECvx+4Q53bPFuBRNiCq7
         C6PgAAw1W5PhlpK4xJQKCCOJifHfFwjRQoVK07O5Bs3cZxkj8GTbQlr4mk4b8xaF9IFA
         8/GtLmgIGOcGqwMPILMLZffDJhMUxu+UnT9qadyxqI+gJ0d4exM5k6ENwLdEpPBd0Fbv
         8T9A==
X-Gm-Message-State: AFuF++nPfcCOPlAyrn436KtXFUVtq4Xb7NEyheY+KJ+9E60keXBkxesS
	Ub2U6eF0DkZE/v/xsD5XheHDR1DRfP7WDlaSp5WYkB1L/K9/YFvzKACpEJGpBQ==
X-Gm-Gg: AYBFou0wEbzgHFiVEnpxKvt89SlSgjADYmQTQc700Q+b27uCsGTNMjmj/jG4GPeG8/w
	6QHDFIVjL7DaTtFJhnMG+9Kj0+Bnj4CAnSPRW3Vladrda7DbHcwg8+Sl0TZRT9lRImrLPnelo9S
	NZ5PPQrtTpE6ZImrPT4tqsU7kPsPDvGH4bKrfInvcJJCsU5xPWT7J8GltkMmD2O+yQnsfVXCSVd
	uHU8Bi79SnGhj44g2+gE+gs4vN9OWH/P88T6jwQwVs187R+NklZa1Fy42rPKj70I281pZjCaSNd
	WSNxrBzsaB7xLbfjTpNB2kV+SVEn5WfKesYXAkOBmBPfi4xo+GTlhiBwAnNzGa3yZWXF5/CFEqN
	V6uR/5Fk1q/IKGcGZLRrqGZAGrEIzVf6KBmQ7l4nljVLPpm/NztU2qKAAGReWoSpxhIv0v+XDhy
	0gCF8Sb7idtTmN6paMf2Kfppoje5OwAjSJg68BM8jxTbfcnk6n0pEJV4Blvut/qq7BIClsbXnqM
	6/PF72wHMF6KHCkkiIecxrr1/MwCrc3iTkOhEV5gCj8biG/lz60hYIimdIdZ3AwrHvzMfKd5RJ6
	euM8IwUmEUFaI55k5TFNRZyvbFwCT1GIK1Z1OQ==
X-Received: by 2002:a05:6a21:1644:b0:3d0:c5c0:d9b3 with SMTP id adf61e73a8af0-3d9ae3baf35mr13245780637.18.1788384298968;
        Wed, 02 Sep 2026 14:24:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d40c55fsm90890a12.19.2026.09.02.14.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:24:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/3] use devm and get irq in probe
Date: Wed,  2 Sep 2026 14:24:53 -0700
Message-ID: <20260902212456.289608-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies probe slightly and handles potential -EPROBE_DEFER a bit better.

v2: reword descriptions slightly. Handle iic_force_poll before getting the irq.

Rosen Penev (3):
  i2c: ibm_iic: ioremap with platform pointer
  i2c: ibm_iic: get the irq early in probe
  i2c: ibm_iic: use devm for main allocation

 drivers/i2c/busses/i2c-ibm_iic.c | 65 +++++++++++++++-----------------
 1 file changed, 31 insertions(+), 34 deletions(-)

-- 
2.55.0


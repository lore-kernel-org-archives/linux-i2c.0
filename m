Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6774AF9C3
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602419; cv=none; b=h6fC4ovSEPhXtW6ZV+nmLvnb6wh308kheBzPZkEoaHrTcazCuVs6ypDoySCRetREp5nUguZ3bGkesYh9IR/XZwKVq0hbHjcNzwCPpzA2P/uy2DtpQhurJg0m+d7tHPz96OzrzTmsxiSdKqKKGrky30Rssr+ORxPkD2id/I3ZtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602419; c=relaxed/simple;
	bh=wTlgW8N9K2vFXwRzxcl7LpmXum8Ryq7w5Jahg+Zvf0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uCsf08JmhOVrCLZru7dflo73gBh+gsKZkntPud1yPMqKrYMMjK+m/w0E8+WmB6VNxOdnEW2xTguWOnud9wU97h8PNlJDerB1zi4ZEkOR08HaaaHUw8bysIESbjFZ3mxxavjwwxGuKrUfp5NBPXCChr+nPSN+Yg7uURoq1EG+Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=abV9XUKB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="abV9XUKB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so156049a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789602417; x=1790207217; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTlgW8N9K2vFXwRzxcl7LpmXum8Ryq7w5Jahg+Zvf0M=;
        b=abV9XUKBTaGItKyIMlVxrZZcUQL8iFgDl8g0iTFLmZUrlS5oeRPy9FfsaZP6T0Lvxx
         RnCtFTs1bxp9nKrGDzeITuYyXWo4nSmnMMIhu+SQ1KeMa1SKjkw2Q9oC2zepejUbWD7F
         3Ogeh4bmsppvU6XUG9vQNMRjxOy2hC7YgeZAfoN86yZkZDtl5qm6N4f2VY6UZKTaiEZE
         l8ZoLbeBKzJOm6e5Y4kntz+mUp1ouurIg56NZ9uhk7icktSn3ZxvHqE9cx1ojw4Pve22
         JycAY1k2A29/9RFZJP3MDb5cX98dzBcC9HXPhb7sjCzrPnpoV2z3rXkELtCUarCZCMwN
         C24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602417; x=1790207217;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTlgW8N9K2vFXwRzxcl7LpmXum8Ryq7w5Jahg+Zvf0M=;
        b=E5ajpgd5C57oiuGKL/s3f7K5737qQb4JQvrGYZNwjUUXGNb0Zav8KriMkQiShJpqCc
         NRA9B5ns6OX/4c8TnxNEh3SHTd8auk8VSV6LMWWlz8MS7H821h1SHcfUoO7/jKf/hFy7
         U/f2phGtBxGtBLTD/pEu/NxYkzKu0BjS3EgaSdBxJfUf3A7PePFtPfqVw/g3YOrp+L7L
         Pol0mQWGdaLjgcivZ6qLgRMY9E5SSHZbvhXteFWxhMucMcFPSjIQKovAE5SGaWfj8WAm
         XYY5+NKugijiZKYbDNlKGCp049sdWQLE7pFkFs7dg7blDoWpOwMY8q+RgwfyhXK+cv0Z
         O60g==
X-Forwarded-Encrypted: i=1; AKwUvBwVCi9QgXTsFehqEYyWWk58/hz/hywT5q6y+zvi3dCwSh1dYbPH7kyYNHjVMQSLs4qYKJbfaHQJzN4=@vger.kernel.org
X-Gm-Message-State: AFuF++kxuAd2R5f5CLPT1m7bfBZDeK89YkspNrqRmEQk0X9/f5+iyzqJ
	z/h4pkQUTmMnD0xA7sHM8pqtlMx0rPQaHEvgGYdmclJclrbGixbInW2Pk9AymrcLVQ==
X-Gm-Gg: AYBFou3OJ/gjEHZG2SeNXFX05OVr15t/E2VyyA2lE1G1n+0nepNw3q4GjbDsPPGKVgK
	719e0mLfmNmIQ3Ou8L92rE7RrU8I+cQm+enHmqVgf6lQMOXugOGtpqugGetJ3ZEVK4+IUXQD3Uo
	GnRInePOxORkukw8H4f0fqpaopv2yh7+752F0Lxx8Ig5mRBF4iDmovEwQe9ppTiBBx8iMskzyH1
	LZisOtMSomceqmQP70RcQtuQZWQ+ssupwrlntMxOtjHTN2jj4Y32eLArxUM3J1QrxJamnvAD77j
	a5fNXDsrJx3cgfnMzE7tx/cdwlkEriFJd2+//6jM4ykyTYHAUaeJQQaJbW+FeH9HDfC7UZVO2yK
	jGf9rPhwZ4Ra2UwIAcKkYJJjf70m+hVH/DUvpo7KOBmi/6v4j6jBCljcXbc0fg0BEGpkF0BNG7x
	v/CqwSFPSzNAEelKcQG6AnXlA46OssbGGx2Jze2WcvJJiA1ysJPLTORYjsXBRRyPkXteH7GN9wa
	G3WfTV5zHeAEwZnXQXBmJFME+9UipmrmmA=
X-Received: by 2002:a17:90b:1845:b0:39d:f259:3363 with SMTP id 98e67ed59e1d1-39e1e491d27mr11260506a91.12.1789602416922;
        Wed, 16 Sep 2026 16:46:56 -0700 (PDT)
Received: from p1 (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d4a48fsm8936453c88.10.2026.09.16.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:46:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:54 -0700
From: Xiang Mei <xmei5@asu.edu>
To: stable@vger.kernel.org
Cc: andi.shyti@kernel.org, dhowells@redhat.com, wsa@kernel.org, 
	rostedt@goodmis.org, khali@linux-fr.org, linux-i2c@vger.kernel.org, 
	bestswngs@gmail.com
Subject: [STABLE REQUEST] i2c: smbus: reject oversized block transfers in the
 common path
Message-ID: <q6ksjepw4p2f3mboxtgavsxkdaee2f4xivqhczsasorea633ur@sk3xiccv7sxz>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable team,

Could you please consider backporting upstream commit

3051cd060fa496df42954291fa2306ed2eab4ecc
("i2c: smbus: reject oversized block transfers in the common path")

for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.

It prevents oversized user-controlled SMBus block lengths from reaching
tracepoint memcpy operations and native driver callbacks, fixing
out-of-bounds accesses.

The fix has been in mainline since May 7 but is still absent from the
longterm branches.

The upstream commit applies cleanly to all of these branches.

Thanks,
Xiang

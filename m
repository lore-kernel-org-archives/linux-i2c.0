Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362725783A
	for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343373; cv=none; b=DBvxCCc49hsEpxlKgd3M1cm+lirqhgQq5Tb/+bwLZ6Urec2+wCHjPXukkM0ZI3HKg+L3yFqxIqiKCJhq8VpvpS59GFxlkNA9yafBmS08FSTKVWXgIwHnVSbM18FaV457IcZGoa8JNPJmByuYhXqIludbmP+7X3vjavztl9EsKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343373; c=relaxed/simple;
	bh=7DQdCU2WxK0zeazmg16+9zA+RDtrPnDFr+uw9OeSzrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhdVMS4ZQKHvAew8xrMldLKPIPI4LXxr5TRxTRk1HyAg7uFpmVgx98gKiM4IcfzvhyHCNz5S+G76p/OhZhgugDolJZ6qJZ4iZzanyaY/hmM7EyKpwM8UG6LqZhbhsJa8CjC5YpO6rb/LEzdA75RiwAv7KzUhfm1Av6ahW1Wa+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRUORo/I; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRUORo/I"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso5540541a91.3
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784343372; x=1784948172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DQdCU2WxK0zeazmg16+9zA+RDtrPnDFr+uw9OeSzrM=;
        b=gRUORo/IbBigBFUGQdoqEVlRczbN56jVL8cQEpXlo9iOEyL43u8Loex91l2l9tyybI
         Jf0Bl+/8p3y+zhtlC3kV9bl7YZXb4D9cwxHL9oZEwBSCsSGzWyQ64Lu0uBH+R/d7n2fc
         lEmT6NYMBgBl/YyX2mGO/myV1rDvgm/xf1hWrV7dlA4Zw0+96upfcs4f8ibciY+W0wj5
         7GlQHCaGyo7Ym5xGdHud7n0gro720WvUcWWbeqoFxwhRfFytxSPMS1VJ3kZgIXfuigxh
         pqLIRukNls9E64VpkMESbjJyktLk7H6230/2no7hjYFeaHG38aWBAIWB0SXIF71/G9bA
         gx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784343372; x=1784948172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7DQdCU2WxK0zeazmg16+9zA+RDtrPnDFr+uw9OeSzrM=;
        b=IvWWGVUo6RI2MHF6PwtFHEvDi7C/GblANSEZUW6/AtRX8H0aCSkwIwCq0q7HuhQCmA
         MDzXAGh9YhfAlKmtGwuJ84I9LQXHpLVdE3RHmyaGMG1V8TJZaW9ef34i3eL82wNj5nuZ
         hU9hipTRYWKsR+QosC5TNIv0JBEvYHTaLgvOktJxRRclo6DgSiCHc7CPOf3k155cQ6ti
         GkqEMU3TxZbfd/6SOVzK2EP/+5GnNmvH49kHJupv5peBVKG2Ls91MLSLGOYwvRV4ubUn
         z6wRG1C23SjkzXb5BB68w9lvBAcgCSDquEGUSI3gQ3DF8C9yck4TMuTScQsW84zWRRT0
         fa4g==
X-Forwarded-Encrypted: i=1; AHgh+RrdEjr4gNxFZnaxOWaxppnK+PB9/drTY6AmZzhkKE3rbMM0XN3RY0oKJjpkdHXchs7UZbNJc2CECg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNWQ6ZXAYHYJMRAxJ5DNvm2ojplF6Rnci1FOVCCrQ0Mm911/p
	EmcBKaF+52Pmn1yI7/2VQrv4wH/WuUngf/QIQgUwSTd/MN+DNVaMDElg
X-Gm-Gg: AfdE7clx8wVUcWHejtt2EidjqEHgPefNnpdNYlrGzYhoOWr53SiNSRsmlZGILEIC39V
	ji//xB7ZuIPlFmmPz49Ac4EfJ3xqUcSqBJ/LkEB49VmNagyoZJ4ua8LhTlHl/FlwEYlSZt2JI/w
	MXAG9s+RtqNKKSlz7vI9WpzuCq+vOhg2lATdsCe2Vor9T24IcoUsyla65jRWmDXLGDGZBpVurYR
	pXb+YlYOwcYpt0OkNLuyuqSLSqQd/zG2PMik/tTeESH3sK0jRRY3YvVan90EzsQ5eZbzoCVWWPY
	hPluW6TYMoutgWemA/PymzWCPu6JkUt103/FZgjL+fE+/UAFQELD6tpnVLxIqIhErXfuOF6DeyL
	BNS1DT18e57GT6plBI7PlxyCeazemhrvhPP45L1cK8Vs458bUe1afgsDUHPf9Kc2ukT56wX+XZd
	EMfwsc3gxpqNr7A7niLdoyepbQ3gKA2vzq07VPzynQLycxyMg4U2aIRX+9idotAyhNvEdZna1rs
	RdItBwy1I5kDqz441S5mG0XMv/v4c8/DSf+4+Ngq6c2791N0h8TFyOiOE32foXsFuGTg3Vr7NQH
	5qOUCukTplTilc034hYYdHLJicpUaqLqVatDjF/vCd/zeqAgkoHCjW095PyGgqt/+5g=
X-Received: by 2002:a17:90b:35ce:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-38e4b4200edmr5059155a91.1.1784343371893;
        Fri, 17 Jul 2026 19:56:11 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-54-213-160-35.us-west-2.compute.amazonaws.com. [54.213.160.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e656e5686sm32029a91.14.2026.07.17.19.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 19:56:11 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com,
	ojeda@kernel.org,
	branstj@gmail.com
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction via kernel::io::Io for I2cClient
Date: Sat, 18 Jul 2026 02:48:38 +0000
Message-ID: <20260718024838.1623-1-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>
References: <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026 at 23:08:00 +0700, Muchamad Coirul Anwar wrote:
> Agreed. I will rework on top of Danilo's FallibleIoCapable approach
> in v5.

For the write side of that rework: I recently posted an RFC with a
Rust port of the SMB347 charger driver [1], which Igor pointed at this
series (thanks). I'm dropping my standalone SMBus helpers in favor of
your Io-based approach.

The SMB347 driver may be a useful early consumer for v5: unlike the
AS5600 it writes -- a config-unlock write plus read-modify-write
updates of charge-control register fields -- so it would exercise the
io_try_write/try_update paths that Igor noted are otherwise easy to
leave silently infallible. NACK and arbitration loss on a charger
config write are exactly the failures you don't want reported as
Ok(()).

Happy to rebase it onto v5 when it's out and report back.

Bruce

[1] https://lore.kernel.org/all/20260708214738.25008-1-brucer42@gmail.com/

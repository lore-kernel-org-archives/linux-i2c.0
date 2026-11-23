Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416481;
	b=IFAruZO6U6gFUCwOu7ySwuSgvxdic2+e9h0m6xDFnknp8FGd93jN0PTt2QtpEegVcgfu
	 OJE3cMNMTXYMGB1VA5ZZLVTy42owhk0paPthDOIgn7yn1Papw8vTJdmA/95kcOJKkNHuF
	 ynVouTI6TIEO8jJsLSlybMbHQLxzG2s78LuCbQrSahaMALuYq4TJdQ+6S+dotrIoGUjpU
	 Yidg+zetFJrmLGOm/MetqkxmtCCpMCl9vkWNgEvlPSJejCtHdKjza8y8biaOOvcKl2DuT
	 3vFJx/S7c+9QCstyKqkEu6Yn7RonlZUtpFSCU6x6VZfkBfk6PmI0Y11HodNVFkkk3Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
	b=SqH/aT3ZSfC5hKyI8g1qkfcjUfqppQuOizsvx7x/S1GCNeEtbzx3jpQCUpEbVpkZEsFu
	 C6qdh90FoECgVeR4pJBf2dOvT3kH5FEoDKHEXSMlY889RM9CrN0oDlPQqL8psgmWCgjRQ
	 r/tGhhCvxTywUxVMmLaVzUKb7LoFlrotNNTzZyvRzg/1D4uD4/GMRrjlJfK1UihGG2pR4
	 +bNqv9XMRM5/Tli/4NRv5E+/3uSERSgdmNYEEPBoDtV1dcViLGBqIzFULEgu4z0rIhy0E
	 H3bpqOr2cm8VrN6IO3j1XPTj7QnRw0q9TgF5JeBXCIU2o82rUmrRVlhpMxa4pZHVl4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AC25A606A332
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 06:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC25A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f01f296937so22829835ad.3
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416480; x=1796021280; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=QtcT5jHJqWm1+yYAA4VFMUP9cS+spmeKwR5RDKEV3n+c3ftxMf2A+S0r6XtwhfzSkA
         i89BXqck7v1ltIBc4g+zcm6rPOPLJn/WoTGr6fWujJ5HHX37VCCqn+5hkt4UpvPDAyK/
         DzuOh0Appm/d4BWAtNs5xZba9MLv+lEZJLKeuv9+JAAyKr9eFkW+rOMsNjggp1sksr5X
         B2JKTwP7urRGyQVRlhafyhdA2ffZMnmFgkniU7mpAO/qkc49LYqaFAX5hYEglksH7mef
         k7TEeU43ML1MTVqG7C5tNuJ/CESrvVz2mPnzpvEBeefrauZymIXXWJIHNRH3mUgbvMWa
         6S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416480; x=1796021280;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=P7CZAHMMsRFB0pVseirdy6g9G77WjTydCesKvINyPHlX4czbhWzzYU5y9hg3VblA4c
         VBMxjAGyRwSpf1NGuAv/62GqNcLD36XD1C+D60pmzHWr0OJzHkEkwrc/JQ4d2S5LKEWH
         GitWpoLZoDINj/wHCpPBJqliHXHLbt7NPRWYx4PztKJ6iP+N/tQEXLYroljR7wMMk4uM
         W0EZwVSrq+d/s1sSNv22aAfti9mR4OVmZoz/laBeIyE+/+yrXodDGM7thp2FLZZzWH/t
         6No4xSTWNv0krhE8OHlM7/o1QGwsxaiMJWT1fp5SuwZX4arW/d6kHpogmc8paw920GH0
         i6Qg==
X-Forwarded-Encrypted: i=1; AL+hErEJeZuLsgdat7GTEx09FaFbVxTuykCwzy0MIj7/++P0+x2hXJ9kAINARJN2a1GoqJcKqvmjcPtJ0NM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+stZmeVVkczWDF/hqSooTk0G1k1dd1fNN5tN9129kch2o0Khrq
	4liYBYBMcqFw0zh/+OC5SJ0SyKn2auXAj1/Nf556nhJao1zxjp1qfpJG
X-Gm-Gg: AZFdTZeGiPV3Tkx9GQjBseTLxOhHU+mksVUOpgSv/sW02YJZGEOSUr4ZLqE67RA2TZr
	tDys5mrHz20rgQX3SWsJ3Cr5yD0slOEOtyWG3E8xn7Jiv57A+V8nfsbDD8ZxnSEvsHs9slNZwng
	53BVd8nkTrkkqBVS9Sz6UHCacSR9lv7+7+b9VRa7OQRCsDUE0hy/Ii9vRIAFyWW6cVTNNSu5Cyj
	S9uKV5kYDBRAKV2XWAwor5QmiW3M6cdc4/F2Ra+qvGeLQ43+4jxf8yptvWNcO2HbMkBDOfG77Ty
	4mflVv3NqN5k/OjEX5HXugrumoNNwaUaW+6FBWS9MbjiR5qf2eMV+vuTRaKSoSFkJwJq1eGQxap
	kz/nnWxmqNCD2ips903kNh5I01/jIiVlgdW/iAuFSHsuvHf5yMpSKBSyWQLByEOnsdJ+jm/bs3i
	GxT9qpkv08HdVayd1e2TpcLIOOq6NTQqfwFw/iUgWQdVKUIb9XktUulk05VI2fKHv4GU+rN3O6o
	iLZ6uSbvnFIzL1QTc7QTInQqk4aTCayyGdBN/JDrNpoKbTKw0mTcInJ8agtq3dJcrsFH2HwSv09
	ikjvwf70viH9rBs5pyAdpJ9VLgJCiZLsb4EYAqD190MP2ArpdLhMNimHVkCAqFt71ye6pA==
X-Received: by 2002:a17:902:ce82:b0:2ef:e9df:2422 with SMTP id d9443c01a7336-2f03f1cf4e6mr103786255ad.16.1795416479999;
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84364sm48678155ad.5.2026.11.22.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:58 -0800
Message-ID: <8ee0713aa3e3cb1e54c0a60f1b32cb86@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] power: supply: sbs-battery: use 4-argument i2c_smbus_read_block_data()
In-Reply-To: <avELD9tlEfl9Uth7@venus>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com> <avELD9tlEfl9Uth7@venus>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sebastian,

On Mon, Nov 09, 2026 at 12:52:18AM +0100, Sebastian Reichel wrote:
> On Sat, Oct 24, 2026 at 07:48:48PM -0700, Dmitry Torokhov wrote:
> > Pass the destination buffer size to sbs_read_string_data(), and pass
> > the buffer capacity reserving space for a trailing NUL terminator to
> > i2c_smbus_read_block_data().
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thank you for the ack. Will you be applying this patch to your tree, or
do you expect me to queue it through mine?

Thanks.

-- 
Dmitry

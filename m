Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020014;
	b=HDhrehe7B9YDQYxreKc+FdlmDhb7ufY/HxwjMnN9tLdad0aL4Vz49qo7eRQxH/6VJDXt
	 kSsilvP160auQ5DL5Sd+LlupaFb8DJQvvSsrDq1x8NtBvxaYWw96SXKSpFCiXKXuiCcGi
	 5a71M/4rZq5v9b55LLlo45kJBUlr8kDTaS7FcHRY9Puo/c3ySH0G4jTxRZgAYNHR9XYAE
	 mx5GzW2WHbpXe1ZKwjsd0eMhk+7s/yNxEGLJkiFQqdbs1fOkSkxg41NtHxvhRfCYZgOPS
	 Qk2LXevKEbIQZL/Ap90vEMH9SxMtjewMapLCqipoJK79iyA0kWu3bx/jR4SOOwGmHJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
	b=LxNg30PDy62uaaAkQWqC+EIfD7sctLU4/PNgoJApmHXzC9j2SFA6IWpK+Pg3Sh8iWSp6
	 EyLoAsWi4b5pydHf+AAgH0bicZ0DhaJGrFEnSxU/9f/BVHyiY1FbZ0ZIse8TBQW3hMv5o
	 9tqrLPN1ZcY9Y6NPOlPXj2ZTN/0dZKJGEpVZ4HWURSAK2nCJUVi2UcPDqdE+jj7F7XV2W
	 FY+FDa0SmLFMpK/24RQA6xfQgTQ+k4QJAw21Q4rvlhRAhVhdTE8yisovgqzTl3t+aaKgE
	 zCd7iX1ML/v+DgWAKdBZnKKY0HFwgKVp/jcSOVKy2pojBRG7F/0tBoTEY+eEFaogRog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4U9mTZD;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC2606A33E
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 16:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CBC2606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4U9mTZD
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so9816425e9.2
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795020012; x=1795624812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
        b=E4U9mTZDlIksJjVDWFzuHLbz7qz+H6X/WuZ+ANBvE5aFdUKR8wGJnCGbI38Iz/2/Am
         DcYffqId9bYDRaceSRCjX0vLa8N2I1YNW8Nj1qZQ3GuZ73h9A9UTkhDsV3iQxJvUqloo
         1qMFUUlT9Uexndc0moK7CkwofIBYGR4tJyD+emRsHapyfy2d+KrUNsMeTIWGDmfsN9A8
         n0Sr1ChhOkJCtqcwuL0MKUD9rqm1bq+5vNOmBkoyrmnodDxhRqx2TCVJVvvt7P3+SNGo
         Wu5SygkvVbJnpy7Ekh/QhM6Qt7MKP3IelqkgrWCVRnNLdHHFr4gSD62k/UvxKTiQFyLW
         u3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020012; x=1795624812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
        b=DY0AunWaBeE/helTX+F8Xp0a8YgOtYwBFAw8pbF7oLi/hU00noSyIJlevmP0rYJBen
         HD1JYW0Vz38bRLQUXfncenpXq+1rE9+3uJ4r10EfsIwOS4+7XJUyL/1iSlmt/nXb5yRC
         jPBC+7j1kz0lLku+rvbU7cQofXAndEryV5mlZpUttwvlha7o1zgRT72vox8aNNg5fctD
         6Pu8zwAF8ziSqpEIGooCQoiJKcYtJCOLQ6eYwqb50hD1m0D18i1pQ8GnFW8JeA1L6rBx
         pTDuyvu2Mo7fodYd1VCULp8lt7aniS/f8Q/KhOHI2EZpmHcD0XANNKH3zmXXvW5gEhn7
         n69Q==
X-Forwarded-Encrypted: i=1; AL+hErHvSLl7HDmT10yxZySPanFL+1VChHIwtotTsaU8nrff7vq/Ki63uNbw6U6cH5OLEPt0LjgBfjibWO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yn/1SVpRQvHhgQSy5jV3cLMGq4XkS9dvmO5tdZ/mmbK0ikmOe
	AoYyxw3SMTTGjYP1M+CuEkJQ0F04AGR7pWo9Ap/gSFZ+accvZgVjo1IQ
X-Gm-Gg: AYBFou2iv8NUXR9wNWDGne0wj80ugh+S8c7sCLywXnniAc5g17TP/lahNb8L+/jKKGw
	Nl+W7Nk4zAAmS7qYbs1icbY8V87TuGRz0b9bgizR3ceZ1c9/1YQfdVqfCIopHzViuNWE4rkvEAW
	lLg2QE3Wg1u9oNQ5QL6OqyA7cyiQo2qiio7qEOg+0e59/8dTjEcTTrj7IFS9Xp4URAaC7ccKEpE
	C7v9jhjnSsnTl4zbsdzSmsK3EEDxK6BHRQENqWa/W+jvPKJjaJ4A65KmuXOakFEYPS8f7v0R1pJ
	v2kc6T9HsQPtMT2p2Sq4nGH+1aQLPkLI+ls2iNi3H9hjmOaXJm1WjcRHQttEpj0m8ZlIA2+NLHR
	SNuhHTn5WXR4WEbd7rhTrNpdIsPX1yjpU2hBlb5gEpLel0qwALYl4vbAqmaV2LR8Kwz5xbDOojW
	OARk/jyHN+qYZAkLz2eE08IDgEfkXHqUYEY5yVYQ/pfms9M0Lg6QIfoYlCuq3mze0RTHFOXnTOd
	ZY++Kvv6vhf1wvmOKmX8ZOeAF//hlmpk7MloGJ7nYQiB4wMQrITFL/LrHz4FmIpNmi8ewOL/fy3
	MUpeLMHcaXxc2HcaVhEE3qsSYRPp
X-Received: by 2002:a05:600c:4715:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb7da3d288mr60167565e9.34.1795020012419;
        Wed, 18 Nov 2026 08:40:12 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm137986135e9.13.2026.11.18.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:40:12 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Wed, 18 Nov 2026 18:40:03 +0200
Message-ID: <20261118164004.28739-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <BR0PR05MB0491322068606AA1720DCE14C0837B2@BR0PR05MB049132.eurprd05.prod.outlook.com>
References: <BR0PR05MB0491322068606AA1720DCE14C0837B2@BR0PR05MB049132.eurprd05.prod.outlook.com>
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

On Tue, Nov 17, 2026 at 11:56:36PM +0000, Maarten Brock wrote:
>> +		if (value)
>> +			gpio->vals |= !!value << offset;
>
> Odd choice of asymmetry: !!value == true, then converted to int and shifted up.
>
>> +		else
>> +			gpio->vals &= ~BIT(offset);
>
> And here you choose to use BIT().

Thank you, you are right. Inside "if (value)" the !!value is always
1, so the set is BIT(offset). In v5 both branches use BIT(), here and
for ex_vals.

ft260_gpio_set() from patch 3 has the same two lines. v5 changes them
too, so the driver sets these bits in one way, as ft260_gpio_pin_set()
already does.

Thanks,
Michael

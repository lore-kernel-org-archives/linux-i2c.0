Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8634D3B2
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863870; cv=none; b=QVTUogOqEKAxvMUz8vMb8comKcMSEiJ/ULnO0FSr26obX6gYi4qul0EDcyJkyVAD9bSe3GiV2NJpsCln2MMtvIOuldhgGCDm42lOy3/CeSV7ilOVlmhdSzUDTWOnRil0DHobwdXfXLmW610m8qD67kwSVVmRnJXT1lkfAkf0BJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863870; c=relaxed/simple;
	bh=Ufx0P8rDIIn9ux40wvheeHx/pbxLVtKnnNJRtf1/UGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM8y2AR3aWSVKrmg/xTmPvoi08YY9/vPfy1Dm9vPVHKzleED2XD8VbYHpbqGcZACW8jDsTVwtpBDzHWSpaCBUUuPMMq17VEi6VKYuea4y6W0bOR7dD1QT1bXjE393VrobHeuK3FZahTGL3ds4UeEO0+EG9HqWsDm7EeUftrUnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STQWa0hY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STQWa0hY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495437bb891so2491165e9.1
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787863867; x=1788468667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4l9pXpzpCQlA5EBOndwC9CK6cDBlGTJk1glTt5sjEdM=;
        b=STQWa0hYfUjcUsQHpHhLUNMgnoeJhTGIGZrgIvMFkuSNH+SeFZOl9sNNxajfEy035m
         xdBWZ3xHKjTrum5nYUWb4uWEwfJY5H40ZkWIkdfNuU323KLPSAQhXfOOyhMnp/pTrVg/
         uo4Nofa1Rv/eYJebhfRxqrmeAar5QKKu1qcvtJQkSz0gVRoWTC/SbTUUDuuzCeS0mM7E
         82GmwgF0/uA5dP9c0DMNnRgot85fpE702hdK/SIhPyeVhaXIuIoCU4ybA+2FFdCpCSao
         dd2oAwRPNxSSLZgBlvomoqJSaOqMwcTkyd69JR4+7mQdlz2SCNA4oRA4FaMh3qCQfPvN
         LnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787863867; x=1788468667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4l9pXpzpCQlA5EBOndwC9CK6cDBlGTJk1glTt5sjEdM=;
        b=GwHDAXqXN9YDKce7KY7WU8BOS4gsTYNr/zYiTdWoKYHFgZRZ18Zws1WDkZSxftcliI
         O5DhNXnUsBqcwmOhm5CH1/XbRjYAnXv93OwPiFD58K4odBjVsI3lMKZOAwGEn7qwUFe9
         b/1wu1OUMcBEGVHvrLUNPqajPaKRNN0G7xgn5MybGdy6g/tlPaK9RFeWauo6Nv23neQo
         +dXiZh/uneKRG9oqtXlvN4+OFp/LstpaX/UwaBgjAvCKnMLnKLbBDtQaKgHLBWNIq5kb
         PMhMYu+GncA8rX2+Sh5+wE3yQxDdaY3up9xY+Dp2iYDGPgt50463UsVAK5xrSnMgxMWz
         z03Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq0RRa6tQaQcvEhWNSGPR02DfLOUy+FIJcUuniwJpW7yZeoOsmk9vwz1UPlCBzipG+43aYfIpnti54=@vger.kernel.org
X-Gm-Message-State: AFuF++kRVsrtyzp/1h98lAC12c2mqgFn75GE3TvsojwlM3EGIDOv0btm
	YVM+whv5EdTjTlBXwwuNRKQILZXn+fXaa0GNyCVsTzZVohKpeKWGD8hW
X-Gm-Gg: AR+sD12mZNRpBP4l6C/r4x+tgN3rT2CszILd2pWCOc46eCeJBguOi5VKdQv0vvUJtNl
	LfKrL9zVNlXdeksEFqe0XLnGw6SjFDfURekM5uqCpKdDgCFDp9/YkSOFyzTdVktAayWdw9DOO9Z
	BkXYtstLOyrcmsYRzsQfZdZj/eqVm89/oSgdet76N82zN9oYEzgGl1PQBAxrh6kyvzFQoZB3Van
	fzamqVbE69j/g1Kzv0unu5LUtsmdRFJFAZgL/faYaRSan/tGWTdrcaOLwEDt6jc/CxUyXqaqZEE
	Y/YqE6HUFxYTH45OVhyhjJsOObZlf4gW6jArtyIjh3uF+vIW5EkRdF6BDJFNx44M0IVN1TfQkgA
	3dVUeM1bprgyJVQvnk7DNABbbX8I5oaqDn6A0m8tISDOQ2HtVlm4eJnmmnm2IIKeEhDswDsBkDr
	LYF4j06f7B3+5ONi+TB+aNsP541FukVaBSd5TkjYzXUTLklaxFdxtxxxMpFeg=
X-Received: by 2002:a05:600c:8b26:b0:49a:ce8f:1a5e with SMTP id 5b1f17b1804b1-49b91a2bab2mr27494655e9.2.1787863867220;
        Thu, 27 Aug 2026 13:51:07 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49b926874fdsm6458095e9.4.2026.08.27.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 13:51:06 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: linusw@kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	brgl@kernel.org,
	germain.hebert@ca.abb.com,
	rio@r26.me,
	brunoceg1@gmail.com,
	contact@christina-quast.de,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] HID: ft260: gpio: group sysfs attrs per HID interface
Date: Thu, 27 Aug 2026 23:50:55 +0300
Message-ID: <20260827205055.17510-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLmugu4-1_XvqwV1xYw0L8F3V6CDP8qW3PCSvVWY6gqh4w@mail.gmail.com>
References: <CAD++jLmugu4-1_XvqwV1xYw0L8F3V6CDP8qW3PCSvVWY6gqh4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 at 10:13 +0200, Linus Walleij wrote:
> Drop "gpio" from the subject of this patch, it's all about sysfs
> nothung else.

Agreed, the patch regroups the whole attribute set, I2C and UART
ones included. v2 will use:

  HID: ft260: group sysfs attrs per HID interface

Thanks,
Michael

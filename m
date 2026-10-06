Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A583E51E8
	for <linux-i2c@vger.kernel.org>; Tue,  6 Oct 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298507; cv=none; b=DH4mayy4ODhjRzXaiMnLn3FCsFLLtQ6xDWk2wdMzKGtuRSF1fLYkbbhcZpBp6krIfXRfXprwqTo1QWRaoTY1yE54/JQWJDJbARkLe7hWX3bjHwjHi4NzPHIGRrL/30osNtwjKGb/MxZxoNel5e4UBGiyWKqjsq4zVQvFGdZrbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298507; c=relaxed/simple;
	bh=R4KgQ3S4Hw1T8EoPFbH6w2icBtvqBXb5gZZ1wkD2hYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dM1QtpxlRG8GRSfz4/gL59EoPywHZaMsg0HLhWyrXEZ6rJ0icgpYWfRVzx5VYLPHE8AIbZXo77n2FeMb7M8UaLHoNWMd1WUZTYRZ0b3wJJWU9dcssTErXO6rwS1OLHL8kH/lpElFt8GZjUnPbI8LnpTRH9zOtoHHSS1PFcJFv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNxW2ePX; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNxW2ePX"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15354aa70e8so7780488c88.1
        for <linux-i2c@vger.kernel.org>; Tue, 06 Oct 2026 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791298504; x=1791903304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4KgQ3S4Hw1T8EoPFbH6w2icBtvqBXb5gZZ1wkD2hYs=;
        b=DNxW2ePXDQoOCN5STko2zaq29Q++QxwK4Xfv145SwJCcF06vUIzgSh4rVlyXtr3Zeh
         /IVzWppqfBAiKolF9tXNgGTOVpyamVdrdcBpYp4JMga6uVmS+vhzyD7eYVbPjj/cuvsy
         vBpV1op/Gl3P/RpCPRgo8dDr0te1qUNeJ9VCDAKmX46my3vkGdDQRouvoYMOIpykRKEq
         dO6Xf+bsIIZnvgXA1GgQNIoFwrQUT+ZhXAZ6ksD2KacrM5ykzFmyIVXeOi5sGQDuVZTp
         JG77q/LhEyajnxg3L45XbL3tlOzvhj1O8nfARhGIwtsJZI2FRKINRO3l8ZPBIVNfoLgN
         CV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791298504; x=1791903304;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4KgQ3S4Hw1T8EoPFbH6w2icBtvqBXb5gZZ1wkD2hYs=;
        b=TkR/ShQdsVHl3AOJtFknJ1KwTzPWbXsLTiPnHvQMbyRqXSfQ++jIWjZbLvLNkoIXYH
         dSlScrdKMZn/gDlEq3LU+/Aa74XlE+u1CJvDzWqUlIVBG1icNwH+AHFHtXUhVQ6w4P50
         tQItqXRjEOp+pVCb/LotffSyUKcGpnjzJArknD5SRqyeXaCpOKV/zdIFkF6RNhM/PiSH
         TqQob/GKtLp77KmyoaL8FqfV4wQxWRf383alhmoHUMLfIE2Fs+6D2I3CxIFQWuwGxArI
         N8yiZn4xOK+jgpfEI5UNXwAs3N9sJ8a+DcKxUedizIQhGhaxIA/c76dNCitZCJ/JFv4d
         vGOA==
X-Gm-Message-State: AFuF++mE58aNWVj+cLL9laAosApWYf/u1LLDcsNWH/NxqnxWcBq6DvZp
	i4eDWuoakHDOEUBks1deuANGW6EM+FhXhNhtjn6awiVCyruMh5QYU8fQ
X-Gm-Gg: AYBFou2aoIENfvoLV1XVSbOaw/7i5/4AFKeeNi/DQ8Z59XRPKdMgVzqnAqnItMEhCiV
	+JCZGFc5d2ixhqyuSxG7D+KEQnVi85ANKrhMKxI+hO9nTYBaLNe9FIl9QK5Mi6LChej88npYIAB
	odxZgaMy9FxmDf991QGW2FEbKJFl6OKIGR1eGoX4eSdhFJvium05R71BbVoQXAPUGqd0aG8spQW
	TNpCgYc5/qHmbH8bzr0ImweXoe0ie8wZ+nEwdmuk/5MCfmkoJYMu1UGPJ6IXchITd93tA/rMRnI
	oEIhQEphhAIS0ufcqufuQHiiVVT0KnXFSZcDBSfu/qKM3dcJRmwMAQ33hJdkoBhy1NjVfS2mAmq
	RdemRpUqqi3MAg9bYw/FlV5Htot2uh+RhLJfaoyyhvjxaYRbjJfkkmg2wuqVafynFGrztcHOLLK
	iPnebk//5Ggc4H17Dd3ReH71umO3S+dQGglgcdD+5kDHQhFFy7Xxjioc82AekKwi69mxxGbgeex
	5ZhW4eHxTShTUXXiPyg/7DkI3WRAkiY2FMc9tkrvh48UqV65fBjwtpgINx0E4RROzlPgsXt1TSO
	ipx3/PAAT+X3WVJ3HfJUmuJXQ8AdMJGvz1QNhn/1/Wuv20ks1Xxsq48mMXsvkZjgKU+sJkKsmUJ
	5vzyqmHRA4EJtvLWXi+gcAzu+H8FPXkYCfi2/3QA9SqnKJJCg2UJMcY8=
X-Received: by 2002:a05:7022:7e8a:b0:143:298f:33b8 with SMTP id a92af1059eb24-151c4c11b5amr21602995c88.44.1791298504055;
        Tue, 06 Oct 2026 07:55:04 -0700 (PDT)
Received: from yoda.tailb23519.ts.net (38.70.247.229.sumofiber.net. [38.70.247.229])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16105519176sm11243c88.13.2026.10.06.07.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:55:03 -0700 (PDT)
From: Hasty Heat <hastyheat@gmail.com>
To: abel.vesa@oss.qualcomm.com
Cc: linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: Restore the source-clock selection policy
Date: Tue,  6 Oct 2026 09:55:02 -0500
Message-ID: <20261006145502.105542-1-hastyheat@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-b4-i2c-qcom-geni-preserve-source-clock-v1-1-9aded7552a76@oss.qualcomm.com>
References: <20260928-b4-i2c-qcom-geni-preserve-source-clock-v1-1-9aded7552a76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026, Abel Vesa wrote:
> On X1E80100 CRD, this results in switching the source clock from 19.2 MHz
> to 32 MHz, which causes intermittent failures when probing the I2C HID
> keyboard.

Same issue here on a Lenovo Yoga Slim 7x (X1E80100) running v7.2.9, which
carries cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
SE_GENI_CLK_SEL"). The ITE 048D:8987 keyboard on the touchpad's bus
(b80000) came up as 0018:FFFF:FFFF with a report descriptor of
0x00 0xff 0xff..., after "did not ack reset within 1000 ms". After a warm
reboot the same bus also hit "Bus arbitration lost, clock line
undriveable", and both the keyboard and touchpad failed.

With this patch applied to v7.2.9, the SE clock stays at 19.2 MHz. The
keyboard (hid-lenovo) and touchpad (hid-multitouch) probe cleanly, with
no arbitration or reset errors, on a warm reboot, a cold boot, and a
warm reboot from another kernel.

Tested-by: Hasty Heat <hastyheat@gmail.com>

It would be good to get this into stable as well, since cb97bf3d4f91 is
already in 7.2.y.

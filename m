Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75E2222AA
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802203; cv=none; b=pquoxtCIuFyIRxFsnu26oIK6iBFjjbU0ibDLR+o6sKPvuVBWVYzFK8RSBhFmrMy6InOLK8O8TJ6Nsz4Ss+QP74Cmx5EBj2FwHXSGAng6hQZCBPpPKnDZS3ICyghjtV5Ehz9KN6lxSSj9OEcqpx1zBNoRbO9cmeJ/WQIm3yCYG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802203; c=relaxed/simple;
	bh=czfdUOiQXPZbFnAATDYk5b4JmkpWW4Ig3zzIBmSKRSc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Aa8vFBDhAznXGE8G3CjB7C9xZ43GDYY3MjpTqrGLCM0uPAkH7cxPTrFWm3BI1+g60JluLlou1uVCp2cap8gyeCM0VDMgbTCv9EbEX+Ba2Rgh3PkouB+hBHgIG3f2zzAjI8b/96EA9J1AikRDvMkK+mz4bZ8zRohX6fC5itKeBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp6CWyMh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp6CWyMh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9ed0c7fc7so12449135ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802202; x=1783407002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1QY57v2o170i5Uh1BA42HSzcmZFQxfvkMqvmdq9s28=;
        b=cp6CWyMhlUgTbqeb+GwV27PFembZfQvCUbWHY7w5WAnIK7jFkllGo79D6/Pk87qNqP
         PW26vtXAUH9BxFBp2vClUh8PBzK97ojYTAoiajCjBpLXw5QIhw5PXXxGm7cB4WKE8wMl
         slh+mDxd7CeTaLfgX1Ie5pZiLhlrKyQKB/YQy6e06KbeL6YeiMPENs6NeYhIcVJBRhEl
         8yCwDw0urfiPQMai6/9vuibDD33ZQNJ0cm5uVc3ZwKDI7LR8CDv9twLiYzQdOenfXCZs
         Qg0eFSUmInuC6eknkdvtpSuvU0PwgF5TBiRYg3/GQMH9RvlYpODwQDw0Pnxv4hIJQv+d
         t04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802202; x=1783407002;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1QY57v2o170i5Uh1BA42HSzcmZFQxfvkMqvmdq9s28=;
        b=tAf/UtP38va9cuo4Fa3lKnkAkyN8KPZ1duKrxD6T+Es9RrkrUrXv8+G99++J/Ol0T4
         S/XGgTl77ihLBQzr06XkFRcZ0cUBd+5S9OZ5QWD2q0aOPZzDCYVStSn7WqP36mWX9BBu
         WK/O9hKprcP5VLE0WbjUNChOcokudUuYcjD/0Vy9MaMS9ApDAFX0Dj4xK+KR+ek1yi4n
         kLShozVE4VOyc1TlZeBxx5jW4ePD+k7x2g7A8/Hdl2oxO87KV67elU7RZpDRoZdCw/qE
         cdOR4nSuj7WqeRaL0UCb4o97ezce5fdPTWH2DXntcugT2WESlJJd4I/X/94co4dhfzrq
         aacw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5tJVVjNkZ2njQ1e1kkQTNOc+3ovBbVINrnDqlI0aalZDVOviC7ThZY4Odkq/D71nXJ0Sl8AWXUhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUj/hHEq8UD6ZQe6BVr4vOYAhKPWBYEFhcPhH6Krj3Vm4y9is
	nYSRz+q1vSuTy0L7chgKWRZiMEWCCQ3ICdn0AdtZvlmSffPsN87tb7jn
X-Gm-Gg: AfdE7ckXPeub7MsbKhtySE1Owj7C2qJRE4VDanoy5EPZbcojGliFatSXpFYBDh0jMfR
	w+rurWMhMq1Ve8+s1geW94Hv3h31faOIODyE7IUZLR6bP2jR13cB5HK2CAinbJB6ZcMhfmWHpJp
	SLz6v2XarixJsl4/k9fJlDxTeUw0zel6n+aXoYie3BnxhF32vKaMUD2WKbP0mFcpFjw9gJ6ZlEo
	oBzA0rqf9O2jp999OpI+g+LwcBa/AZrbASf9ChYrqotr6CVXWC6aLxKpyXMXf+reQqPq2Au+CEr
	IzdkLja4kBlPDr4ehkfpWFp1P1hJt8TU1yX9mKhxdmDmUsdwQI+Y3aLFyFw6BXJgVM8tRt9EyTP
	5rO2s7u437tJAwAz9VqYstd5KcNKH7aumdygf0RQqJCiBSOSmocjbh4QTymDbuzsTtkIFOwFlND
	TUGG3GDbEsQmediQ==
X-Received: by 2002:a17:902:f786:b0:2ca:6a1:1fc with SMTP id d9443c01a7336-2ca2d99a4afmr18114325ad.28.1782802201660;
        Mon, 29 Jun 2026 23:50:01 -0700 (PDT)
Received: from [10.31.13.168] ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a701f9sm7373285ad.13.2026.06.29.23.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 23:50:01 -0700 (PDT)
Message-ID: <1a07fbf9-d21b-45d5-87b7-d9965e73c6a9@gmail.com>
Date: Tue, 30 Jun 2026 14:49:51 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: frank.li@oss.nxp.com
Cc: andi.shyti@kernel.org, biwen.li@nxp.com, carlos.song@oss.nxp.com,
 festevam@gmail.com, frank.li@nxp.com, imx@lists.linux.dev,
 kernel@pengutronix.de, liem16213@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
 s.hauer@pengutronix.de, stable@vger.kernel.org, wsa@kernel.org
References: <akJ9pd8uhXA6y2s9@SMW015318>
Subject: Re: [PATCH v4 1/2] i2c: imx: Fix slave registration race and error
 handling
Content-Language: en-US
From: liem <liem16213@gmail.com>
In-Reply-To: <akJ9pd8uhXA6y2s9@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,Frank Li!

I apologize for this. I didn't know that different versions required 
different threads. I did use `--in-reply-to` in the patch email. Do I 
need to resubmit the patch?

Regards,
Liem



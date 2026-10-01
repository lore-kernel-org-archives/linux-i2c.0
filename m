Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07B424D5A
	for <linux-i2c@vger.kernel.org>; Thu,  1 Oct 2026 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837391; cv=none; b=dy5xpN+8ZZBkU+pokZDCIMNDdUOfIQWnP0+LibAJ9xApu1jYZSUhGkS6ZfaeKTtXM/rmcWZRRvbsxBIgILp4AIP48fd9gJodATf77rmoZCFQ2+xS8wZqwEVwDYafX/cPLFIDVoCK65twC9XWyJl4ZFMdcS6qhZ7gsgKPI0xTEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837391; c=relaxed/simple;
	bh=kI4MqRXoz9tUKHuNpyi6hMIAkrKO5Y85UDsjot8YWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2pYqCNAMufACDGSXo8S/an8CFwiXPc0K0n1STMhCXHDPkeJKnZo3TmwnjsqPp9VDWcK3yIN2cQAEOCxuYAZ3WmjBaqYElArbl4FlNGcQ8Pofm7Ha7vuajv23dpAYl8HNBUSkr2gQetR5MyzicTF4MMvk/wBaOhQPBFotQNZsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMqrFQY6; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMqrFQY6"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-886a5cb66beso943959b3a.2
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790837389; x=1791442189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sqjFwTItW9Z6VE94NesB4AWUO0LgcGbOQzM8AGhhbUo=;
        b=wMqrFQY6BqHm0aB/zackbflPmVKYc0xkXt1P2r9Li2gIMw8eBH5xrquh9cSNcMe4+9
         vmy6uindptLRybTLpMaemL8bbQpDVpxmb95vceueLFqQ1hZIltLuPg3vlEWU7J7DjG0I
         8Hnj7asSDfkIHC+hrP0V9yf/FXZOtVV8I1FpTPPwSb/3zXidaKhD2V73xJMFZEx6xmUn
         Qtj7lHw8ZuUy2rogm7nuzHfldqsfCsqJECg7PY/jVmxwvg/70rYYkiEs7F5IlggZhGO0
         01/gm2Jmq7Z7tlhR7h0L7naNBLc2TDS/fzsnKdX5/g3/dYkjczZYgfNe/JPn7QKkWchp
         4vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837389; x=1791442189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqjFwTItW9Z6VE94NesB4AWUO0LgcGbOQzM8AGhhbUo=;
        b=OgWdb1i2lBAnfpLmRLyTjRowJwVPz01cBmAe2i1/CAhhohe4JBxnF+ydpv5mPdNtU7
         2+Zk2mgPWwM97wPu0yyD7G9ETPEFch3a/HzDunfpcPZx58bRmkX9G4fWcQ9OwdNIbK5G
         iGbScT4ol+DJZsn03G1K4jAxkfvVnOBdLeBX52TZUGbOEnrD41XClc/XSrOfIdqeRZ4S
         f57rZPcqTzA50MHEE6n6xCspFaRXby6B+oCGRj3/qHKCcY2dpFhJQC0LmOEx05YxSoEq
         G9Nt8COa+48vBxrbcSiy6Bzr/ANN0O0sOoTxHVUCbytUqWoMyv4B8ofEd1LQaauksIyJ
         3U9A==
X-Forwarded-Encrypted: i=1; AKwUvBzePk0GtMTS1DUkW0ORYlUH9irxQj+8b7E6U0Sbrp/7fiuQpLtJeLS0m+MouxM53+4ukmXV43fTgVg=@vger.kernel.org
X-Gm-Message-State: AFuF++nzqWEw/PtCMk2Hp88ubyvPry7YLPfq6GXygQn3Ix99HjQ1wfCm
	seCKjXzpfa0JT0PMJuClYJIQUs/9xOiScOHg8HnoFzQV5OtEuwtKkxlEie6IbOyan/M=
X-Gm-Gg: AYBFou2uwDB0/WX7sOQ5lhimBg04BD4n53m4ryL0AiOYz8Ju1IMiDNPgnmVasEzxuju
	1Vesoh/Ovf7W+fCHNUtrZEPhkA3KT7F/rOGIP59xDGFdpK+VdQteEWSTqpkhL9z5M+8iQMoMe7T
	BprqcKxd3nBMkxkVr8yf/3ZbcMgcg+ckThsGGFDuVQjEkHvdFHx6RdBIS0vB5jq4jUx9RwRX4x9
	UoQrQ9GMDzYDS5iEUoAPVsaP18PlfTxH2I3x1bTUNGw22SKBSI37y2SpNg+qfP5tkZ0aLmr8wJ8
	uMo1zcpoVhIo2Rv5BDDLl5wNqqX8cXQNJ/dfw0YoXvvDMxF5HH4M5hO0DrHusUF/+BAd/0dXMcn
	2GaQF9JilstxBDEpn5IzDqDVzdh3r9BZ5ADEaUic1JI4NOhJauwMOoCcciF/Ws8R4GZUgGvHxpU
	q292BefIe5luWIQc8vCW2FPcKqpYXYzc9yT+1f2NCoMzj0fznUCUtr5tve5PQRGiMlSN003pqc
X-Received: by 2002:a05:6a00:aa85:b0:880:6b49:2044 with SMTP id d2e1a72fcca58-8874c8d5a3dmr3078678b3a.38.1790837389439;
        Wed, 30 Sep 2026 23:49:49 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8886b1ccef0sm387165b3a.23.2026.09.30.23.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:49:48 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:19:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Gavin Li <gavin.li@samsara.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Yuho Choi <oss.patchbox@gmail.com>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Message-ID: <ar4CiZZK4igx4Any@vireshk-B250M-D3H>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
 <20260922011619-mutt-send-email-mst@kernel.org>
 <arWHzKEfy6HKMZr1@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arWHzKEfy6HKMZr1@zenone.zhora.eu>

On 24-09-26, 22:28, Andi Shyti wrote:
> Viresh, can I have a comment from you here, please?

This was discussed earlier as well, can you have a look at this thread too ?

https://lore.kernel.org/all/yaeiwzxxh42y3oxiro5uxaxbvralwqxweb6cx4vzwx4y7nards@cysus3gbvple/

-- 
viresh

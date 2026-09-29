Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAF535FD9
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701044; cv=none; b=T3hoKKa0/k5bX90d0ZIkaOKrcugKVp4SqHboxg46EuGVglICNcEOdK04QOgU3Hv7++3ND12t72n+H2Kxz45TVd3LRafdFWWNZMu+d/zYwDVCTEsPJuSfMWWL8KpdTaq6X8Y2YJ3hdJGrvLUnuyyYbAmJ6HfY2oLb8LEVLMRgJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701044; c=relaxed/simple;
	bh=1X+I4s/Qc88Q3mt8n2I89ghISwk4YJ11K1+GkdEX0lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3mAYsx6uPCMVZcr2+HHiGTYWXSs4bnKBccbZ12CEFYi6Z7ppwyIUN97vJySSQkLVPB5cA/LKIEIqhPfErRl1illtA65IMRfWcW8r2NEGGwGOvwAl3uLMARKZfV3dXLTxDQ84vE0y679wy0maQgikLj4rKXNA6MQfum2598YR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEs1KQ5X; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEs1KQ5X"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so3365116f8f.0
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790701041; x=1791305841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJFH2IjoTkwJen4b0adRNofV230zNzAQykwUxRXPcMY=;
        b=oEs1KQ5XYeGt6Uno3GqAIF3EWs3zFQZroy8GNmPiespyfCko8nwviONyA5Zdg6itHu
         CbUbaMZlL3abWttJK8soCb4BDg8wzAN/jXbP8PlsdpDSM25Da7cGNpR7e0mL5ITd+DSr
         vde1BJV6v6in7krdH8rCbwPGRXnaaQ+nNURkfAysF6qKnMENUOLgaOGxixqRToyWqENF
         +FdEZ+5Z+Tfiv8Nbweb8xg9MumJYMsEd09hvb8gMFq40yDJmaOOS06VlKF49h2bDx4/Z
         +zE1ySBuw5c1Rzy7nCztAwSkiuj3Kd+CxFgcAeQ0+zvHMdHPc+mnnF/hi+s48kn3h709
         TfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701041; x=1791305841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wJFH2IjoTkwJen4b0adRNofV230zNzAQykwUxRXPcMY=;
        b=OxK3zmgu9KCPFS0RfuY7PRdCKXFUZ5OlarVS+uBceEGyK9bX14V1VAGqQJT9tLQvUS
         nz3F6D20a6GK6ZscCNWdlBA4AGwSp8+9fxpGYwShqZuv83r/jCO7kN2mcIHjhkRWGnN6
         RmCS5E6I1/d94Uph/K5DcU9BjAuQxuE9Uk/X26T7azj9MkJagab6Dwrsd83TkmljzP6c
         6EPyBeUf/w7UeAVkp+Uchw+qSzwHZKVSKYDqj553ja3BNbL3EVUocg8oU3D0w/fLI+nC
         MzlBl/IWiB04hpfb6kPjXGsDRsQV4/wcyEpKt4I9wCc6z0kPrhUgnvKL7P8JBW0+sjlK
         AQIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHNGNdtEQO13bh19v8O0GrSceedLHW7nlksywHYYlaXzH0nYSEob000gleVBEhJHaxolCYVeo8woY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/fOKhA94ZkBR8+tr6YA7GH/tre1LedyGNZGy+xJoC2VDZLMpe
	WGaZDRCz8ov+XVnXpxylXAjyZXVXJZUdp9QbOaj7yPdhfSiGa+TaZ5jo
X-Gm-Gg: AYBFou1hJsqKfAKrVdkT3YJdkMTchVtzAMc9pCeFsUey8KN3NdnS89dblV43CniK3Lk
	kxSCHNGLSVBuvpFbO0ZOs9/fzYs4i4Qsu2IBchcqvYVCLqQxn49btaGLSDPRBcg9Tnsi6dGFiPz
	FqOfuxzw9rxlN/DtlkRRrMwUAHDBg44jY4ZBY4slKPOoAZCk7PUAhIo1ZJ/hTtXxbO5MO89VWoz
	L7L/hMZXan7eWt184y0X8msXWiBPxpW0po+qUR16PyAqhRR6pLcj4S0fbttPCCLqjdOZrzGJOug
	Sx4JRbSn6Sg7cOmwtt7N/U3Gt4NSxkPgFxQbtgRVmnVMI+QqPtPs0y/jkWLSWsGaKKb86XWI+7O
	+CfJl8usXdSS0vMfFt7afTxeSPHux7ligMD29EqEXiBWefao7UAKVXPzmM7Fiw0JUeJHLL2laR8
	jBWsCLt0hvRNGB84Mdrvp3/K98gvM3krj2IcWO1hDQBFhqPu3c17hFe0GD9tImPKt+QrNnpdigg
	9JlBi4b8zGC0wZXLYq0sojRU2IidJvIdhckfA11
X-Received: by 2002:a05:6000:98f:b0:488:8823:f9ec with SMTP id ffacd0b85a97d-488882404c7mr18420237f8f.34.1790701040835;
        Tue, 29 Sep 2026 09:57:20 -0700 (PDT)
Received: from ws1-mint.emulab.it ([2a01:b600:90d3:0:7e:12ca:700a:85e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe61c876sm57777f8f.3.2026.09.29.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:57:20 -0700 (PDT)
From: Simone Chifari <simone.chifari@gmail.com>
To: Adamyno <padamyno@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Stefan Schaeckeler <schaecsn@gmx.net>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus adapter
Date: Tue, 29 Sep 2026 18:57:19 +0200
Message-ID: <20260929165719.403487-1-simone.chifari@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928080640.550879-1-padamyno@gmail.com>
References: <20260928080640.550879-1-padamyno@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026 at 10:06:26AM +0200, Adamyno wrote:
> I tested this driver end-to-end on real hardware. Code as published at
> https://github.com/systempal/i2c-imc-skylake (matching the v3/v4 series;
> the v4 rework did not change anything relevant to this test).

Hi Adamyno,

thanks for testing, and for the detailed report. It is the first
report from a board other than mine, and it will go into the next
cover letter as such: a second vendor and BIOS, SMBCNTL reading 0 where
mine reads 0xac000000, ee1004 on all eight modules, and the RGB write
traffic through both adapters.

For the record, since the tag lands on the v3 thread: the GitHub main
you tested has the same transfer path as v4 and only adds shutdown
handling that is not part of the series. I will carry

Tested-by: Adamyno <padamyno@gmail.com>

in the next revision, unless v4 is applied as is.

If you have time for more, two read-only measurements would help with
the question this series still leaves open: whether the firmware uses
the engine behind the driver's back. The numbers in the v4 cover letter
come from my board only, and yours has a different BIOS. Both scripts
are in tools/ of the same repository (see tools/README.md) and only
read config space:

  # OpenRGB closed, driver unloaded: anything that moves is firmware
  sudo modprobe -r i2c_imc_skylake
  sudo ./tools/watch-engine.sh --seconds 3600
  sudo ./tools/dump-pcu-config.sh --settle 10

The raw output is what matters, and it would be credited to you in the
cover letter. A suspend/resume cycle during the watch-engine hour would
make it even more useful.

> One observation that may be worth adding to the driver documentation:
> the RGB controller ICs on G.Skill Trident Z RGB DIMMs answer at SMBus
> addresses 0x70-0x73 on this bus (4 per channel), not the 0x39-0x3D
> range that older OpenRGB-era documentation assumed.

Useful to know, but I think it fits OpenRGB's documentation better
than the driver's: the driver does not know about the devices behind
it, and ENE controllers can be re-addressed at runtime (OpenRGB's
detector does exactly that), so the address depends on the modules and
on the firmware or software that set them up.

Thanks,
Simone

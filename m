Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D02DC32C;
	Thu, 23 Apr 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953201; cv=none; b=f2sA0MEcTNU+2WioXXpey6W3nl7fyqsAd9/gEMXzIgT67P4eEqNUgpZCp2P/zBQF0pu067G2ANu/BkbPybGbscemkPCXyCF3Z5ogUOtXZfciaFAPqAQzzYzTHv3qY0/o2gkdgb2aKoKQdPKvwC8bEx146JFNvPLoMcuG9MZrHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953201; c=relaxed/simple;
	bh=Eqh5lBPKycPDN7GRwYNRKp2ahNPFkqvtOYc9wY9ETSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBtA07etEcLXrCmDXC3n2z2B5DDTzNz2eBZ0vOpMn0rb4PQJa1o1i+WfNlrHTsKSahWf26m3wLaUHm/po5BuWVYAcTIRhwnBbMHJEeLdc5JCRzPNQRY2lnmmAkwSmmdWLchw15iLjhJmk3KNsikmYfFe3mrJ3kTLgwq6tu8h1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=X7lYl2yI; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="X7lYl2yI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CF3811218E;
	Thu, 23 Apr 2026 16:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776953197;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=s3SefhIoL/isBNCFD1kBFH76UYZjae5zQ49OCSJALu8=;
	b=X7lYl2yITF/c8WFc2hBZUjkIUNDDv4gVxZTJ3xmVdwG+SFa2yCBK4hmIiEpDMgIvqGrZTv
	lfsTISmkDQevJd/cF7p/0qTYU+gzxdgwI+y9kDYXQmk/3EB53MrbI2V9FFb3Vkvv4a8lw8
	su9dfzj7YKUdThuszoa55QPCdMWfNooFhKCITvGfEPTjcaMWwH3OgtfPhQXqsTt1WPkqwm
	/3H5WXt2qKPGvDlBoC9VSXNHknRRHf/VOuhR5q64CFuh0ibkCGnlc3vnsXO32TCiuBBId8
	vuyW0dMiaQC/qAgGPYab3r/OisDp5+NvFw8ZqzLQRiSukvrl34zhfs+5RhgmSQ==
Message-ID: <bcbcc7b6-dede-4918-b229-bf546fb1742c@nabladev.com>
Date: Thu, 23 Apr 2026 16:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srini@kernel.org>, linux-kernel@vger.kernel.org
References: <20260421140755.54222-1-marex@nabladev.com>
 <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
 <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com>
 <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
 <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com>
 <faba330b-f98a-4e52-a180-d62cdb9a24eb@nabladev.com>
 <CAMRc=Mfam_wONk+chgEi_hefBj+2+zhcSfbo0=Lxr_vOnvL1MA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAMRc=Mfam_wONk+chgEi_hefBj+2+zhcSfbo0=Lxr_vOnvL1MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/23/26 2:17 PM, Bartosz Golaszewski wrote:
> On Thu, Apr 23, 2026 at 2:04 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>>>
>>> I see. Ok, please send a v2.
>> Does this patch require any changes ?
>>
>> I will be sending the DT changes separately.
> 
> Sashiko is saying this:
> https://sashiko.dev/#/patchset/20260421140755.54222-1-marex%40nabladev.com

What does this mean ?

> Shouldn't we report the device as read-only in sysfs unless it was
> "unlocked" with force_ro?
This would be ideal, but I did not find a way to toggle the "nvmem" bin 
attr permissions at runtime. Is that even possible ?

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36813F8ED8;
	Thu, 28 May 2026 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987604; cv=none; b=DuiBfMSk2tMlzYEc4calfcnHho6nrOePs3Zs0U9ya7lLIaKGFNCjdhDV5iDuI2ljuHLByFEQHqVH9qG+moGbeJQM57z7CJneCQCvRsZmjRGVmTIrgy6L5k3YWI293RIQzw/EbJZU6cwoPK4BYcK9OkEyMbpE+wOkFMp3alHeiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987604; c=relaxed/simple;
	bh=c0j6BKXmo8TidFtpaFIR/Q/SbV/r1l/J8fhHmvMq0Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQWfxaGdOY3qbwpVmCHEM8pGmSsZwml4HizrE6NsKsea9hnnPAISpfvVqjPj/thk9OmRZziLn68dIYFFx1b6msj5TbCfPBOayrudbrKiObGodOo3CvWfgtDvEPR3gZbZtHcEuOJ6TucG0T0YuMPX96ZNL2FU5JO5XOBh2ximAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfzZkMaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfzZkMaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57EA1F000E9;
	Thu, 28 May 2026 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779987603;
	bh=f6mPVRRqxQKhd1skZQP3XxgkaOHlgDfBB9jknp+5Vv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lfzZkMaWbYyl6bL9AEcOLjL5GxcKGRbTNqdcz+VYXH51cEOX1PUygdUyibGBvC1Ft
	 44NVDyCdtypFaj7T12UIky0qPt6Wehl3vDnsZ8P2g95CbL05daYY4gY2edxewgWZdc
	 MNrGOzXrs4R8aJNfFvlF8TAjfe/MwuOJxh+wobD/hH8IUqZX8JGzvmmogyToV36MsV
	 C+XTDPZcK7gOpzLYz21nIwBxVfcPB4Kcy/rOaOs+W/m3NLq7xrP1lyQbGLVCoYXVOU
	 2NWcWXK92GCI7FNv1O28QUhbujhhSmstBpQn9cTReVrN/yfM9zhJ3Z6MLPIowIEBXj
	 FumPR0Vi/3viA==
Message-ID: <5d322a10-12ee-4157-872f-c549762b0f7d@kernel.org>
Date: Thu, 28 May 2026 20:00:00 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] i2c: riic: Drop the space in front of the "out" goto
 label
To: Wolfram Sang <wsa@sang-engineering.com>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org,
 claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520131206.932050-1-claudiu.beznea@kernel.org>
 <20260520131206.932050-4-claudiu.beznea@kernel.org>
 <ahhMX0hdr43K9eLa@shikoro>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <ahhMX0hdr43K9eLa@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/26 17:08, Wolfram Sang wrote:
> On Wed, May 20, 2026 at 04:12:05PM +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Drop the space in front of the "out" goto label from riic_xfer() to follow
>> the pattern used in tree.
> 
> Time for this quote again :)
> 
>>> "> It is generally accepted to indent labels with a single space. This
>>>   > avoids breaking the -p option of diff."

OK, I wasn't aware of this. Should we align the other goto label to this, for 
consistency?

> 
> And yeah, I have been bitten by that.
> 

-- 
Thank you,
Claudiu


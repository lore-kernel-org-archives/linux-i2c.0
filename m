Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355420FA81
	for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214265; cv=none; b=WzNE52GtH/BmofskH2vTXTsTjREldOn+XBZLGPSODpsxTQq/ZAe2EGoQuWz5CK4s4X39GEYOu/B8JEK9jhfZZXObwzNOrYpU9H/KL3QfcqFO6+0j+5mabMDXr6RH+aFdeJazZ/8oMZFO+B8CTew2z/MwGavxOktPclfVBdct5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214265; c=relaxed/simple;
	bh=TrlkWhLUYKYqpfyhjFtzdNcVUv+jgrxruyGC3ITjANk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=uvYze0emT8+eN5GmzfuF5SCAPmP+LB3NrrdKnaufE5uxL5gb8Ni+MX+pl2NFzEF3I3p0gCOgDB3q385X83SulYCJdcp4n96Jvz86OwmWF1f4JLyWHztl9MxEaQc6rhhRqyf0geCvhp6KnAY794TuV+5yyG82lfO+MnPTMSBwRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=LZTm7zvC; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="LZTm7zvC"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso1821472eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 18:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214263; x=1790819063; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WltkXwT4z+eov17Qfylxi2pHojB612CmH3f4OFtUAec=;
        b=LZTm7zvC+LVqyxsBfBCSFXDg3ILhm0U0VQXEzsfIRqvz/+8UcGAwtrn43Ylkqf5uVK
         Lhh0UyAbwkR2OdPSK9OoXeTSlJwi73XWd86Cpo1cNhPwUNxMvUwfMdytl0CblXGCPkyR
         L1f2zFTTlwgg/R2YpCKo+MxJZRGW9iM4Xhw/EbafG6h0USWaowCToS0V3HfnmsatEFpV
         PNdHB9O8OkgTke5taGtTlNDlWLOvRoj0LoVSo3kDpl/SZY3YGchIUYSXjLCTnR01Sis/
         m47Ka232wd0vgCVs/k/3gLXA8sNVt0wyW/PUma601Ckuijlxcx+dxBp0XXy0T+1rU8sV
         NxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214263; x=1790819063;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WltkXwT4z+eov17Qfylxi2pHojB612CmH3f4OFtUAec=;
        b=XaaNzSjQPqOT5t7k54JIungDlG1h494fljkl2WM4MrZuNedGKm1Aq8W9W5En4EHlm6
         xxanF8/VSmmvCjipnWpQWm01k33cL9ID4F39ScxxgBHmkkrCI4yuGEPZ23YsBh6WMdBN
         1uYl0mbq6y8xKfZMojK/Tj/HawCZoJBPT0Ghyq3Gt4asU3aTeRo6Jj+21f0SEBq+ootU
         BLJnd1o+uQ17GkxpB/hpX20/8njBcKul6jJHR1hsymGT+HQ5C0prXCZoEbn5ciO+J+Jr
         C4bcwazIDy6N8C+q4+a145+/hlruS27TVQLM+XV8SjjGi+mjH7IvMYtwdCb3sAdLw+G9
         cenQ==
X-Forwarded-Encrypted: i=1; AKwUvBz05jcJukmEURN6yW3ZOB1O2r/Nel31/AoRxQd7xUR1ghayrQYTMKC+mE2m/HV7CrenJNYVXaXf3SQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n/pRGyM91eNJixgMbEOSrFCJts9NucN+TEXNalqpX9squXci3N
	KT6pIna0CaEPD8GFqWNJ5qoxDaIxDl4mx0LJcUZKVxvbt0V62NPwYyvu/wABnmrig+Y=
X-Gm-Gg: AYBFou2njRi4kmbhNdMKgeHOq7GD6O85KlxSahSONKC+uIa1aHMd5r3fJC+aAdb5KOA
	s2DRxMsYTZx2i8zhrInWOs8llZrKXLBS7NHBqNcDxYJKNVnpsv3f2qtVs6dInN9p1luAeafU630
	pFkBBAzSpJn+5W746ehLsfoS1PmqhV9JPqcU39pRUi/XHpBSqPgKb9wXWoAS+lEi25WvpKgtUbJ
	phI2n4CUnR0zD6v1fR/8Hog3hwm+pKs3NQn1+RGAVTaRCRT9yTn+bSCj+OvEHpygcRNwkjQ4coQ
	UiTZzdeYmAphNgTVGHl5iIBOliZUPWSG/a7AutImlq9ge5HyTxVnQpRcGin06Z0iAL83cU+K0qu
	2VfuXuYbQF7JqCarqcPku63Go2rp4IjYhFMaHTcqlWs3F6Kd2gpuLoQc8Xd3XyhXNhBH2CK3ddn
	cHSnirTWcAARpWE9UKFxIb9d3fxX7CX/NT4654Mvra54l6TYhETpDpCMqEQYhyU7YMziiBMeaWy
	VT0cR5Dqw==
X-Received: by 2002:a05:7300:238b:b0:33e:451e:c8b2 with SMTP id 5a478bee46e88-34006f826a1mr891609eec.37.1790214262980;
        Wed, 23 Sep 2026 18:44:22 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm9920817eec.3.2026.09.23.18.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 18:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 18:44:21 -0700
Message-Id: <DLN5ZQ7GWNQU.3S23BUADOK8M@nexthop.ai>
Subject: Re: [PATCH v5 1/3] i2c: xiic: preserve PEC byte length in SMBus
 block read setup
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Raviteja Narayanam"
 <raviteja.narayanam@xilinx.com>, "Wolfram Sang" <wsa@kernel.org>,
 "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>, "Shubhrajyoti Datta"
 <shubhrajyoti.datta@amd.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
 <20260921-i2c-xiic-v5-1-2fca81e810ea@nexthop.ai>
 <arPW6xckt7QMpt7C@zenone.zhora.eu>
In-Reply-To: <arPW6xckt7QMpt7C@zenone.zhora.eu>

On Wed Sep 23, 2026 at 11:04 AM PDT, Andi Shyti wrote:
>> +			/*
>> +			 * Undo the setup-time padding before rx_msg is cleared,
>> +			 * so the PEC check sees the right byte.
>> +			 */
>> +			if (i2c->rx_msg && i2c->smbus_actual_len)
>> +				i2c->rx_msg->len =3D i2c->smbus_actual_len;
>
> I think this restore needs to go also in xiic_recv_atomic.
>
> Andi
>

Yes. I2C_M_RECV_LEN forces standard mode for the whole transfer, so an
atomic block read hits the same padded branch and then completes in
xiic_recv_atomic() without the trim.

v6 pulls the trim into a xiic_smbus_trim_len() helper and calls it from
both sites that clear rx_msg. Patches 2 and 3 unchanged.

Abdurrahman

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115495;
	b=Gzgj6PUnjCToYjlCDLHvcprAHDaxSklsuQlqjNlHEgV7hTuf0kZw+6V/upJo1YScGN5k
	 UPFJuDE1j0k9AT3lHlTVgA24gqqEyVFp1bCZLKykwhtDp25N3UtHds7qKxvFbMVGjvdYK
	 Dg1xjJdZUQ4WVhzPIqa5cF03gt+QIAYygEiFS7Ugvcd1GerO3cMrV8eDGlTX2Jbx0D7X8
	 zjNLWqks2mnTJrLVNj1YIvdLo7HMjyPd5ANojUQ+NNanSSrMB+lD7Q0MTCv+kewtdlT2e
	 tNKp4jbCo7k6mrK8T2hfgJbGEBRUr9Igd9OQ4RU5U+ULEPfFRowmQBLKcQmhAhGvrzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115495;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=mf4aLKAJISSzznRXGqPfLHizFprMDNg73CHAl3V4K3I=;
	b=o14IsHQbvL0tr+GZMrA2UXkhqu00GuhqUEzRVzd3HCFrtAxGGae2DYisshDzaQeIx83X
	 G0DRKTn2ZT1QQgfYfMumB8jRFq42/yL/zFW0M3JFAp8sKVPjrAj+GeGyQ096uvWkegPtJ
	 /fyS2ewiw7/ZCKsdkUSA5JcPNXJ9ZwYxWca018dcxq3eljgStz3uWDirqzE99pyZYqoVE
	 JDs/YBvPsbP9Cnk7U5v/UlylRXTUyBuC9kFC+Wp12j7Iqe85VY2A49urhV8czzU/iSDot
	 yPRka7Qt5i9Opo/S9DotJO5fhrQqAOUDslW2sniUmGcFWQjrjQBY9Z+WtywhQjWl7Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="bPb/eZNE";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05460A2604
	for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 19:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D05460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bPb/eZNE
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6C06E4E41672;
	Thu, 19 Nov 2026 19:11:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A2EF6035B;
	Thu, 19 Nov 2026 19:11:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD13A11BC03AB;
	Thu, 19 Nov 2026 20:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795115486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mf4aLKAJISSzznRXGqPfLHizFprMDNg73CHAl3V4K3I=;
	b=bPb/eZNE+7iL42rsbu37kZ8sagGOTIHbBjZKMPDrr+DxMnAwiW16QqbSJQqywH5bBkKcN8
	Y4aodr1k4knjh05a85WoHhOsevt1VVxBMhF70VOPtfeKM7XLhPsM7LJxY8S6ThK2njBOu4
	ao+ebxbKXyzYfEbqC0IMGqkmk502oT4PUBmRDl7owS3snlAWrDo6HDipyp/74blDW7DO2X
	RGIVdTY4zKUGTWD/3Icf8xM2eaBR/Tkfzrk3K1/5CJRPeVcSK21GlK5kqyrubdqGr2B1o6
	SeEYPwcqH6rEP62lIU4DPvfkVtKGzUOC5fcyOfixTcy73tjrcm0uI4CGzU5JeA==
Message-ID: <70053889-0a00-412f-a4bf-4fa4119563b0@bootlin.com>
Date: Thu, 19 Nov 2026 20:11:23 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Congatec Board Controller: Add storage devices
 support
To: Lee Jones <lee@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261119190350.GB70182@joneslee-macbookpro.roam.internal>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20261119190350.GB70182@joneslee-macbookpro.roam.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/19/26 8:03 PM, Lee Jones wrote:
> On Tue, 17 Nov 2026, Thomas Richard (congatec GmbH) wrote:
> 
>> This is the 6th iteration. As discussed with Lee [1] I just picked his I2C
>> patch [2] (to handle the conflict) and rebased the series on top of
>> next-20261116.
>>
>> [1] https://lore.kernel.org/all/c9d26395-93f8-4e63-9cd0-586ce913931b@bootlin.com/
>> [2] https://lore.kernel.org/all/20261027093306.2812695-27-lee@kernel.org/
> 
> I assume this all needs to go in at once?

Yes please.

Best Regards,
Thomas

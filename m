Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688673;
	b=Ru877SUGLpCOfsje5ysIIs2xQbnYwgt3TGmuT5aHc7H4JkUvDTXBbv8AHGG7wHprH8nZ
	 hhLzuIqmZonXUFAPIZF+LoplIG/uOqn0onWJKfTY0EFcQmBdAx5LAmc5Pd4BjtRbsSIaE
	 tKe9lik/SsFXYptay7QwX9jFJn9VYhBeI+LJYvmAi57fV3WoSdQOK8gSXct83a4oO8bYu
	 GTyLNYZDqy7gShNfem2ntNj8dOWjVPR1nv6i680m30L8aM7Zb5a4OCj3x3cgOfgbMnpju
	 9BdGCYOPhsxeZEhQ/Tr4knchimJ3TJI80BWkX0ykLN1lqSs3cBKx5vIyMvtoWm2RwPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688673;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=HWXhD2T0YqRDo710NdzVWCmw80S5rSuIE5qAwGglR9Q=;
	b=pL1LmhWvIz1MgQaMw5HLL9G64Hro1V09PFVk2V1CZ067X7XjdJSOJfN+akPM7OKBt+hh
	 Lq4wYg2cNl+EmMdxnbEOUC+QHn2oDm9Ul6CmgA9A7dltVX9BWwF0THFnW/ITbpAqi9gwj
	 MIfWmT6S1b4TL7mx7mw6eyw7sa7tn1o7F7WDFAOBsR5UGNqfB5FGzorzD5hbqKx+dKfLi
	 7EDxtjIWhbIaOrG1OJ9l7XLz0GVVuFm0Y8/iIIOQWlqJ/iI3NULn+GrFXv+COHNX1R5do
	 E2FWRbdJ28OkYP9Yw4ayXlAUv1tyvIfi/sHy0n6i3JVux/UY4pJp0QAd6P2G7wNlKnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hT2tNv90;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F734606A31E;
	Thu, 26 Nov 2026 10:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F734606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hT2tNv90
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0704C2B9C6;
	Thu, 26 Nov 2026 10:24:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E7F660237;
	Thu, 26 Nov 2026 10:24:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA70211E6A5EC;
	Thu, 26 Nov 2026 11:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795688670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HWXhD2T0YqRDo710NdzVWCmw80S5rSuIE5qAwGglR9Q=;
	b=hT2tNv90ahKjUQOa2PA9w+ig6qobgxqJGnnsNUsMe71Jj8uMN8jI0+7woKeG0XQaba8s0o
	0rAl+v6dGXw4zWstY2by8epYPzTD5qX1FVC1uOwpzCXMj/WMNc3WlmvZm4NSX/XIvKuUtW
	hauygcBny7aVlM+8z562vmsGNdssOq23cbAQyamxzOAtiIyXLuk+9+I7R6nF3vyIXQa8I1
	ERBxzOI9xKVeJFR7U/5t3dHbdxa1y4cgcpbO2kj+tkIjnA5xEzjXeIDBLyZDweWd1yb5K2
	HW8RIJYF3jsf2v2aGJ1gp/H/bR9/4AKnOtOKsGIv1UbbIAaM9Qz2PXhe93g5Tw==
Message-ID: <0e983410-bc97-46cf-9ee0-c4cd11dcfa64@bootlin.com>
Date: Thu, 26 Nov 2026 11:24:28 +0100
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
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
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
> 
> So we just need the I2C Acks, then I can take the set and send out a PR.

Hi Andi,

Could you have a look to the I2C patches, Lee is waiting your ack to
apply the series in his tree.

Best Regards,
Thomas

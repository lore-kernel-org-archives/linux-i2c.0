Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41102DCBE3;
	Tue, 21 Apr 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794204; cv=none; b=IQgdlsWCQaoSNTdTKRLxaVOcArGGeEF1WAaSIIYOloMjAF4BRdvAJCxdYzSLdzq9/5ZKm3g/ldPymTLCssHZVZAD3DNESBG54Quy3byJi6E+UO0VeRpJaDuFAzuXXjfC0ltd0yoiVHPLiOwZe1BS4DxxfjrvuN8PBaXfL8jClbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794204; c=relaxed/simple;
	bh=5gEHNlbZh2+8Ht5IDBDOsbR5Lo8y07nAVgrC5rxu9Dc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FdVpsxF2OZ7lqeRBBcbqFw1On7Fn1kR48RW0xHkwGcyv1tcra2t/xcLsoSLpX8gH4B2VIEla5+hPwlBV2yf3dP22EtHFhNZBoUW4azvzgH2EVuDZfKPek+PKYgSH4ZctwtmQtoLPM+unLTyiOfr+QaXufbSrEMDeoTYziOgmHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=kSYQSDw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GcGHKQ2m; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="kSYQSDw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcGHKQ2m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A336E7A01F6;
	Tue, 21 Apr 2026 13:56:41 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Tue, 21 Apr 2026 13:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1776794201;
	 x=1776880601; bh=9nuTmOqIosdWD9SOJVUFmWqu51lZeuw2qobRl27mz9M=; b=
	kSYQSDw6zzobQIXDX0938t6DSo29anpEVY0ubeuREU15qLGktBEugppFeA1NgkIc
	DWvkInJZvYIbLPoJrN76Ncz/AoELhpYHBgMeLJfdUfdo6+N78QDUqLe2ZYqSlmKg
	5DotQ4BnQ/j4SxScQOijdxSDpOYvaqL+Hdm5382GqUUwtQC7pHUstUo1XRmZafbQ
	YaLJCPyS/gKEFILZEYVzV+5Pe77IzKZMrWInO+oj07cWhRYoKpjv7CCUbUFnfeaV
	ny219pRDJxwDVCURTfhAflQRhLzVaAQMtblPsFWthaZHwalCKrMFZ/jinf7Hvpa6
	qBIWNdf/BphmvZFaQjC3bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776794201; x=
	1776880601; bh=9nuTmOqIosdWD9SOJVUFmWqu51lZeuw2qobRl27mz9M=; b=G
	cGHKQ2mVIiKQTghZoCa8wyG4B7cKdgX2to562ctApz84n3B6yfRK6N1KltYF0EsA
	5ZQp5TvNr8fwuyiPPxR7udFUoKUIC8vcjJw3LJjUtMISnPb04p6E8RvbCJBJ0+RP
	P9AjL3pkDbb4M7lXoWYKGxF67F7Ntt/sS0i0cGakuXqpa+UYA0+a02vEYBy8NJKN
	q0t5wO56wVFN5CJPD23RxRueAjVOgos+5kI98KhhkoRM4OWfQixKbipawVuDYFOu
	C4DODKm5S7M8hAzlry4qxpwQndgFBJB0uQrRa9dOLPohm5RjZK6gLm2NRoImCuaw
	/KtXN7wkNcYbeyQm6qkiA==
X-ME-Sender: <xms:WbrnablE_InQwAGVZTBWoOIUKBH0IyEVUTp0EjGhygx5qYwOEmUj2g>
    <xme:WbrnaZpMQgq_vERPNGr08nWpQxhhTzprZzLVA5HPEMH4Z7kZjbzQxzZ1QtTIl92x9
    xmXrvIQibjSRVprysKQYI4gQ2VMPjXIPfOXgXlUE6hxLXinrXyDde7B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnsehsqhhuvggssgdrtggrqeenucggtffrrg
    htthgvrhhnpeeijefhleejkeejkeetffehieduueevgfdvgeejleegjedvvdejffdvvdek
    keegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmphgvrghrshhonhesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhinhhsrggvthgruggvshhsvgdvtdduheesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrnhguihdrshhhhihtiheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepfihsrgdorhgvnhgvshgrshesshgrnhhgqdgvnhhgihhnvggvrh
    hinhhgrdgtohhmpdhrtghpthhtohepjhguvghlvhgrrhgvsehsuhhsvgdrtghomhdprhgt
    phhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WbrnaeEI1CW3rzu4NmxUBQCp9MmEAHdwiMy8WCI0Cn20p7iXhYFd1g>
    <xmx:WbrnaaQM3nfxBBl5yEyckTM1kcOBv387s4wmhatVR8wwUnO0lJ0TwA>
    <xmx:WbrnaXIwH3aO6iLHoX6You1OMauK1TyjgSthOfHFElnPrBL5iNZZxQ>
    <xmx:WbrnadYQtNRflGFcTIfdeA65t5SuANaQYUVkWZh1pMAhFDNzN-Zslg>
    <xmx:WbrnabCkKAdA7Q7i0dQZZfqYkhtDCpC71Z_HKBN4-hUy19a8zf-WqfwO>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F0C542CE3F93; Tue, 21 Apr 2026 13:56:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzstPrEaVVm-
Date: Tue, 21 Apr 2026 13:56:20 -0400
From: "Mark Pearson" <mpearson@squebb.ca>
To: "TINSAE TADESSE" <tinsaetadesse2015@gmail.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Jean Delvare" <jdelvare@suse.com>, "Andi Shyti" <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <371b0658-7cbb-400e-b48b-5d7b46cf150d@app.fastmail.com>
In-Reply-To: 
 <CAJ12PfPdkQD6VNROdSGYRWvHGf0FZ61Y-vF2uMB+vsnV1-KNNg@mail.gmail.com>
References: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
 <CAJ12PfPdkQD6VNROdSGYRWvHGf0FZ61Y-vF2uMB+vsnV1-KNNg@mail.gmail.com>
Subject: Re: [PATCH 0/2] i2c: i801: Detect SPD Write Disable and expose as adapter
 quirk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tinsae,

On Sat, Feb 21, 2026, at 4:57 AM, TINSAE TADESSE wrote:
> On Thu, Feb 5, 2026 at 1:29=E2=80=AFPM Tinsae Tadesse
> <tinsaetadesse2015@gmail.com> wrote:
>>
>> Hi I2C and HWMON maintainers,
>>
>> Intel i801 SMBus controllers feature a "SPD Write Disable" bit
>> in the SMBHSTCFG register. When set by firmware, the hardware
>> silently blocks all write transactions to the SPD EEPROM
>> address range (0x50-0x57) while allowing reads to succeed.
>>
>> This creates a significant issue for the spd5118 hwmon driver.
>> The SPD5118 requires write access for switching between
>> register pages to read temperature data, and for cache
>> synchronization during suspend/resume. When SPD Write Disable
>> is set and the spd5118 driver attempts write transactions, the
>> bus will generate a storm of SMBus DEV_ERR messages.
>>
>> This patch series proposes a generic solution by:
>> 1. Introducing a new adapter quirk flag in include/linux/i2c.h
>> to communicate this hardware restriction.
>> 2. Modifying drivers/i2c/i2c-i801.c to detect the SPD Write
>> Disable bit and set the quirk flag.
>> 3. Modifying drivers/hwmon/spd5118.c to check for this quirk
>> during probe and fail cleanly, as write access is mandatory.
>>
>> By using this mechanism, we avoid embedding device-specific
>> policies in the controller driver and provide client drivers
>> with the necessary information to make an informed decision.
>>
>> Tinsae Tadesse (2):
>>   i2c: i801: Detect SPD Write Disable and expose as adapter quirk
>>   hwmon: spd5118: Fail probe if SPD writes are disabled
>>
>>  drivers/hwmon/spd5118.c       | 15 +++++++++++++++
>>  drivers/i2c/busses/i2c-i801.c | 16 +++++++++++++++-
>>  include/linux/i2c.h           |  3 +++
>>  3 files changed, 33 insertions(+), 1 deletion(-)
>>
>> --
>> 2.52.0
>>
>

I'm hitting a very similar problem on all the Lenovo 2026 Linux certifie=
d platforms.
Your patch is great, and I wanted to add a tested-by tag to say it fixed=
 the issue for me, but it doesn't quite unfortunately.

I added this change (hack?) in i2c-smbus.c to take advantage of your cha=
nges and fix the issue that I'm seeing:

 void i2c_register_spd_write_enable(struct i2c_adapter *adap)
 {
-       i2c_register_spd(adap, false);
+       if (adap->quirks && adap->quirks->flags & I2C_AQ_SPD_WRITE_DISAB=
LED)
+               i2c_register_spd(adap, true);
+       else
+               i2c_register_spd(adap, false);
 }

What do you think? Any side effects or impacts you can foresee based on =
your testing?

Maintainers - would love your opinion too. I suspect this may become a c=
ommon issue.

Mark

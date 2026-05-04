Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2DF36214C;
	Mon,  4 May 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777930946; cv=none; b=lUp5QE3UNWqyKo5dS5VC9S+ccOXxNYdD88oBnmXW2jltbYIyp806E2D4y3aO6S4VJKsBbMUmft1L385GKSgZlLHoMo5HQ5TOzOV1vm0xEmuseh16TV9GzzwPOuTccrQbhmdfdJUuS4O6qYwLSiLhr4AtuKtefUO4RBAABC4aq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777930946; c=relaxed/simple;
	bh=uV2LmGNonj6F8+bt5LSgDRzIMe9qH7jsnmiv54M1DG8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Td4mbGdKC4hua3viKisNewdIHVchtm1amWZCu9HlZuszFq7iyM64NVmikM5n0HZmtbfV89/HbTDaCLikgCe6/iUt0DlJUS3YphGacDq6B76hNfe9zexq2gWm/6gq6Ft9/yMWozY91rgXLeVXUJytZw+2o+pdHrvT8aIk3J1ICmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=OAfPhbyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YU583foF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="OAfPhbyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YU583foF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11F3514000EC;
	Mon,  4 May 2026 17:42:24 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Mon, 04 May 2026 17:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777930944;
	 x=1778017344; bh=jGCUO9ChlC6SFajnQCDMepIm9tnZTgY0QhnZxW5P1Vw=; b=
	OAfPhbyScE1+CkWPIELjt0JWGtWhkSNIl9lyqdRH9VTITO/6qc6G4beti9GvTMM/
	9+0LPdSVrU+8MfD29DKsEqWGFDnLwkzlBCFGnZ3wsdH5EM8yJCtcYM3sAbSk1q+o
	l/x7mhlo++eSXDcy2jLLQVay2SQcB2hpTkSjXEbCAebdKDS/Z4KQ+rN8CdrT/g+N
	6xbcwi37d2i2gV8Xx+wPA20DJ7fBkYoF6G1ACjTcRZktJJCBvb+y51OY2nqv8LYa
	4K36rpiqHrYZN2CmScdA7b9o7s7uBt4dxwZYRgu9tKE2H2pTF3cghDpEo2GC6Vdy
	uMmEsQelkGeBI++mdJcCLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777930944; x=
	1778017344; bh=jGCUO9ChlC6SFajnQCDMepIm9tnZTgY0QhnZxW5P1Vw=; b=Y
	U583foFrz89WZztB0JVVreAPww0ZqQiShQ5dRjVaDi0s6FyTfbP47x128mRoOKYt
	GtFfWcBkgSlyuIx8ikg9cBazZ7IYud4Hd5+yqqP8pDbE8a4s0UPmxijXy07eZA78
	ZEUr0sf0kmB9dywmx1zXickbhnRn37lpbtQPBIXDu7JU40e5iRPMZkqe/7PzDyhP
	C6qnElxFscW2JWXYbYe3rPCPzvAy9L+6AY1dnJIrKgZV0V5Gs/ecTa0OrjR4ScAm
	DKLbmnmOouAUxKbSePbOhpg33zyytFCXGV0W5y9C/ES4HuAv8vQJKjyp3V4EMooU
	0xq+1Fgn36FDuTumKtkVg==
X-ME-Sender: <xms:vxL5aVatKGzO5Lm-3ZPQBy5xwIcJslqjz_abUl_xakf3bia7rjmLzQ>
    <xme:vxL5aXPl49MpKjTcQ4UvR4gmY8RaqoWFVmtp5oIIR4F4D0X1B6Al-kFs_Sl6yQaSI
    4TfU4BU8-GDFWm55hB3eDpSwgOMns2nVCY-kykrxVd8hCkC8kNpEE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleelhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:vxL5aWaBwh8XipMb8105SX2A4C2H-1KabPpSuMYtk85pRYnkOFFQAw>
    <xmx:vxL5aUXbSpPzsFSoU0MoP5dodpN0dgRG1HIz_AVRjSeoBXyZxqy73A>
    <xmx:vxL5af_Qg_-d7JUdDORz3CU8b2pqtXCwj6zycShS2yhK4lM4ZtqJeA>
    <xmx:vxL5ad8axwSJuC5qnVfIsvwAdpNOjcwj04Cmyo9O7zHS8Zowk4IiRg>
    <xmx:wBL5aTmYFlqzJWyIDtbdW5kBcZF7mS9MmepDieYa6dwGfGTMvtgSJ_2o>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 982842CE0072; Mon,  4 May 2026 17:42:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzstPrEaVVm-
Date: Mon, 04 May 2026 17:41:19 -0400
From: "Mark Pearson" <mpearson@squebb.ca>
To: "TINSAE TADESSE" <tinsaetadesse2015@gmail.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Jean Delvare" <jdelvare@suse.com>, "Andi Shyti" <andi.shyti@kernel.org>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <0586d251-3601-4655-99cb-ab257e00b489@app.fastmail.com>
In-Reply-To: 
 <CAJ12PfONdP2joTduNuA-A5HQRCtE-7jUO_wHOWuQBRb_HtVm2w@mail.gmail.com>
References: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
 <CAJ12PfPdkQD6VNROdSGYRWvHGf0FZ61Y-vF2uMB+vsnV1-KNNg@mail.gmail.com>
 <371b0658-7cbb-400e-b48b-5d7b46cf150d@app.fastmail.com>
 <CAJ12PfONdP2joTduNuA-A5HQRCtE-7jUO_wHOWuQBRb_HtVm2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] i2c: i801: Detect SPD Write Disable and expose as adapter
 quirk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tinsae

Sorry for the long delay in reply

On Thu, Apr 23, 2026, at 7:21 AM, TINSAE TADESSE wrote:
> On Tue, Apr 21, 2026 at 8:56=E2=80=AFPM Mark Pearson <mpearson@squebb.=
ca> wrote:
>>
>> Hi Tinsae,
>>
>> On Sat, Feb 21, 2026, at 4:57 AM, TINSAE TADESSE wrote:
>> > On Thu, Feb 5, 2026 at 1:29=E2=80=AFPM Tinsae Tadesse
>> > <tinsaetadesse2015@gmail.com> wrote:
>> >>
>> >> Hi I2C and HWMON maintainers,
>> >>
>> >> Intel i801 SMBus controllers feature a "SPD Write Disable" bit
>> >> in the SMBHSTCFG register. When set by firmware, the hardware
>> >> silently blocks all write transactions to the SPD EEPROM
>> >> address range (0x50-0x57) while allowing reads to succeed.
>> >>
>> >> This creates a significant issue for the spd5118 hwmon driver.
>> >> The SPD5118 requires write access for switching between
>> >> register pages to read temperature data, and for cache
>> >> synchronization during suspend/resume. When SPD Write Disable
>> >> is set and the spd5118 driver attempts write transactions, the
>> >> bus will generate a storm of SMBus DEV_ERR messages.
>> >>
>> >> This patch series proposes a generic solution by:
>> >> 1. Introducing a new adapter quirk flag in include/linux/i2c.h
>> >> to communicate this hardware restriction.
>> >> 2. Modifying drivers/i2c/i2c-i801.c to detect the SPD Write
>> >> Disable bit and set the quirk flag.
>> >> 3. Modifying drivers/hwmon/spd5118.c to check for this quirk
>> >> during probe and fail cleanly, as write access is mandatory.
>> >>
>> >> By using this mechanism, we avoid embedding device-specific
>> >> policies in the controller driver and provide client drivers
>> >> with the necessary information to make an informed decision.
>> >>
>> >> Tinsae Tadesse (2):
>> >>   i2c: i801: Detect SPD Write Disable and expose as adapter quirk
>> >>   hwmon: spd5118: Fail probe if SPD writes are disabled
>> >>
>> >>  drivers/hwmon/spd5118.c       | 15 +++++++++++++++
>> >>  drivers/i2c/busses/i2c-i801.c | 16 +++++++++++++++-
>> >>  include/linux/i2c.h           |  3 +++
>> >>  3 files changed, 33 insertions(+), 1 deletion(-)
>> >>
>> >> --
>> >> 2.52.0
>> >>
>> >
>>
>> I'm hitting a very similar problem on all the Lenovo 2026 Linux certi=
fied platforms.
>> Your patch is great, and I wanted to add a tested-by tag to say it fi=
xed the issue for me, but it doesn't quite unfortunately.
>>
>> I added this change (hack?) in i2c-smbus.c to take advantage of your =
changes and fix the issue that I'm seeing:
>>
>>  void i2c_register_spd_write_enable(struct i2c_adapter *adap)
>>  {
>> -       i2c_register_spd(adap, false);
>> +       if (adap->quirks && adap->quirks->flags & I2C_AQ_SPD_WRITE_DI=
SABLED)
>> +               i2c_register_spd(adap, true);
>> +       else
>> +               i2c_register_spd(adap, false);
>>  }
>>
>> What do you think? Any side effects or impacts you can foresee based =
on your testing?
>>
>> Maintainers - would love your opinion too. I suspect this may become =
a common issue.
>>
>> Mark
>
> Hi Mark,
>
> Thank you for suggesting this fix, and I apologize for the delayed res=
ponse :)
>
>> What do you think? Any side effects or impacts you can foresee based =
on your testing?
>
> I think that fix looks okay; however, it would be helpful to know whic=
h kernel
> driver was the source of your error. Additionally, having the kernel
> debug logs would help pinpoint the exact place of the problem.
>

It was on 7.0, built from Linus's tree.
I can pull up logs - but it's just when reading the DDR SPD get's trigge=
red so not terribly useful.
For me it gets triggered from i801_probe_optional_targets

>> I added this change (hack?) in i2c-smbus.c to take advantage of your =
changes and fix the issue that I'm seeing.
>
> The goal of this patch series, as you can see from the RFC, was to
> "avoid embedding device-specific policies in the controller driver and
> provide client driver with the necessary information to make an inform=
ed
> decision on whether it can operate or not under SPD Write Disable."
> Therefore, I would rather have this check in the client driver's probe=
 function,
> rather than in the SMBus controller driver.
>

Fair enough.

What about having it in the i2c-i801 driver? Something like:

-               i2c_register_spd_write_enable(&priv->adapter);
+               if (priv->adapter.quirks && priv->adapter.quirks->flags =
& I2C_AQ_SPD_WRITE_DISABLED)
+                       i2c_register_spd_write_disable(&priv->adapter);
+               else
+                       i2c_register_spd_write_enable(&priv->adapter);

Would that be better? (there are two places in that file where this chan=
ge is needed)
I confirmed this did fix it for me :)

Mark

Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591993AFAF9
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081717; cv=pass; b=B5nT+pVGEWqb++jHGMi45wSAvaPBRgQYasBOlPr5DT/J25/wx6nhvSrbHxHqp2e1X7OY9DSvFqPdy+FwYc5DdV019uU579bjAhslPSERLSlzCPhlAofOZ/wsMKC60I9PmydBeYngCwxkV3o6HLQU4yDrYi3bUgd0iS4gVV7Hjnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081717; c=relaxed/simple;
	bh=b+gaqg1zeu8diN/4RO9P1QUcgZfuCJLRsApxbAuPdmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg/pPV99fS9qOc7DXjOufHICLfhj/ZGFMx0dIgB9c7Yi4Wk/+vspviKSIZgGKciNasCNviDL5imCxWrNTdk7oEIfmasghezDQRf7/jXHaeLziGLzMZvjztqIRT9VSEgb2WHXr4zc4TPKScpzTmtWBBAIY3UM4pxRcXIjxrogoJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUYhDd95; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUYhDd95"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13810b63a1aso5848753c88.1
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 01:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781081715; cv=none;
        d=google.com; s=arc-20240605;
        b=NADw712FIa7g3t2HPQqDBt0M6EJ5xC3/4bwbVNm7Z4DlirJOFfsN1zqPvwoqKl9KuJ
         N6cLRTdPX7atjw2ZyjsXdK+XwmQzS2EerCCK/VExuWSs3zHaFO51tmBuds6P7WIRCXnb
         hizgr3T07nU/0Mih8z6JMKWSfsOtMQaZDf5dNwWkZF4D/3EFn0Pqj3MVq16ER5XnDHZM
         k70km9MG0SYRBdcTIF7P/rLLyMJ5vRa+15A0IXsEVUmCfAC7Ns28JYvi1D7Z3HIKBiJH
         d/CaGbfIKIaSGAZxBBpLpijLKrBN3i9r6JZwDUXQNVrI5rbYUnq6PO09kHjleN+70fjn
         BBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iNh55YhEuFgkEeB/ThY5qbdXdZbx+uMa748Jhl66MKs=;
        fh=nOZP/56X5VEIQXdN79gJbmgBnclcO83Cg/xfVDEdH+g=;
        b=BsAPkXj7cKxjxF71SoOx1x2h7CBH+bW3Bg5ylb9089+3/p/NSUVQFD2t07ts/NPYcG
         PjB8neSQ97zQ9/EA6YY5VfmoMDxoPINBYHP0KPO2hjZKEdG0D1q9h3wMFrMoeupp8FOY
         b3qH1VP2YfKBB+NKJylaaEV6aAowWaFPcnixuG+yGiMYQEf4Fc8TWT69zPGK66pvE0BE
         jdy/F9nv9SnwQP+CrmpAYMI0SwYyFcqPhzw4mrsTQ2lrMBmKxQg6w/Q2n4FEBNIUSexd
         GA3dhrhycnHHgJojadnhdoNStpiVwR7W6vCYbNWr7RtL7nmYgtoM9tVoExaSv73ZJGea
         O9Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781081715; x=1781686515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNh55YhEuFgkEeB/ThY5qbdXdZbx+uMa748Jhl66MKs=;
        b=WUYhDd95KV8fd80A5mxLoI5c82QmWIR4guBTmUFgsZ1PLnHhlX84xqwWSZ9cMZ9ioU
         jX+rzdzcyHzaltyLOK6sL+cytSFNNmBmTBHGaWF/WXUbeXlOB9gke8Xx48v4c68+STRc
         cOAZo6fcj5MFPBihFxdii4hzls820ECXvL9m1neTijrAYV3BjoZNIztIlfmB7AZFmFML
         mP+CUvlfvPkH2GLtB1ECj6AFQps2S3aZ04oaTgi+veGt8YnO8yErez7gGOzr9PpTnelo
         IvhvBanPCepttJInxZheBy3ctXOs5SgNoqT/IQ0Zgct7pExmSYzyG4n+1fJfWoOJkoNg
         OLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081715; x=1781686515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iNh55YhEuFgkEeB/ThY5qbdXdZbx+uMa748Jhl66MKs=;
        b=nyF+UhNW5CDFk9DLH/51uZfcRM9LHSWexnNp3QZUkba2GpgChDXY0kz2dKZyiV3eSY
         QdYW47K7VcEv2cte0VbfAM0VzZ8OSrZ3k2v0DsHeUg5Cn93wdO4q8B0+FoeC+4qu3Gcj
         4wkeMuABj424TLZo7RS04m4rkO/6wLQp9x68Edbj9PF0Hr5NW9R80c5k3zaHs0SYgfN1
         Uk/Jp4OVoqGJ40mnDapP6FU/fvUKvJaN1tQxtMKSc31YhZMNX0d2GqkEyVhmgAA68vvV
         ELrtJ7r3Od9Ek/l2zawh24RYjri0vInJ7RvNfhzcBapcP8jUh9cYlj0NiR3NqGpOk9Ci
         9fXg==
X-Forwarded-Encrypted: i=1; AFNElJ8cfazXEbr9gHic+90g5kHKzwhwdX3DcVr0FpbhBRhC39iMXbaKGql8+t+ZKuOshO18DTmO4xbuvy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyEeJ9hgdiJ6StEs2VH5c+rPeBd0JmPZfEzdRsVkAvi1dO2Yh
	1dF4b8ZaCKLoVxbh1+X9HuuWsAmLfzHvhZN0ZkY4SK1+/Jpzi4ZwbAmmdAHxPMY7cRMQ1+rKu8A
	UrT88zdaoztB6PxQSCTFKzjIei9j26o8=
X-Gm-Gg: Acq92OGMR5vlDoTui2BY4KvAIoMXD4Dpg/FSdwRkpNG8kbbaYlJEDvP3YhnrOoD6FQm
	nBPqS+eVubHpMpNlzqkaloo6M+qBjzRA62lnXhhkfKwCloO54AFGmC8w511d9lG2na1jsiaPG1Y
	bMGD0lTfXuH9WRTO7/HowPWs6VjPFZ1hrzaapjL+fYRFe2+wlC42g8ziiptA6jWhaW0LkdUXMnl
	LMJRUVuzhP3CGinEFldOFDF+ho/cBsXaBe05Lbdo2A95WONQWb5DnMFDO4e3oWC69nmzknWghwq
	3oJUXRzLBNJjQuT+q0A=
X-Received: by 2002:a05:7022:672a:b0:136:9ebf:3c04 with SMTP id
 a92af1059eb24-13831ba95ddmr4043869c88.25.1781081715309; Wed, 10 Jun 2026
 01:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
 <20260205102942.28745-2-tinsaetadesse2015@gmail.com> <aiaw_mwxbuCqzCtY@zenone.zhora.eu>
In-Reply-To: <aiaw_mwxbuCqzCtY@zenone.zhora.eu>
From: TINSAE TADESSE <tinsaetadesse2015@gmail.com>
Date: Wed, 10 Jun 2026 11:54:38 +0300
X-Gm-Features: AVVi8CdVO_8xMFsBP4UBhrNCPNcIoEaDNmEQyaVjnbHkcXIuGp-tVckvXwNk_4U
Message-ID: <CAJ12PfPTzHbhaXH3sAnMoE9X8a4rHrpzv2jfdnqqJWXvx+OnGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] i2c: i801: Detect SPD Write Disable and expose as
 adapter quirk
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 3:28=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> w=
rote:
>
> Hi Tinsae,
>
> sorry for the very late reply.
>
> > +/* SPD writes are blocked by host controller */
> > +#define I2C_AQ_SPD_WRITE_DISABLED    BIT(8)
> > +
>
> We don't need this extra flag, we already do this statement in
> i2c_register_spd().
>
> Can't we just assume that for spd5118 spd write is always
> disabled? That's what happens in i2c_register_spd.
>
> Check:
>
> 84d477354b0a ("i2c: smbus: Support DDR5 and LPDDR5 SPD EEPROMs")
> 4d6d35d3417d ("i2c: smbus: introduce Write Disable-aware SPD instantiatin=
g functions")
>
> Thanks,
> Andi


Hi Andi,

Thanks for reviewing this patch series.

> We don't need this extra flag, we already do this statement in
> i2c_register_spd().

Based on my testing, the issue does not appear to be in the SPD
registration path
handled by 'i2c_register_spd()'.

I verified that:

* The i801 driver correctly detects SPD Write Disable.
* Disabling 'CONFIG_SENSORS_SPD5118_DETECT' completely eliminates the probl=
em.
* The suspend/resume failures only occur when 'CONFIG_SENSORS_SPD5118_DETEC=
T=3Dy'.

Based on these observations, it appears that the SPD5118 detect path
may instantiate
the device independently of the SPD registration logic and therefore
may bypass the
SPD Write Disable handling added by commit 4d6d35d3417d ("i2c: smbus:
introduce Write
Disable-aware SPD instantiating functions").

This would explain why SPD5118 is still instantiated on systems where SPD W=
rite
Disable is active, even though the SPD registration helpers are
already SPD WD aware.

The above observations are what motivated this patch series. Am I correct i=
n
suspecting that the SPD5118 detect path is separate from the SPD
registration path, or
is there another instantiation path that I should investigate?

Best,
Tinsae Tadesse

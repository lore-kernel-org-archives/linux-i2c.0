Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120B21019C
	for <linux-i2c@vger.kernel.org>; Sat,  7 Feb 2026 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770472191; cv=none; b=Cf//tDAFdBLSz/IS1DWH7ZKJYBVbF8QxFyKtPF0QqPuSmwPKW82q2wCymYLN0X/hLQ6f/IcRiq+wjB1vRsgmBtPPl6zIOhHxNkpz3ax25I6J2S7VP6Pmeq+cKTP/UdoCyrYZ6n/pNKs63W1aGFt29B3mk9+t/qozDF7bFYu/VHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770472191; c=relaxed/simple;
	bh=awClsDQAoaWle+97AQpre6aIGBed3gUQvbTapQ/ZDjA=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Subject:To:Cc:
	 References:In-Reply-To; b=nCmSSPnFIx1PTLfl7vIrrB1+4ge9MaEWE+sUNZIw5g+zbzL1RnRPwpOJf4Prhr+g7BeacTaCJcZ56+UbQoSXR2V9pyQP3X/2lZm3jIyjS1clfksfv1sZQukqQJXcInNDIH7BPApz18RhITlqJXeNBxVdZdu0b6ApCBoVXGidITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KW2GIH8i; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW2GIH8i"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b86d39cd50so182475eec.0
        for <linux-i2c@vger.kernel.org>; Sat, 07 Feb 2026 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770472190; x=1771076990; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:subject:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IzXDpLFwSkLNbwyD+8cYCZma/FvcMBgne+jWBUI0S0=;
        b=KW2GIH8iTG1UItWr43E8UVLv4Bbc3136ujKrFlJgTfjKSV7iMrFVzLYrzO5GNvVtNR
         Ua3uL8+eIga3vK1CV6/G5irOPHxoe/7Zt4meJPA8tjtGytS1FGnEl3TAMFSqGZ484Ma4
         MiPgx70jCHT13xBsrJDOlGfZScHc4Pt7QS1fWHrl6D9lP+yOcF306rub2DgJZZbPpx3w
         DcYqP9teSuVLBbq2PetwF3tcAp03yg852mx3ymNTDDfT4l/98FOezue41VBtaN/paKfA
         M+Tanx60vG+MptWD5D6TxYUSvdVpUhiooUkP8ZrWzXFJrnUhcoOwmdLHA+xsHoOBwdt3
         zE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770472190; x=1771076990;
        h=in-reply-to:references:cc:to:subject:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IzXDpLFwSkLNbwyD+8cYCZma/FvcMBgne+jWBUI0S0=;
        b=ANDyMsHyvY3AGeKQkWMClQOzD6GmEyFNLj3fUDwR1OMT6z3RSu13R08yiDH8SLCqCn
         djeClf9qWzk1E+4I6zVhnn0EglurKe3ZFWU/P9G8DyqEsL22a8PIP9n00Sw6/lrfhIFY
         gR4tefAtQnB5UijnqlA3Ob0rpKiQ8G5HOYd3DX3jB+NZHK5U08EL5xqdp9IC0a2aJJA9
         09xm07nkRQq5QAuKsZ0zG2jQYXmafLRWvE920oshONVGqvMFDT6nslq1zbKdqZbI7/JW
         CpoOWfRLbX4yyRcj7AyVkey2kTTdysw1dBABF+r3X5pYLGho8S4xtzE1bcMpk35OuwWJ
         aJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmJ6+DPMl1KGpJADgNbE+8IRKJ7pOEX3GevTk45tm95cxrGswurKvIZFTclKsqTjwXztpGTqn2XxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAS1HI6Zw28VYq8DYMzXQCkP7yvEKgmgBO9ZZBWEPW8zczvB9Y
	tTtb1wUrSBjWiCNQOPTYB7tXoFmCq+TlO/xGBoTVjPl1RN0i4P/0CR/B
X-Gm-Gg: AZuq6aK2Cg5STAoz+8hGgYKBHzWNpz/QXXjvf1sn/haZrS02/8iIXiB/aer+PCyhx10
	uAKx4Wqm5YH1/QxttUWsldw2meab7hN8lFrCRKKCexflmBFBZYF6fdn5M9ekhYShDs20eWdh+Tc
	lPH7fk05skyjjpTo8eoBFq7g2j+0oSZg+GrWV9ViIHipwyfgoUp0fBZYAi44yzMPFjXIrnHKdO+
	FJB0mS4F4SZG2hiXa1R6XOZrFEkSYHuEOOZEiRIDjijSBMPnJhE0t5jYU8tiSZ+TH92DnHG0W5j
	IiiqL3iOvETC0IKSD36W0Z8rK5GV1/ws6hUXQzNacPKPNZ4/dMoXBl2peMGhMZbLP6xuGAwuhZf
	9Wwc1TgyeLSnogvmsCjZCTRN9JjWb6M4MVoFf4AFlcjPtLOabEhMs5Txp9WZm4ExO+j7HTz16Jk
	/SHl/ad9fnBeLJJg==
X-Received: by 2002:a05:7301:3d19:b0:2b7:f809:9c38 with SMTP id 5a478bee46e88-2b85642b483mr3550098eec.18.1770472190215;
        Sat, 07 Feb 2026 05:49:50 -0800 (PST)
Received: from localhost ([72.11.140.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3db30sm3684099eec.21.2026.02.07.05.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 05:49:49 -0800 (PST)
From: Troy Mitchell <troymitchell988@gmail.com>
X-Google-Original-From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Feb 2026 21:49:47 +0800
Message-Id: <DG8S0EEA55Z6.3RVC23NWTEW1S@linux.spacemit.com>
Subject: Re: [PATCH v6 2/2] i2c: spacemit: introduce pio for k1
To: "Andi Shyti" <andi.shyti@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Cc: "Yixun Lan" <dlan@gentoo.org>, "Alex Elder" <elder@riscstar.com>,
 "Aurelien Jarno" <aurelien@aurel32.net>, "Michael Opdenacker"
 <michael.opdenacker@rootcommit.com>, "Troy Mitchell"
 <troymitchell988@gmail.com>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260108-k1-i2c-atomic-v6-0-41b132b70f68@linux.spacemit.com>
 <20260108-k1-i2c-atomic-v6-2-41b132b70f68@linux.spacemit.com>
 <aWeyT8gb8Z31S_V9@zenone.zhora.eu>
In-Reply-To: <aWeyT8gb8Z31S_V9@zenone.zhora.eu>

On Wed Jan 14, 2026 at 11:47 PM CST, Andi Shyti wrote:
> Hi Troy,
>
> ...
>
>> @@ -171,6 +176,16 @@ static int spacemit_i2c_handle_err(struct spacemit_=
i2c_dev *i2c)
>>  	return i2c->status & SPACEMIT_SR_ACKNAK ? -ENXIO : -EIO;
>>  }
>> =20
>> +static inline void spacemit_i2c_delay(struct spacemit_i2c_dev *i2c,
>> +				      unsigned int min_us,
>> +				      unsigned int max_us)
>> +{
>> +	if (i2c->use_pio)
>> +		udelay(max_us);
>
> We need some control on how much we want to sleep in atomic. This
> can have effects on the whole system.
>
>> +	else
>> +		usleep_range(min_us, max_us);
>
> If we assume that max_us =3D min_us * 2 we don't need to pass it as
> a parameter. Even better you can use fsleep here which does it
> for you.
Thanks. I'll use fsleep here and remove max_us.
>
...
>> +}
>
> ...
>
>> +
>> +	if (i2c->state !=3D SPACEMIT_STATE_IDLE) {
>> +		val |=3D SPACEMIT_CR_TB;
>> +		if (i2c->use_pio)
>> +			val |=3D SPACEMIT_CR_ALDIE;
>
> Why are we enabling ALDIE here?
Should be:
if (!i2c->use_pio)
>
>> +
>> +
>
> please drop one blank line here
>
>> +		if (spacemit_i2c_is_last_msg(i2c)) {
>> +			/* trigger next byte with stop */
>> +			val |=3D SPACEMIT_CR_STOP;
>> +
>> +			if (i2c->read)
>> +				val |=3D SPACEMIT_CR_ACKNAK;
>> +		}
>> +		writel(val, i2c->base + SPACEMIT_ICR);
>> +	}
>
> ...
>
>> @@ -431,41 +605,8 @@ static irqreturn_t spacemit_i2c_irq_handler(int irq=
, void *devid)
>> =20
>>  	spacemit_i2c_clear_int_status(i2c, status);
>> =20
>> -	if (i2c->status & SPACEMIT_SR_ERR)
>> -		goto err_out;
>> -
>> -	val =3D readl(i2c->base + SPACEMIT_ICR);
>> -	val &=3D ~(SPACEMIT_CR_TB | SPACEMIT_CR_ACKNAK | SPACEMIT_CR_STOP | SP=
ACEMIT_CR_START);
>> -
>> -	switch (i2c->state) {
>> -	case SPACEMIT_STATE_START:
>> -		spacemit_i2c_handle_start(i2c);
>> -		break;
>> -	case SPACEMIT_STATE_READ:
>> -		spacemit_i2c_handle_read(i2c);
>> -		break;
>> -	case SPACEMIT_STATE_WRITE:
>> -		spacemit_i2c_handle_write(i2c);
>> -		break;
>> -	default:
>> -		break;
>> -	}
>> -
>> -	if (i2c->state !=3D SPACEMIT_STATE_IDLE) {
>> -		val |=3D SPACEMIT_CR_TB | SPACEMIT_CR_ALDIE;
>> -
>> -		if (spacemit_i2c_is_last_msg(i2c)) {
>> -			/* trigger next byte with stop */
>> -			val |=3D SPACEMIT_CR_STOP;
>> -
>> -			if (i2c->read)
>> -				val |=3D SPACEMIT_CR_ACKNAK;
>> -		}
>> -		writel(val, i2c->base + SPACEMIT_ICR);
>> -	}
>> +	spacemit_i2c_handle_state(i2c);
>
> Next time this can be on a separate patch as a preparatory patch
> to make the review of this one a bit easier.
Thanks. I'll do that.

                              - Troy
>
>> =20
>> -err_out:
>> -	spacemit_i2c_err_check(i2c);
>>  	return IRQ_HANDLED;
>>  }
>
> Thanks,
> Andi


Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB752264CF
	for <linux-i2c@vger.kernel.org>; Sat,  7 Feb 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770472659; cv=none; b=SoB1cssEwyV1RPx6e5y4pxFQSdgoMUWxpphlIu7GeuZAbX7ObeWzDguFJns4vLDuq00/tFzj5GNClq3b844WrN9Ob5VJThoLaLRDm7gyS1Y3vuyjlWBha8hRw3LMHsI6AVe8N3pTlwUAOsRgKgF6QPV1p0Du26uIsM/D6/76hTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770472659; c=relaxed/simple;
	bh=+O5vCEglNwG3OLEbc0sSvqh7rNs0LvxSLOjULErzsPk=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Subject:To:Cc:
	 References:In-Reply-To; b=IsUNrWlf9x0H1x1NPO9etMD3dAvV36QZJBo/uRH1znlHzpDhkKeUW7cfcGUf0yYNMlePOkG0M79s8C+dqnh3rAedHNbQA4AJcphZ017USkfog9INp4d9+NUsREF8GG1kRoJUDjmeCRxgfv8QOb4h55UeuqQY9o3ibUcAaoHBUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GImlWMqs; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GImlWMqs"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b71557299dso1531999eec.1
        for <linux-i2c@vger.kernel.org>; Sat, 07 Feb 2026 05:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770472658; x=1771077458; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:subject:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhLaNZ2KK6aNK9ALYGKaKSL8yESm+SSWbTP8mbgDklc=;
        b=GImlWMqswUuG0E+eT7lzm6Gkjfk3lqw0v+zLprTjRRIWVtAlI6+UCgxv5+kGB6eo4M
         fJxyJXtdBVyhrGcaUlnk+3DgfN72zdU+3ICKZry3kIcyJSXteneB4p/PPu7653YozVXn
         6Y0mTtJrxr8Um9jgGFfJh/kLw+ZLvTXCjQPagnywt5xSQ1+WsbQbqDn3Y3WXlBIubuxL
         fnCBNW6rC07xnzgxyY+Qo99mBcTOqjNWFCPnw+kBSmPSZF/vCa2dG5AgubpVCKMtUhMb
         Dr0SatmWFrq+HAZYftilMwGlwYnoQeAytYK7zzsgu9ry1T0ebZSwzZ/bDEYkKgOLI1Qv
         U4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770472658; x=1771077458;
        h=in-reply-to:references:cc:to:subject:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhLaNZ2KK6aNK9ALYGKaKSL8yESm+SSWbTP8mbgDklc=;
        b=nTQRBawtZGCdXNzyFXA8//zHzVj6q5eJv5sKGdf0PMquoXboQkaReYIxkZEnFCHfr4
         FYzvnRfFDOPo0DNGFNbhY7rg7vD6h4kWIrNh6TqRFxT6Ek5HnD++006MIsHgABq6UD0Q
         73zH0HuP/1zfAgAK7cHr7u3G/FnDv4SEaT/UzCSwsqT7ZyGPGyZDcPOFXEqmMIVdIw2T
         6vQOhctYwskE2mhms1eQ7lgalF7kUrHHR+hM+XMkjG1i0IYJrTJxn09dN0qJjAFkIEXg
         TqGQu4lKkq5SxgcvR/Z2etCzA7jjS6kpxcOPuCoCvmtZ0flBeoSCAxVUEgDCid1hZ2HB
         14ig==
X-Gm-Message-State: AOJu0YxU7locDehlb+NQufVcqbl4o5BBiHU0jEfHH06GHkPMKDS928/P
	vjQ1sY/9+i7JuHn29Bli5txD89o9Bq5kgh2V+S7574RcI6TK/MPscOuF
X-Gm-Gg: AZuq6aKwSwDliU5T4Ol+pGBO5tojVP4CfKxIxsul9XtZ+LrsKjbXu6uLvsGrznUp9Or
	E+kYaA4DmdqU1HW+peCRX0GynDPtV9CeExh4fyksiW75szfYCfXav83kGUsGYt39cV6n2J/5AO/
	GfoaNPZ+RaFr+uFrO+iD7gnFfdm+kffnKJsyIOAumCu7pNmBHHR3bGsRaHQFyDltWQZTyU7/LDN
	KneQIYbYo98bNY8hxoyx+3y0JMtSGJprBjppaGPf1VJpFL2LZJtCgNRysyjqNphmMN/BIzSVSSF
	Hx5rkgPuOeTZVEJbZ7o/D5LbTV0OfLj7f9aH4itCRdkWgUZ0Jxviiw6JNJkuitHTwBOxgkeO0Yi
	vV2LQZw0ZLTgCi0GMlyndFhMrVRy8L8S58+n60ncssOlJA/GqceQsd3d5UYDyGIErfGCewROtmy
	VVxqPyoKpNeM0ebg==
X-Received: by 2002:a05:7301:3f16:b0:2b7:ff39:30eb with SMTP id 5a478bee46e88-2b8560de163mr2076540eec.0.1770472658293;
        Sat, 07 Feb 2026 05:57:38 -0800 (PST)
Received: from localhost ([72.11.140.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855ad9a42sm4663573eec.1.2026.02.07.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 05:57:38 -0800 (PST)
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
Date: Sat, 07 Feb 2026 21:57:34 +0800
Message-Id: <DG8S6DCW5EWZ.1F1IARVF5M6DZ@linux.spacemit.com>
Subject: Re: [PATCH v6 2/2] i2c: spacemit: introduce pio for k1
To: "Alex Elder" <elder@riscstar.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Yixun Lan" <dlan@gentoo.org>, "Aurelien Jarno" <aurelien@aurel32.net>,
 "Michael Opdenacker" <michael.opdenacker@rootcommit.com>, "Troy Mitchell"
 <troymitchell988@gmail.com>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260108-k1-i2c-atomic-v6-0-41b132b70f68@linux.spacemit.com>
 <20260108-k1-i2c-atomic-v6-2-41b132b70f68@linux.spacemit.com>
 <5ddb55a9-ddad-4e4b-90ab-2214f958ea90@riscstar.com>
In-Reply-To: <5ddb55a9-ddad-4e4b-90ab-2214f958ea90@riscstar.com>

On Fri Jan 16, 2026 at 1:02 AM CST, Alex Elder wrote:
> On 1/8/26 1:52 AM, Troy Mitchell wrote:
>> This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
>> enabling the use of I2C in atomic context.
>>=20
>> When i2c xfer_atomic is invoked, use_pio is set accordingly.
>>=20
>> Since an atomic context is required, all interrupts are disabled when
>> operating in PIO mode. Even with interrupts disabled, the bits in the
>> ISR (Interrupt Status Register) will still be set, so error handling can
>> be performed by polling the relevant status bits in the ISR.
>>=20
>> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
> I have a few minor comments, but I think this is close to done.
>
>> ---
>> Changes in v6:
>> - modify code style
>> - modify and add comments
>> - Link to v5: https://lore.kernel.org/all/20251226-k1-i2c-atomic-v5-2-02=
3c798c5523@linux.spacemit.com/
>> ---
>> Changes in v5:
>> - optimize code logic
>> - refactor delay handling into spacemit_i2c_delay() helper
>> - introduce spacemit_i2c_complete() to centralize transfer completion
>> - rework PIO transfer wait logic for clarity and correctness
>> - modify and add some comments
>> - modify commit message
>> - Link to v4: https://lore.kernel.org/all/20251009-k1-i2c-atomic-v4-1-a8=
9367870286@linux.spacemit.com/
>>=20
>> Changes in v4:
>> - refactor for better readability: simplify condition check and moving i=
f/else (timeout/
>>    wait_xfer_complete) logic into a function
>> - remove irrelevant changes
>> - remove the status clear call in spacemit_i2c_xfer_common()
>> - sort functions to avoid forward declarations,
>>    move unavoidable ones above function definitions
>> - use udelay() in atomic context to avoid sleeping
>> - wait for MSD on the last byte in wait_pio_xfer()
>> - Link to v3: https://lore.kernel.org/r/20250929-k1-i2c-atomic-v3-1-f7e6=
60c138b6@linux.spacemit.com
>>=20
>> Changes in v3:
>> - drop 1-5 patches (have been merged)
>> - modify commit message
>> - use readl_poll_timeout_atomic() in wait_pio_xfer()
>> - use msecs_to_jiffies() when get PIO mode timeout value
>> - factor out transfer state handling into spacemit_i2c_handle_state().
>> - do not disable/enable the controller IRQ around PIO transfers.
>> - consolidate spacemit_i2c_init() interrupt setup
>> - rename is_pio -> use_pio
>> - rename spacemit_i2c_xfer() -> spacemit_i2c_xfer_common()
>> - rename spacemit_i2c_int_xfer() -> spacemit_i2c_xfer()
>> - rename spacemit_i2c_pio_xfer() -> spacemit_i2c_pio_xfer_atomic()
>> - call spacemit_i2c_err_check() in wait_pio_xfer() when write last byte
>> - Link to v2: https://lore.kernel.org/r/20250925-k1-i2c-atomic-v2-0-46dc=
13311cda@linux.spacemit.com
>>=20
>> Changes in v2:
>> - add is_pio judgement in irq_handler()
>> - use a fixed timeout value when PIO
>> - use readl_poll_timeout() in  spacemit_i2c_wait_bus_idle() when PIO
>> - Link to v1: https://lore.kernel.org/r/20250827-k1-i2c-atomic-v1-0-e59b=
ea02d680@linux.spacemit.com
>> ---
>>   drivers/i2c/busses/i2c-k1.c | 304 +++++++++++++++++++++++++++++++++---=
--------
>>   1 file changed, 232 insertions(+), 72 deletions(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
>> index accef6653b56bd3505770328af17e441fad613a7..427cd8dc6947c1d5fbdd364a=
351f7c065ba0b595 100644
>> --- a/drivers/i2c/busses/i2c-k1.c
>> +++ b/drivers/i2c/busses/i2c-k1.c
>> @@ -97,6 +97,10 @@
>>  =20
>>   #define SPACEMIT_BUS_RESET_CLK_CNT_MAX		9
>>  =20
>> +#define SPACEMIT_WAIT_TIMEOUT      1000 /* ms */
>> +#define SPACEMIT_POLL_TIMEOUT      1000 /* us */
>> +#define SPACEMIT_POLL_INTERVAL	   30	/* us */
>> +
>>   enum spacemit_i2c_state {
>>   	SPACEMIT_STATE_IDLE,
>>   	SPACEMIT_STATE_START,
>> @@ -125,6 +129,7 @@ struct spacemit_i2c_dev {
>>  =20
>>   	enum spacemit_i2c_state state;
>>   	bool read;
>> +	bool use_pio;
>>   	struct completion complete;
>>   	u32 status;
>>   };
>> @@ -171,6 +176,16 @@ static int spacemit_i2c_handle_err(struct spacemit_=
i2c_dev *i2c)
>>   	return i2c->status & SPACEMIT_SR_ACKNAK ? -ENXIO : -EIO;
>>   }
>>  =20
>> +static inline void spacemit_i2c_delay(struct spacemit_i2c_dev *i2c,
>> +				      unsigned int min_us,
>> +				      unsigned int max_us)
>> +{
>> +	if (i2c->use_pio)
>> +		udelay(max_us);
>> +	else
>> +		usleep_range(min_us, max_us);
>> +}
>> +
>>   static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_d=
ev *i2c)
>>   {
>>   	u32 status;
>> @@ -182,7 +197,8 @@ static void spacemit_i2c_conditionally_reset_bus(str=
uct spacemit_i2c_dev *i2c)
>>   		return;
>>  =20
>>   	spacemit_i2c_reset(i2c);
>> -	usleep_range(10, 20);
>> +
>> +	spacemit_i2c_delay(i2c, 10, 20);
>
> Is this delay specified for the hardware somewhere?  I.e.
> "one must wait at least 10 microseconds after a reset"?
>
> If so, the delay be moved into spacemit_i2c_reset().
This is the sole call site requiring a delay; we must ensure a
sufficient grace period before polling for bus release

>
>>  =20
>>   	for (clk_cnt =3D 0; clk_cnt < SPACEMIT_BUS_RESET_CLK_CNT_MAX; clk_cnt=
++) {
>>   		status =3D readl(i2c->base + SPACEMIT_IBMR);
>> @@ -211,9 +227,15 @@ static int spacemit_i2c_wait_bus_idle(struct spacem=
it_i2c_dev *i2c)
>>   	if (!(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)))
>>   		return 0;
>>  =20
>> -	ret =3D readl_poll_timeout(i2c->base + SPACEMIT_ISR,
>> -				 val, !(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)),
>> -				 1500, SPACEMIT_I2C_BUS_BUSY_TIMEOUT);
>> +	if (i2c->use_pio)
>> +		ret =3D readl_poll_timeout_atomic(i2c->base + SPACEMIT_ISR,
>> +						val, !(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)),
>> +						1500, SPACEMIT_I2C_BUS_BUSY_TIMEOUT);
>> +	else
>> +		ret =3D readl_poll_timeout(i2c->base + SPACEMIT_ISR,
>> +					 val, !(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)),
>> +					 1500, SPACEMIT_I2C_BUS_BUSY_TIMEOUT);
>> +
>>   	if (ret)
>>   		spacemit_i2c_reset(i2c);
>>  =20
>
> . . .
>
>> +static void spacemit_i2c_handle_state(struct spacemit_i2c_dev *i2c)
>> +{
>> +	u32 val;
>> +
>> +	if (i2c->status & SPACEMIT_SR_ERR)
>> +		goto err_out;
>> +
>> +	val =3D readl(i2c->base + SPACEMIT_ICR);
>
> The assignment on the next line doesn't even matter and isn't
> used unless the state isn't idle.  You could move it inside
> the block below.  In fact, you don't even need to read the
> ICR value (above) until you have verified the state isn't idle.
Yes, you are correct.  The assignment is only used when the state
is not idle. And the register ICR will be cleared when the state is
idle (in err_check).

>
>> +	val &=3D ~(SPACEMIT_CR_TB | SPACEMIT_CR_ACKNAK | SPACEMIT_CR_STOP | SP=
ACEMIT_CR_START);
>> +
>> +	switch (i2c->state) {
>> +	case SPACEMIT_STATE_START:
>> +		spacemit_i2c_handle_start(i2c);
>> +		break;
>> +	case SPACEMIT_STATE_READ:
>> +		spacemit_i2c_handle_read(i2c);
>> +		break;
>> +	case SPACEMIT_STATE_WRITE:
>> +		spacemit_i2c_handle_write(i2c);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (i2c->state !=3D SPACEMIT_STATE_IDLE) {
>> +		val |=3D SPACEMIT_CR_TB;
>> +		if (i2c->use_pio)
>> +			val |=3D SPACEMIT_CR_ALDIE;
>> +
>> +
>> +		if (spacemit_i2c_is_last_msg(i2c)) {
>> +			/* trigger next byte with stop */
>> +			val |=3D SPACEMIT_CR_STOP;
>> +
>> +			if (i2c->read)
>> +				val |=3D SPACEMIT_CR_ACKNAK;
>> +		}
>> +		writel(val, i2c->base + SPACEMIT_ICR);
>> +	}
>> +
>> +err_out:
>> +	spacemit_i2c_err_check(i2c);
>> +}
>> +
>> +/*
>> + * In PIO mode, this function is used as a replacement for
>> + * wait_for_completion_timeout(), whose return value indicates
>> + * the remaining time.
>> + *
>> + * We do not have a meaningful remaining-time value here, so
>> + * return a non-zero value on success to indicate "not timed out".
>> + * Returning 1 ensures callers treating the return value as
>> + * time_left will not incorrectly report a timeout.
>> + */
>> +static int spacemit_i2c_wait_pio_xfer(struct spacemit_i2c_dev *i2c)
>> +{
>> +	u32 mask, msec =3D jiffies_to_msecs(i2c->adapt.timeout);
>> +	ktime_t timeout =3D ktime_add_ms(ktime_get(), msec);
>> +	int ret;
>> +
>> +	mask =3D SPACEMIT_SR_IRF | SPACEMIT_SR_ITE;
>> +
>> +	do {
>> +		i2c->status =3D readl(i2c->base + SPACEMIT_ISR);
>> +
>> +		spacemit_i2c_clear_int_status(i2c, i2c->status);
>> +
>> +		if (!(i2c->status & mask)) {
>> +			udelay(SPACEMIT_POLL_INTERVAL);
>> +			continue;
>> +		}
>> +
>> +		spacemit_i2c_handle_state(i2c);
>
> This could be:
>
> 		if (i2c->status & mask)
> 			spacemit_i2c_handle_state(i2c);
> 		else
> 			udelay(SPACEMIT_POLL_INTERVAL);
I'll. Thanks.

                        - Troy
> 	} while...
>
>
> 					-Alex
>
>> +	} while (i2c->unprocessed && ktime_compare(ktime_get(), timeout) < 0);
>> +
>> +	if (i2c->unprocessed)
>> +		return 0;
>> +
>> +	if (i2c->read)
>> +		return 1;
>
> . . .


Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDF7261C;
	Fri,  8 May 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222302; cv=none; b=oLJkyWBulXnv53eolEBRKfeKEzzwHunp3IONo5uEa9VgOpoEadxmUT+caaC1fhMVzGuPCqL6GFQiBCBaR3ZKZGptWlPW+8E7g4nhBpFO6WZZJNoM2zBjcn+Nubk2DLjpLQDI0Fp9h1VUM8VHHCychKZR/2Wkw8qxDW12HzeFMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222302; c=relaxed/simple;
	bh=jUNTNksXf1a4WzCOPfsBigv1Fqr11+Wd0EF0+pdo7Ig=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FCSrgrrpHvtBZJMrmVJHoI4cWN38HpYPDyNJtCOQ3b72vfjGtMXR21gabNtBE+kh/07aX2aoSJXR7T3EMb3XgpHspzfFl77OimdZSNFvoMC/RF1PNsStZxTTjvllJ/8OjIHnIfpJll/capXXCYSqMtCKd+pndV8cBHaZrpDrIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=UTcaQbXQ; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="UTcaQbXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1778222245;
	bh=8JEEYGi3KIhC5hASnjM+XwuYNJ31pZv1KHpSN+PB1g0=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=UTcaQbXQPU4WAgAPqUC5ZvcTLQSZGCn37LAcRNBSY5aeFYnJhijrH/I+9Lkf+86O3
	 xMcN3i2Zl8h4N86Tb/FMWyV14W3v0wY25UjcFoUvCG69kp+O210vQndo/myozYe1yb
	 jIrVRjIvCvs/VMUpAF0UGnea345woL491br1EhI4=
X-QQ-mid: esmtpsz10t1778222238t9023b831
X-QQ-Originating-IP: /HYZdUY2KNZVeYoHWNpv7D+eFSQ2gIKlhmT7/A5s2ik=
Received: from = ( [27.42.96.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 May 2026 14:37:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11761350832640437751
EX-QQ-RecipientCnt: 8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 14:37:14 +0800
Message-Id: <DID36992GF2G.229YAG9BSQ3VZ@linux.spacemit.com>
Subject: Re: [PATCH v6 1/2] i2c: spacemit: configure ILCR/IWCR for accurate
 SCL frequency
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Alex Elder" <elder@riscstar.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Yixun Lan" <dlan@kernel.org>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260429-k1-i2c-ilcr-v6-0-1c7a5a5a8b24@linux.spacemit.com>
 <20260429-k1-i2c-ilcr-v6-1-1c7a5a5a8b24@linux.spacemit.com>
 <01278362-ae7c-424a-838b-4add1718e7f6@riscstar.com>
In-Reply-To: <01278362-ae7c-424a-838b-4add1718e7f6@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MMKL56urm3zQV7YJ/4+hEDQDhDqRuSm0rVJAUOxlSg9Qa65SepnVx6/0
	OsyBJRlydIF2swX9SWpWR4R0iLrURbJPw/HC5gXE+nN2igVmvkjKFB05rSHKhJ3MPKTLvFu
	umlULDEs2yJBuFh47XmsJWFzz5fLL9kBbj/5VBUzQ8VVDmktS10AFAf/uxtgBwLWcRYurNv
	oKdTy9CU4x9hT4z3aeznijyPw3CSCiFilg7AK3Pek7ObwnKDgsOHDtf2LpfgOEKrILYJjAL
	yFoFR9kqXmWhwYyK4XlbEsM2CwMbBeLN047bpngQO20+YlfMUgOhEHS7TsAKpJ8QW4Nvaj5
	6OUdJkFu86/dEy4fuTqkIeJh1eXq0WL7BsfjtnRDEwiRTyIxNnXX87CEsMovtHefNrKVX+g
	pUy5a+2V9GAD+OdTHDDqc4Pez7j/PHa0uhlCRx0ZVSIZjwQBtcpwsvMFh2GSmk1AE32LIv3
	ZcxM74JYIGcuxYlxcFU20ndg6MR9XA+6G8nMUthYUPod7fVmU553RCFRCerwxZiaJYuCic0
	P2NLo7xOi+ceneI5wiqL2f6DpbtDYMWi0GW2RTn0GWuuIzl3XpCLnw+WhqKa7qtNNZ+w1F/
	67NV6odHMvV4RegWa8nvOSSFa5wBtuvi2K9vOmCdmJ8bRobO2ibZVpgt2g0EkAVRBLC4QHp
	97H6OlRBgEKRg0FyIzjaTn/uuUVcMGfq1+lClg94VB/EZiYMAiXBSZOf3dyCNeIc3w3UpFs
	k0qBtMSJgGSYiEhrv7/UgIcBkm3bCLcFOz4dqnOuGWRW0XjXMGRNBChbyfY8J1g0bjR9xtC
	2/ENNiiXdMRHJ3FGfTyhdulSqTK1XmKPD+2oxICNVocNaf+qMDGIHdDICTEp4E5AUcYg/9G
	nAtdiJLWzJexCSkxg1fPO4hy/FUlW+k4DM0tYw4Y3kYIRlmDHdP7pRc3ukzwGrsB7pIrcdc
	o7a5nbe8w6DOzJ3sjf3Ywyvnk5FsORSUIgw63NSJCnOmLTN1KhFC2h0ckEQTytST1gdY0zZ
	SKq80qOU6FpK6Ej/aJbKuZ1KcPvoz816f1TvszZtIyBY6CTDe1hpFnbqvdQ4apXxXZNKsP2
	w==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Wed Apr 29, 2026 at 8:40 PM CST, Alex Elder wrote:
> On 4/29/26 2:48 AM, Troy Mitchell wrote:

[...]

>>   #define SPACEMIT_ISR		 0x4		/* Status register */
>>   #define SPACEMIT_IDBR		 0xc		/* Data buffer register */
>>   #define SPACEMIT_IRCR		 0x18		/* Reset cycle counter */
>> +#define SPACEMIT_ILCR		 0x10		/* Load Count Register */
>> +#define SPACEMIT_IWCR		 0x14		/* Wait Count Register */
>>   #define SPACEMIT_IBMR		 0x1c		/* Bus monitor register */
>>  =20
>>   /* SPACEMIT_ICR register fields */
>> @@ -88,6 +92,12 @@
>>   #define SPACEMIT_BMR_SDA         BIT(0)		/* SDA line level */
>>   #define SPACEMIT_BMR_SCL         BIT(1)		/* SCL line level */
>>  =20
>> +#define SPACEMIT_LCR_LV_STANDARD_MASK		GENMASK(8, 0)
>> +#define SPACEMIT_LCR_LV_FAST_MASK		GENMASK(17, 9)
>> +
>> +/* Required by I2C IP for correct SCL timing */
>> +#define SPACEMIT_IWCR_INIT_VALUE		0x142A
>
> Even if it's just used to "do the right thing", I still think it's
> useful to break this numeric value into what it *represents*.  The
> register is defined this way:
> COUNT		GENMASK(4:0)
> HS_COUNT1	GENMASK(9:5)
> HS_COUNT2	GENMASK(14:10)
> (the rest is reserved)
>
> So 0x142a represents:
> COUNT		10	33 MHz I2C functional clock (versus 66 MHz)
> HS_COUNT1	2	Count defining start bit setup/hold times
> HS_COUNT2	3	Count defining stop bit setup/hold times
>
> The first one in particular *could* be managed in your clock
> to support even more accurate clock rates.  But even if you
> don't change its value I think it's meaningful to know what
> the value represents.
>
> That said--what I suggest won't change what the code does,
> it just helps the reader understand what it's doing.
Thanks for the suggestion.
I've broken SPACEMIT_IWCR_INIT_VALUE into its constituent fields
using FIELD_PREP. One small correction: 0x142A actually decodes
to COUNT=3D10, HS_COUNT1=3D1, HS_COUNT2=3D5 (not 2 and 3).
>
>> +
>>   /* i2c bus recover timeout: us */
>>   #define SPACEMIT_I2C_BUS_BUSY_TIMEOUT		100000
>>  =20
>>
[...]

>> +
>> +static int spacemit_i2c_clk_determine_rate(struct clk_hw *hw,
>> +					   struct clk_rate_request *req)
>> +{
>> +	struct spacemit_i2c_dev *i2c =3D container_of(hw, struct spacemit_i2c_=
dev, scl_clk_hw);
>> +	u32 lv, denom;
>
> Can you have clk_set_rate() call clk_determine_rate(), or at
> least have them both share a helper that does these (duplicated)
> calculations?
Done. Extracted spacemit_i2c_calc_lv() as a shared helper used
by both set_rate and determine_rate.

>
>> +
>> +	denom =3D DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
>> +
>> +	if (i2c->mode =3D=3D SPACEMIT_MODE_STANDARD) {
>> +		lv =3D (denom <=3D 8) ? 0 : DIV_ROUND_CLOSEST(denom - 8, 2);
>> +		req->rate =3D DIV_ROUND_CLOSEST(req->best_parent_rate, lv * 2 + 8);
>> +	} else {
>> +		lv =3D (denom <=3D 10) ? 0 : DIV_ROUND_CLOSEST(denom - 10, 2);
>> +		req->rate =3D DIV_ROUND_CLOSEST(req->best_parent_rate, lv * 2 + 10);
>> +	}
>> +
>> +	return 0;
>> +}
>> +

[...]

>>  =20
>> +static struct clk *spacemit_i2c_register_scl_clk(struct spacemit_i2c_de=
v *i2c)
>> +{
>> +	struct clk_init_data init =3D {};
>> +	char name[64];
>> +	int ret;
>> +
>> +	ret =3D snprintf(name, sizeof(name), "%s_scl_clk", dev_name(i2c->dev))=
;
>> +	if (ret >=3D ARRAY_SIZE(name))
>> +		dev_warn(i2c->dev, "scl clock name truncated");
>> +
>> +	init.name =3D name;
>> +	init.ops =3D &spacemit_i2c_clk_ops;
>> +	init.parent_data =3D (struct clk_parent_data[]) {
>> +		{ .fw_name =3D "func" },
>> +	};
>> +	init.num_parents =3D 1;
>> +
>> +	i2c->scl_clk_hw.init =3D &init;
>> +
>> +	return devm_clk_register(i2c->dev, &i2c->scl_clk_hw);
>
> The comments above clk_register() indicate that this is a deprecated
> interface, and you should use a form of clk_hw_register() instead.
> devm_clk_hw_register() exists and takes the same arguments, but
> returns an int rather than the clock pointer.  But I think then you
> can call devm_clk_get_enabled() in the caller (spacemit_i2c_probe()).
> That would allow you to get rid of your clk_disable_unprepare()
> wrapper too.
I've switched to devm_clk_hw_register() as suggested. However,
devm_clk_get_enabled() isn't applicable here because the SCL clock is
registered internally by the driver rather than being described in the
Device Tree. Since devm_clk_get_enabled() relies on clk_get(),
it would fail to find the clock without a DT entry or a clkdev lookup.

Instead, I'm using devm_clk_hw_get_clk() to retrieve the struct clk
directly from the clk_hw, followed by a manual clk_prepare_enable()
with a devm action for automated cleanup.

                            - Troy

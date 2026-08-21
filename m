Received: from omta-ad1-fd1-2101-ap-sydney-1.aib29aea255.vm.email.ap-sydney-1.oci.oraclecloud.com (aib29aea255.vm.email.ap-sydney-1.oci.oraclecloud.com [192.29.151.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7030568B
	for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.151.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282854; cv=none; b=Gs0hduebdtFICiWTZANZzFcdUQqwylQJWXwahjZfaEEsPf0dQNO7KLyVFKf8/C/OIMVAy/dJVZgiWtvs8/qekAEjoW8lIRjulLDPIOXW6PO5Vo7X09vPf747YJGlx00GF+fN0Gu/U1+6/gpjdKN/+/HCQC8FjJPBeBsW6//INqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282854; c=relaxed/simple;
	bh=h7Ve+n7gLalVN/hamq+9sOt/wIp9NFoxX09l0/unmsU=;
	h=Message-id:Date:MIME-version:Subject:To:Cc:References:From:
	 In-reply-to:Content-type; b=rSzi02hZdrBYOHaN3XTN6t4S+03TIZpaHpCM0BshfCoVxbuZFUhQ4PC1joCDkIuRYJlYBoEnMg2vFBt0mwe3t0b7hDgOcRfIMf9ooQafssTIASkWidRfxizzCphMYxmAQ3PYHItJkR6zosGZmORPyO5AcCmYH0b/RCNzoPxI8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stevetech.au; spf=pass smtp.mailfrom=syd1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=stevetech.au header.i=@stevetech.au header.b=NX15t64h; dkim=pass (2048-bit key) header.d=syd1.rp.oracleemaildelivery.com header.i=@syd1.rp.oracleemaildelivery.com header.b=b8YYDUvp; arc=none smtp.client-ip=192.29.151.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stevetech.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syd1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stevetech.au header.i=@stevetech.au header.b="NX15t64h";
	dkim=pass (2048-bit key) header.d=syd1.rp.oracleemaildelivery.com header.i=@syd1.rp.oracleemaildelivery.com header.b="b8YYDUvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-2026;
 d=stevetech.au;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=L66ir+PivH58IHajuTfLolp/B5mG7kVirbvlAHl33II=;
 b=NX15t64h3W8/L1cArDAg91IkG45vczO9vYmvx5tel1i7SbnUmXikZGUeSv9dFS3pbO0mqWFca0zN
   /gc8ZebOn1APe0xi5efHNXjHsiq5yDUXiFsKPkVY+aXceBYhvPWlOl/CN0SjFJfdKzxGrbm85Ww7
   6uipoi5LK1Y7F1au2Ue6VeOD9Xv4b9ii3EQYuEyCUW68wxDaXV5/AgNut5JEn5fQv9bqNJp2dI7F
   edGcCOIVMnsShJMo+p64mdq91SHGtZUREg45QzEOQStctTrJacyApHXIl7ggnQR1E2IyYB87MVYV
   G89LW9VquosOeycdUtsAt8jvDVFt5tspFXAnqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-syd-20200122;
 d=syd1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=L66ir+PivH58IHajuTfLolp/B5mG7kVirbvlAHl33II=;
 b=b8YYDUvpE4j/d3XaxXSEgEyYwNWZNrT9zHGkvMIG1M2aNpDaWGap0kkBVL5nhn7KSSKWqFkmy61g
   Uy/VlmXomxEnrDG7fkV/0VggN2/1H4Cxj5pbz58omKrAdegLN94k+4fqoh3dGMgZBEB37Oxhvq0x
   zwibO6+3nYi3ufNUUD+LHrXsVAFTVSdRch4FP5LPdYeBmyrQPE+9eUWRyZiZe/R7TUZr/iqFW4bS
   eEJLcJ4TIJ4LxF4ER9gLntDGFjSjlynfUjCLn61ed1NsUJMRNA3qOJYyNZv5lFi/l3filgJI4nIQ
   ymQlULUAoZ9jJ0Rfrxom1Nbrskhnbo+mb2TUhw==
Received: by omta-ad1-fd1-2101-ap-sydney-1.mnat.vcndpsyd.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260722 64bit (built Jul 22
 2026))
 with ESMTPS id <0TK31OT2NO9T9F70@omta-ad1-fd1-2101-ap-sydney-1.mnat.vcndpsyd.oraclevcn.com> for
 linux-i2c@vger.kernel.org; Fri, 21 Aug 2026 03:27:29 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Message-id: <7fac8b19-af18-4365-94d6-a6bd18076abb@stevetech.au>
Date: Fri, 21 Aug 2026 13:27:28 +1000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] hwmon: Add Support for PMIC5000 Power Management ICs
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Horvath <s.horvath@outlook.com.au>
References: <20260819-pmic5000-v1-1-e5e0ddcf0863@stevetech.au>
 <6b8bf838-011f-46b9-a2a8-379de9cceddf@roeck-us.net>
From: Stephen Horvath <linux@stevetech.au>
Content-language: en-AU, en-US, en-GB
In-reply-to: <6b8bf838-011f-46b9-a2a8-379de9cceddf@roeck-us.net>
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 7bit
Reporting-Meta:
 AAE0CRPkDXUCCkglQobUipg4J5mxfCGMKIbvqKb9veEutptuF/BYXQOZL+n+BC+g
 9F/l1G9fNqweZphNlPpZqUMlvd2LjJ6v1MwED2HPwBoBhWmbbPc05EI3Hk1i+YwU
 aZB33T+T/76sCtZ73liDneTQU28WJWIjxJKHiQY9rQQJTjo2fjcxOG3KoTog9Or2
 kWyxlBWLa/CxsLhC5M9N3aIqynWWdQ0rMYpvOMX7JlEbSnn0VUC43p4NpDsmkTZu
 9y0JeoMvETyzlaVE8eiiiL/gLJHrhNHxRIsBMXK7zm2Pz62xmCUGxHdBTlTkhkCu
 xDvbXeSXsfYmiaiFPvt1k/da0qzusSxhmNbJw/FEIc+lEGcDBah9FteVLchy194X
 Q7coqtth0E9UDMYtnmOu6m0J6XWusJI1SEEM3kRE5epyrzebbE45y/nN2wW8

Hi Guenter,

Thanks for your review!

On 21/8/26 01:34, Guenter Roeck wrote:
>> - Does this belong in HWMON, or should it be part of the regulator
>> 	subsystem?
> 
> It depends on its functionality. Is this just for monitoring, or are the voltages
> controllable ?

This driver is just for monitoring. They could be controllable, but I
haven't implemented that as changing the voltage of active RAM modules
doesn't seem safe (without retraining and so on).

>> +in0_enable		Whether SWA is enabled (RO)
> 
> Does that enable the voltage or its monitoriong ? The enable attribute is
> only to enable monitoring, not to enable the voltage. If this is a
> controllable voltage, the driver should be a regulator driver, as Sashiko
> suggested.

It just queries whether that output is enabled. I'll remove it though as
the disabled channels are hidden by is_visible anyway.

>> +/* PMIC5000 registers. */
>> +// clang-format off
> 
> No way. Are you serious ?

clang-format would break the alignment of the #defines; and there's a
few other drivers with "// clang-format" in them, so I assumed it would
be okay (though none are hwmon). I'll remove it next revision.

>> +
>> +
> 
> Please run checkpatch --strict on your patches and fix what it reports.

Will do!

>> +struct pmic5000_data {
>> +	struct regmap *regmap;
>> +	struct mutex mode_lock;
>> +	struct mutex adc_lock;
> 
> Explain why those are needed on top of the hwmon subsystem lock.

I didn't know the subsystem lock existed, I'll remove them.

>> +	if (channel != 0)
>> +		return -EOPNOTSUPP;
> 
> Unnecessary check.

Sure.

> 
> Unnecessary channel checks (at least if the is_visible function does its job
> and the info data is correct).
> 

Okay.

>> +	case 6: {
> 
> Why "{" ?

No reason, I'll remove it. I had previously declared something there.

>> +	if (channel >= 0 && channel <= 3) {
> 
> channel is always >= 0.
I wasn't too sure, thanks for that!

>> +	/*
>> +	 * The host shall wait minimum of 9 ms delay after the input selection
>> +	 * for ADC readout and the actual readout
>> +	 *
>> +	 * msleep may sleep for up to 20ms, which is fine.
> 
> No, it isn't fine.

Fair enough, I'll change it to fsleep.

> Also, why wait if the channel was not changed ?

Good point.

>> +	*val = 1 << (regval & 0x03);
> 
> 		BIT()

Thanks!

>> +static int pmic5000_write_interval(struct pmic5000_data *data, long val)
>> +{
>> +	struct regmap *regmap = data->regmap;
>> +	u32 regval;
>> +	int err;
>> +
>> +	switch (val) {
>> +	case 1:
>> +		regval = 0;
>> +		break;
>> +	case 2:
>> +		regval = 1;
>> +		break;
>> +	case 4:
>> +		regval = 2;
>> +		break;
>> +	case 8:
>> +		regval = 3;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
> find_closest() would be more appropriate here. We don't usually expect users to know valid
> update intervals.

Thanks!

>> +static int pmic5000_common_probe(struct device *dev, struct regmap *regmap)
> 
> Why pmic5000_common_probe() ? There is only one caller.

Good point, I'll move it.

>> +static const struct of_device_id pmic5000_of_ids[] = {
>> +	{
>> +		.compatible = "jedec,pmic5000",
> 
> jedec,pmic5000 is not documented.

Is there some centralised database for device tree identifiers, or does
it just need to be added to trivial-devices.yaml or something?

Thanks again for your review!
Steve

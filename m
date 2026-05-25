Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676353BD638;
	Mon, 25 May 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692911; cv=none; b=Iv86TiRNYb9y8qbnrems3S5E/PwtnUMf34zWCel13opkI7xEhhV7beri2fbExrYHs5+cDY6KPZFsY6k6TrigwM3Fn8aUZL3UczXKyVmZ8E8TVcsXM1aIo4TD5dKCbhchPU53z8NHpiYxnjVtX+xw1kkwl2gQqxQ//SoVQuCqzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692911; c=relaxed/simple;
	bh=sjblgviSV/LjVvPEYdDG2aNz/gc0cw6GVK8OB7512Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbJg9t0DPrUYgEmNjAeRqGsibA7JP5DU1FIGy0fpMwXjGrEhyd+Z76jqq6UIvox1C7xKuMr8JErFiAK8DMlOt/kE+nRDAsYXtKGC6SE7DIhmRQ2uappAJWQLBS7w49PpSlPmRXcO9cPndCxiQ2JTZiu5woqJhn/1MqSepJX4Iyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5dc55c87.dip0.t-ipconnect.de [93.197.92.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 721DC4C1A2DF81;
	Mon, 25 May 2026 09:07:44 +0200 (CEST)
Message-ID: <84448a84-1c96-45a9-9ba8-1e058d0bf8a5@molgen.mpg.de>
Date: Mon, 25 May 2026 09:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: eeprom: at24: Make VCC supply description
 requirement optional
To: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
 <ahN2m3kCbyTUNXzZ@sirena.org.uk>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ahN2m3kCbyTUNXzZ@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mark,


Thank you for taking the time to review and respond.


Am 25.05.26 um 00:07 schrieb Mark Brown:
> On Sun, May 24, 2026 at 10:05:33AM +0200, Paul Menzel wrote:
> 
>> Some platforms (e.g. IBM Power System S822LC (8335-GCA POWER8)) do not
>> describe the EEPROM’s VCC supply in firmware-provided device trees.
>> Using `devm_regulator_get()` on such systems falls back to a dummy
>> regulator with a kernel warning:
> 
>> Switch to `devm_regulator_get_optional()` and treat -ENODEV as “no
>> supply described”. When `vcc_reg` is NULL, skip all
>> regulator_enable/disable calls; the hardware is assumed to be always
>> powered. Linux now logs:
> 
> This is not appropriate unless the device can actually operate without
> power, any driver could be used in a system where the firmware does not
> describe the regultors and it'd obviously be pointless and error prone
> to scatter bodges like this on every single call to a regulator API
> function.

How should the warning on the POWER server be addressed then?


Kind regards,

Paul

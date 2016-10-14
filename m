From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: Re: [PATCH v2] i2c: i2c-piix4: several coding style fixes
Date: Fri, 14 Oct 2016 12:52:50 +0100
Message-ID: <3c9ba6ec-c137-fa3c-7b5b-7ea7ed58e865@synopsys.com>
References: <20161013223901.16460-1-palminha@synopsys.com>
 <20161014070825.qlawh2ttlwj24jge@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:56057 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbcJNLz6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Oct 2016 07:55:58 -0400
In-Reply-To: <20161014070825.qlawh2ttlwj24jge@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 14-10-2016 08:08, Uwe Kleine-König wrote:
> Hello,
>
> On Thu, Oct 13, 2016 at 11:39:01PM +0100, Carlos Palminha wrote:
>> @@ -196,7 +204,7 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
>>  	} else {
>>  		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
>>  		piix4_smba &= 0xfff0;
>> -		if(piix4_smba == 0) {
>> +		if (piix4_smba == 0) {
>>  			dev_err(&PIIX4_dev->dev, "SMBus base address "
>>  				"uninitialized - upgrade BIOS or use "
>>  				"force_addr=0xaddr\n");
>
> did you left this message in three lines on purpose?
>
Hi Uwe,

There were some missing lines. I had some doubts regarding if the 
"quoted string" could go with more than 80 chars. I see now that 
checkpatch is ok.

I'll resend a v3.

> Best regards
> Uwe
>

Regards,
C.Palminha

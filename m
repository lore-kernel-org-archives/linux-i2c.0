From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: Re: [PATCH 0/5] i2c: i2c-piix4: set of coding style fixes
Date: Thu, 13 Oct 2016 17:44:09 +0100
Message-ID: <57FFB9D9.7020903@synopsys.com>
References: <20161011172441.7422-1-palminha@synopsys.com>
 <20161013134029.1828048b@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013134029.1828048b@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On 13-10-2016 12:40, Jean Delvare wrote:
> Hi Carlos,
> 
> On Tue, 11 Oct 2016 18:24:36 +0100, Carlos Palminha wrote:
>> This patchset fixes several coding style issues.
>>
>> Carlos Palminha (5):
>>   i2c: i2c-piix4: coding style fix - '*' adjacent to data name
>>   i2c: i2c-piix4: coding style fix - assignment in if condition
>>   i2c: i2c-piix4: coding style fix - long comments blocks
>>   i2c: i2c-piix4: coding style fix - spaces with open parenthesis
>>   i2c: i2c-piix4: coding style fix - quoted string split across lines
>>
>>  drivers/i2c/busses/i2c-piix4.c | 144 +++++++++++++++++++++++------------------
>>  1 file changed, 82 insertions(+), 62 deletions(-)
> 
> Except for the two issues which were already pointed out, I'm fine with
> these changes, however there is no good reason to split them into 5
> separate patches. Fixing the coding style is one goal, it should be all
> done with a single patch. So, when you resubmit, please do so as a
> single patch.
> 
> Thanks,
> 

Sure... I'll resubmit as one patch.

Regards,
C.Palminha

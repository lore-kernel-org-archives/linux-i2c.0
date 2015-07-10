From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Fri, 10 Jul 2015 21:26:30 +0300
Message-ID: <55A00E56.2020308@ti.com>
References: <5582870B.7030304@nokia.com> <558288B0.1020706@ti.com> <5582F049.8070407@ti.com> <20150709195309.GI4744@katana> <559FEC8C.9030603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559FEC8C.9030603-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,
On 07/10/2015 07:02 PM, Sekhar Nori wrote:
> On Friday 10 July 2015 01:23 AM, Wolfram Sang wrote:
>> On Thu, Jun 18, 2015 at 12:22:33PM -0400, Murali Karicheri wrote:
>>> On 06/18/2015 05:00 AM, Sekhar Nori wrote:
>>>> On Thursday 18 June 2015 02:23 PM, Alexander Sverdlin wrote:
>>>>> According to KeyStone Architecture I2C User Guide,
>>>>>
>>>>>                           module clock frequency
>>>>> master clock frequency = ----------------------
>>>>>                           (ICCL + 6) + (ICCH + 6)
>>>>>
>>>>> i.e. "d" in i2c_davinci_calc_clk_dividers() should be fixed and
>>>>> not dependent from module clock prescaler PSC on these SoCs.
>>>>>
>>>>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>>>> ---
>>>>>
>>>>> RFC: If someone from TI has an idea how to improve the coverage of future Keystone
>>>>> revisions -- hints/patches are welcome. The current ID check is based on
>>>>> Davinci/Keystone datasheets and is at least working on real Keystone II.
>>>>
>>>> + Murali who works on Keystone devices in TI.
>>>
>>> + Grygorii
>>>
>>> + Grygorii has been involved in the Keystone related enhancement and
>>> reviewing prior patches. Need to have his ack for this change
>>
>> Any news?
> 
> Fixing Grygorii's e-mail id.
> 
> Grygorii, let me know if you don't have the thread. I can forward.

Thanks Sekhar.

My opinion - it's time for compatible string :) "ti,keystone-i2c". 
Especially taking int account two things:
1) In Datasheet SPRS893B TCI6630K2L Multicore DSP+ARM KeyStone II System-on-Chip (SoC) (Rev. E) 
   values for those registers specified as:
   0x0034 ICPID1 I2C Peripheral Identification Register 1 [value: 0x0000 0105]
   0x0038 ICPID2 I2C Peripheral Identification Register 2 [value: 0x0000 0005]
   (actually the same is in k2h, k2e Datasheets).

2) This is not the first time such discussion has been raised.


>> > This is not really critical fix. Currently bus rate is lower than expected because of these
>> > calculation errors. The fix maximizes the bus rate. So newer SoCs will run little bit slower
>> > until support is added to this part of the code. Not really critical. 

Regarding the patch itself:
- Seems the "d" value is fixed to 6 as per User Guide SPRUGV3
  "KeyStone Architecture 2 Inter-IC Control Bus (I2C)" and this change is correct. 
  It would be nice to have ref on document in commit message as above.

- I think, it will be very useful to have same real digits/calculation mentioned in
  commit message which can show how valuable is the improvement. 

-- 
regards,
-grygorii

From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Thu, 13 Aug 2015 12:29:06 +0200
Message-ID: <55CC7172.9090700@nokia.com>
References: <5582870B.7030304@nokia.com> <558288B0.1020706@ti.com>
 <5582F049.8070407@ti.com> <20150709195309.GI4744@katana>
 <559FEC8C.9030603@ti.com> <55A00E56.2020308@ti.com>
 <20150812084352.GA1524@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150812084352.GA1524@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 12/08/15 10:43, ext Wolfram Sang wrote:
>> > My opinion - it's time for compatible string :) "ti,keystone-i2c". 
>> > Especially taking int account two things:
>> > 1) In Datasheet SPRS893B TCI6630K2L Multicore DSP+ARM KeyStone II System-on-Chip (SoC) (Rev. E) 
>> >    values for those registers specified as:
>> >    0x0034 ICPID1 I2C Peripheral Identification Register 1 [value: 0x0000 0105]
>> >    0x0038 ICPID2 I2C Peripheral Identification Register 2 [value: 0x0000 0005]
>> >    (actually the same is in k2h, k2e Datasheets).
>> > 
>> > 2) This is not the first time such discussion has been raised.
>> > 
>> > 
>>>>> > >> > This is not really critical fix. Currently bus rate is lower than expected because of these
>>>>> > >> > calculation errors. The fix maximizes the bus rate. So newer SoCs will run little bit slower
>>>>> > >> > until support is added to this part of the code. Not really critical. 
>> > 
>> > Regarding the patch itself:
>> > - Seems the "d" value is fixed to 6 as per User Guide SPRUGV3
>> >   "KeyStone Architecture 2 Inter-IC Control Bus (I2C)" and this change is correct. 
>> >   It would be nice to have ref on document in commit message as above.
>> > 
>> > - I think, it will be very useful to have same real digits/calculation mentioned in
>> >   commit message which can show how valuable is the improvement. 
> Alexander, any comments to this feedback?

I would need to rework the patch to distinguish Keystones basing on DT compatible property.
I will re-send another version along with actual bofore-after real world numbers.
Thanks for feedback!

-- 
Best regards,
Alexander Sverdlin.

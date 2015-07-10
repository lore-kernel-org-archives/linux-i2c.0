From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Fri, 10 Jul 2015 21:32:20 +0530
Message-ID: <559FEC8C.9030603@ti.com>
References: <5582870B.7030304@nokia.com> <558288B0.1020706@ti.com> <5582F049.8070407@ti.com> <20150709195309.GI4744@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150709195309.GI4744@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 10 July 2015 01:23 AM, Wolfram Sang wrote:
> On Thu, Jun 18, 2015 at 12:22:33PM -0400, Murali Karicheri wrote:
>> On 06/18/2015 05:00 AM, Sekhar Nori wrote:
>>> On Thursday 18 June 2015 02:23 PM, Alexander Sverdlin wrote:
>>>> According to KeyStone Architecture I2C User Guide,
>>>>
>>>>                          module clock frequency
>>>> master clock frequency = ----------------------
>>>>                          (ICCL + 6) + (ICCH + 6)
>>>>
>>>> i.e. "d" in i2c_davinci_calc_clk_dividers() should be fixed and
>>>> not dependent from module clock prescaler PSC on these SoCs.
>>>>
>>>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>
>>>> RFC: If someone from TI has an idea how to improve the coverage of future Keystone
>>>> revisions -- hints/patches are welcome. The current ID check is based on
>>>> Davinci/Keystone datasheets and is at least working on real Keystone II.
>>>
>>> + Murali who works on Keystone devices in TI.
>>
>> + Grygorii
>>
>> + Grygorii has been involved in the Keystone related enhancement and
>> reviewing prior patches. Need to have his ack for this change
> 
> Any news?

Fixing Grygorii's e-mail id.

Grygorii, let me know if you don't have the thread. I can forward.

Thanks,
Sekhar

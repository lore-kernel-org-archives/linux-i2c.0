From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4] i2c: davinci: Fix race when setting up for TX
Date: Thu, 23 Sep 2010 07:27:38 -0700
Message-ID: <87d3s47cx1.fsf@deeprootsystems.com>
References: <4C97CEC9.8060602@boundarydevices.com>
	<1285042408-13200-1-git-send-email-jon.povey@racelogic.co.uk>
	<026901cb597f$86fa9980$94efcc80$@raj@ti.com>
	<4C9904E6.7070608@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C9904E6.7070608-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org> (Troy Kisky's message of
	"Tue, 21 Sep 2010 12:17:58 -0700")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org> writes:

> On 9/21/2010 4:24 AM, Sudhakar Rajashekhara wrote:
>> Hi,
>> 
>> On Tue, Sep 21, 2010 at 09:43:28, Jon Povey wrote:
>>> When setting up to transmit, a race exists between the ISR and
>>> i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
>>> This is mostly visible for transmits > 1 byte long.
>>>
>>> The hardware starts sending immediately that MDR.STT is set. IMR trickery
>>> doesn't work because if we start sending, finish the first byte and an
>>> XRDY event occurs before we load IMR to unmask it, we never get an
>>> interrupt, and we timeout.
>>>
>>> Sudhakar Rajashekhara explains that at least OMAP-L138 requires MDR mode
>>> settings before DXR for correct behaviour, so load MDR first with
>>> STT cleared and later load again with STT set.
>>>
>>> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
>>>
>>> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
>>> CC: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
>>> CC: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
>>> ---
>>> Reworked after comments by Troy and Sudhakar.
>>>
>>> Looking at the datasheet it seemed like setting STP without STT early
>>> might cause a stray STOP to be generated, so I moved it into the second
>>> MDR load.
>>>
>>> This passes a quick smoke test but I can't do much more testing right at
>>> the moment. Sudhakar, your comments would be welcomed.
>>>
>> 
>> Looks good to me. I can test on couple of platforms I have and update the result
>> by tomorrow.
>> 
>> Thanks,
>> Sudhakar
>> 
>> 
>> 
> I like it too. I hope it works for omap.

Troy, can I take this as an Acked-by from you?  or a Tested-by?

Thanks,

Kevin

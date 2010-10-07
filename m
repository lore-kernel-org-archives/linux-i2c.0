From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4] i2c: davinci: Fix race when setting up for TX
Date: Thu, 07 Oct 2010 10:01:53 -0700
Message-ID: <87wrpu9bsu.fsf@deeprootsystems.com>
References: <70E876B0EA86DD4BAF101844BC814DFE093EE3EA57@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE093EE3EA57-lPJtnb2sqtq44ywRPIzf9A@public.gmane.org> (Jon
	Povey's message of "Thu, 7 Oct 2010 09:39:31 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c@vger.kernel.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org> writes:

> Hi Ben,
>
> I am not on the i2c list but noticed this pull request:
> http://www.spinics.net/linux/lists/linux-i2c/msg04022.html
>
> I think you have the wrong (old) version of this patch in that branch,
> http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=commitdiff;h=4bba0fd8d1c6d405df666e2573e1a1f917098be0
>
> The correct v4 one from the start of this thread has more lines
> of patch and this commit message:

It is also available in my davinci-i2c branch:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git davinci-i2c

Thanks Jon for catching this,

Kevin

>>>>>> When setting up to transmit, a race exists between the ISR and
>>>>>> i2c_davinci_xfer_msg() trying to load the first byte and adjust
>>>>>> counters. This is mostly visible for transmits > 1 byte long.
>>>>>>
>>>>>> The hardware starts sending immediately that MDR.STT is set. IMR
>>>>>> trickery doesn't work because if we start sending, finish the
>>>>>> first byte and an XRDY event occurs before we load IMR to unmask
>>>>>> it, we never get an interrupt, and we timeout.
>>>>>>
>>>>>> Sudhakar Rajashekhara explains that at least OMAP-L138 requires
>>>>>> MDR mode settings before DXR for correct behaviour, so load MDR
>>>>>> first with STT cleared and later load again with STT set.
>>>>>>
>>>>>> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
>>>>>>
>>>>>> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
>>>>>> CC: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
>>>>>> CC: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
>
> It also has some more acks and a tested, via Kevin:
>
>> Acked-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
>> Tested-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
>> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>
>
> --
> Jon Povey
> jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org
>
> Racelogic is a limited company registered in England. Registered number 2743719 .
> Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .
>
> The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network

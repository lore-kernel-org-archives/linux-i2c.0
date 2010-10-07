From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4] i2c: davinci: Fix race when setting up for TX
Date: Thu, 07 Oct 2010 10:20:23 -0700
Message-ID: <87hbgxapig.fsf@deeprootsystems.com>
References: <70E876B0EA86DD4BAF101844BC814DFE093EE3EA57@Cloud.RL.local>
	<87wrpu9bsu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87wrpu9bsu.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> (Kevin Hilman's message of
	"Thu, 07 Oct 2010 10:01:53 -0700")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c@vger.kernel.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> writes:

> Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org> writes:
>
>> Hi Ben,
>>
>> I am not on the i2c list but noticed this pull request:
>> http://www.spinics.net/linux/lists/linux-i2c/msg04022.html
>>
>> I think you have the wrong (old) version of this patch in that branch,
>> http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=commitdiff;h=4bba0fd8d1c6d405df666e2573e1a1f917098be0
>>
>> The correct v4 one from the start of this thread has more lines
>> of patch and this commit message:
>
> It is also available in my davinci-i2c branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git davinci-i2c
>
> Thanks Jon for catching this,

I just noticed that it has already been pulled and is part of -rc7.

Jon, care to submit a new patch with v4 diff and including the acks and
tested-bys?

Thanks,

Kevin

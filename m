From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/10] i2c-designware: Allow mixed endianness accesses
Date: Tue, 08 Feb 2011 07:52:00 -0800
Message-ID: <4D5166A0.5080208@gmail.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com> <1296699608-13227-2-git-send-email-dirk.brandewie@gmail.com> <4D4B7B23.9010705@renesas.com> <20110205173935.GG15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110205173935.GG15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/05/2011 09:39 AM, Ben Dooks wrote:
> On Fri, Feb 04, 2011 at 01:05:55PM +0900, Shinya Kuribayashi wrote:
>> On 2/3/2011 11:19 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>> From: Dirk Brandewie<dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> Allows CPUs of a given endianness to access a dw controller of a different
>>> endianness. Endianncess difference is detected at run time through the dw
>>> component type register.
>>>
>>> This is the hand application of a patch set by Jean-Hugues Deschenes
>>> applied at the sugestion of Shinya Kuribayashi
>>>
>>> Signed-off-by: Dirk Brandewie<dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> The patch is originally from Jean-Hugues Deschenes, not you, Dirk.
>> We should preserve patch histories properly, and should honor the
>> original submitter.
>>
>> For the same reason, I'd like to see the original patches from Jean
>> in three, logically-separate patches, not combo patch like this.
>
> Thankyou for noting this, Dirk please sort this out.
>
I will apply Jeans patch set at the beginning.  I had no intention to claim 
others work and said so in the commit message.  I was trying to keep the number 
of patches down my bad.

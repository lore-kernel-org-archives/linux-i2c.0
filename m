From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/10] i2c-designware: retrieve clock frequency based
 CONFIG_HAVE_CLK
Date: Tue, 08 Feb 2011 08:00:23 -0800
Message-ID: <4D516897.8060802@gmail.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com> <1296699608-13227-4-git-send-email-dirk.brandewie@gmail.com> <20110205174636.GI15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110205174636.GI15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/05/2011 09:46 AM, Ben Dooks wrote:
> On Wed, Feb 02, 2011 at 06:20:01PM -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Dirk Brandewie<dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> x86 does not have clk_dev support.  The PCI variant of the driver sets
>> the clock rate being supplied to the IP block based on config
>> information attached to the PCI ID
>
> Could you have a set of defines before these functions that provide dummy
> clk_() calls? Not so happy with the #ifdefs in the code.
>
I think I will change these to be a callback into the bus specific code so 
IFDEF's go away in the core code.

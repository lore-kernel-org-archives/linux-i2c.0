From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 01/10] i2c-designware: Allow mixed endianness accesses
Date: Fri, 04 Feb 2011 13:05:55 +0900
Message-ID: <4D4B7B23.9010705@renesas.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
 <1296699608-13227-2-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1296699608-13227-2-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2/3/2011 11:19 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Allows CPUs of a given endianness to access a dw controller of a different
> endianness. Endianncess difference is detected at run time through the dw
> component type register.
> 
> This is the hand application of a patch set by Jean-Hugues Deschenes
> applied at the sugestion of Shinya Kuribayashi
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The patch is originally from Jean-Hugues Deschenes, not you, Dirk.
We should preserve patch histories properly, and should honor the
original submitter.

For the same reason, I'd like to see the original patches from Jean
in three, logically-separate patches, not combo patch like this.
-- 
Shinya Kuribayashi
Renesas Electronics

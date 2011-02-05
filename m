From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 01/10] i2c-designware: Allow mixed endianness accesses
Date: Sat, 5 Feb 2011 17:39:35 +0000
Message-ID: <20110205173935.GG15795@trinity.fluff.org>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com> <1296699608-13227-2-git-send-email-dirk.brandewie@gmail.com> <4D4B7B23.9010705@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D4B7B23.9010705-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 04, 2011 at 01:05:55PM +0900, Shinya Kuribayashi wrote:
> On 2/3/2011 11:19 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > Allows CPUs of a given endianness to access a dw controller of a different
> > endianness. Endianncess difference is detected at run time through the dw
> > component type register.
> > 
> > This is the hand application of a patch set by Jean-Hugues Deschenes
> > applied at the sugestion of Shinya Kuribayashi
> > 
> > Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> The patch is originally from Jean-Hugues Deschenes, not you, Dirk.
> We should preserve patch histories properly, and should honor the
> original submitter.
> 
> For the same reason, I'd like to see the original patches from Jean
> in three, logically-separate patches, not combo patch like this.

Thankyou for noting this, Dirk please sort this out.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

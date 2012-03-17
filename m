From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 0/2] i2c: Don't assume bus nr 0 if none was specified
Date: Sat, 17 Mar 2012 10:50:56 +0000
Message-ID: <20120317105056.BC9EE3E093F@localhost>
References: <1331900343-6743-1-git-send-email-k.lewandowsk@samsung.com> <4F6331AF.3010007@samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F6331AF.3010007-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 16 Mar 2012 13:27:27 +0100, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On 16.03.2012 13:19, Karol Lewandowski wrote:
> 
> > Hi,
> > 
> > i2c controller drivers used to assume bus number 0 when none (-1) was specified.
> > 
> > This worked on non-device tree systems, where one could explicitly specify
> > bus number via platform data.  On DT-enabled systems bus number is always -1.
> > 
> > Some drivers assume bus number 0 when -1 is specified.  This patchset kills
> > this logic and switches to dynamic bus allocation (default when -1 is provided[1]).
> 
> 
> [ I must have lost actual problem description while rewording
>   message itself... ]
> 
> Problem arises when multiple drivers (or multiple instances
> of one driver) try to assume the same fixed bus number (0).
> 
> This causes simply causes i2c_add_numbered_bus() to fail.
> Leaving -1 works perfectly, as registration function switches
> to dynamic id registration.

Patch series looks good to me.  You'll need acks from the affected users.

g.

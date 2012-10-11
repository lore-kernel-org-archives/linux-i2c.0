From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 13/13] drivers/media/tuners/e4000.c: use macros for
 i2c_msg initialization
Date: Thu, 11 Oct 2012 08:45:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1210110836030.2010@hadrien>
References: <1349624323-15584-1-git-send-email-Julia.Lawall@lip6.fr> <1349624323-15584-3-git-send-email-Julia.Lawall@lip6.fr> <5071AEF3.6080108@bfs.de> <alpine.DEB.2.02.1210071839040.2745@localhost6.localdomain6> <5071B834.1010200@bfs.de>
 <alpine.DEB.2.02.1210071917040.2745@localhost6.localdomain6> <1349633780.15802.8.camel@joe-AO722> <alpine.DEB.2.02.1210072053550.2745@localhost6.localdomain6> <1349645970.15802.12.camel@joe-AO722> <alpine.DEB.2.02.1210072342460.2745@localhost6.localdomain6>
 <1349646718.15802.16.camel@joe-AO722> <20121007225639.364a41b4@infradead.org> <50723661.6040107@gmail.com> <alpine.DEB.2.02.1210081028340.1989@hadrien> <20121009203238.63d2275f@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121009203238.63d2275f-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, walter harms <wharms-fPG8STNUNVg@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I found 6 cases where there are more than 2 messages in the array.  I
didn't check how many cases where there are two messages but there is
something other than one read and one write.

Perhaps a reasonable option would be to use

I2C_MSG_READ
I2C_MSG_WRITE
I2C_MSG_READ_OP
I2C_MSG_WRITE_OP

The last two are for the few cases where more flags are specified.  As
compared to the original proposal of I2C_MSG_OP, these keep the READ or
WRITE idea in the macro name.  The additional argument to the OP macros
would be or'd with the read or write (nothing to do in this case) flags as
appropriate.

Mauro proposed INIT_I2C_READ_SUBADDR for the very common case where a
message array has one read and one write.  I think that putting one
I2C_MSG_READ and one I2C_MSG_WRITE in this case is readable enough, and
avoids the need to do something special for the cases that don't match the
expectations of INIT_I2C_READ_SUBADDR.

I propose not to do anything for the moment either for sizes or for
message or buffer arrays that contain only one element.

julia

From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: i2c-next pull request
Date: Mon, 5 Jan 2009 19:01:34 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901051858250.3057@localhost.localdomain>
References: <E1LJn9P-00013j-2W@teyla.home.fluff.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1LJn9P-00013j-2W-fIsYBodh/r28n8r38hOLvmD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Mon, 5 Jan 2009, Ben Dooks wrote:
>
> are available in the git repository at:
> 
>   git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-next

I fixed up a conflict that _looked_ trivial in 
drivers/i2c/busses/i2c-s3c2410.c, and since I can't even compile-test it, 
you should double-check. We had one branch remove the need for 
regs-gpio.h, and the ARM merge had moved the header files around..

All the commits in question were actually yours, they just came in from 
different trees. So if it's not right, I'm sure you can fix it up ;)

		Linus

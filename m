From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: [PATCH] video: limit stack usage of ir-kbd-i2c.c
Date: Wed, 27 Feb 2008 11:23:26 +0100
Message-ID: <20080227102309.GA6698@joi>
References: <20080225205055.GA27455@joi> <20080226133222.7af260b2@hyperion.delvare> <20080226210307.GA6085@joi> <20080226232320.2df756d6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756484AbYB0KYu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080226232320.2df756d6@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, i2c@lm-sensors.org, video4linux-list@redhat.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 26, 2008 at 11:23:20PM +0100, Jean Delvare wrote:
> Hi Marcin,
Hi
 
> On Tue, 26 Feb 2008 22:03:16 +0100, Marcin Slusarz wrote:
> > Do you have an idea (or patch :D) how to solve this:
> > 0x00000234 v4l_compat_translate_ioctl [v4l1-compat]:    1376
> > ? That's on top of my make checkstack output
> 
> Random ideas (but I am in no way a specialist of this exercise):
> 
> * You could try moving the structures to the blocks where they are used,
> in the case a given structure is used for only one ioctl. I'm not too
> sure how gcc handles local variables declared inside blocks with
> regards to stack reservation though. I thought it would work but my
> experiments today seem to suggest it doesn't.
That won't work. Variables at beginning of function take only ~600 bytes,
so the rest must be from inner blocks and inlines (probably).

> * You can move the handling of some ioctls to dedicated functions, just
> like I did in i2c-dev:
> http://lists.lm-sensors.org/pipermail/i2c/2008-February/003010.html
> However there is a risk that gcc will inline these functions (that's
> what happened to me...) Not sure how to prevent gcc from inlining.
There's "noinline" attribute in linux/compiler.h (compiler-gcc.h actually)
for these situations.
 
> * You can allocate the structures dynamically, as you originally wanted
> to do for ir-kbd-i2c. However this has a performance penalty and will
> fragment the memory, so it's not ideal.
> 
> * If each ioctl uses only one of the structures, you may define a union
> of all the structures. The size of the union will be the size of the
> biggest structure, so you save a lot of space on the stack.
Nice idea.

I'll try 2nd and 4th approaches.

Marcin Slusarz

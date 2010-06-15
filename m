From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 6/8]i2c:i2c_core Fix warning: variable 'dummy' set but
 not used
Date: Tue, 15 Jun 2010 13:43:43 +0200
Message-ID: <20100615134343.6ae4a6e1@hyperion.delvare>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>
	<1276547208-26569-7-git-send-email-justinmattock@gmail.com>
	<20100614225315.2bae9e37@hyperion.delvare>
	<4C1699C4.3010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C1699C4.3010809-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Justin,

On Mon, 14 Jun 2010 14:06:12 -0700, Justin P. Mattock wrote:
> On 06/14/2010 01:53 PM, Jean Delvare wrote:
> > Hi Justin,
> >
> > On Mon, 14 Jun 2010 13:26:46 -0700, Justin P. Mattock wrote:
> >> could be a right solution, could be wrong
> >> here is the warning:
> >>    CC      drivers/i2c/i2c-core.o
> >> drivers/i2c/i2c-core.c: In function 'i2c_register_adapter':
> >> drivers/i2c/i2c-core.c:757:15: warning: variable 'dummy' set but not used
> >>
> >>   Signed-off-by: Justin P. Mattock<justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> ---
> >>   drivers/i2c/i2c-core.c |    2 ++
> >>   1 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >> index 1cca263..79c6c26 100644
> >> --- a/drivers/i2c/i2c-core.c
> >> +++ b/drivers/i2c/i2c-core.c
> >> @@ -794,6 +794,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
> >>   	mutex_lock(&core_lock);
> >>   	dummy = bus_for_each_drv(&i2c_bus_type, NULL, adap,
> >>   				 __process_new_adapter);
> >> +	if(!dummy)
> >> +		dummy = 0;
> >
> > One word: scripts/checkpatch.pl
> 
> it was this, and/or just take the code out
> (since I'm a newbie)

I was not (yet) arguing on the code itself, but on its format. Any
patch you send should pass the formatting tests performed by
scripts/checkpatch.pl. Thanks.

-- 
Jean Delvare

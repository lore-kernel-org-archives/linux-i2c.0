From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 6/8]i2c:i2c_core Fix warning: variable 'dummy' set but
  not used
Date: Wed, 16 Jun 2010 11:45:17 +0200
Message-ID: <20100616114517.5ac49e26@hyperion.delvare>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>
	<1276547208-26569-7-git-send-email-justinmattock@gmail.com>
	<20100614225315.2bae9e37@hyperion.delvare>
	<4C169F19.1040608@gmail.com>
	<20100615134039.6ccfc17a@hyperion.delvare>
	<4C17A857.8030306@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C17A857.8030306-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: David Daney <david.s.daney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jun 2010 09:20:39 -0700, David Daney wrote:
> On 06/15/2010 04:40 AM, Jean Delvare wrote:
> > __process_new_adapter() calls i2c_do_add_adapter() which always returns
> > 0. Why should I check the return value of bus_for_each_drv() when I
> > know it will always be 0 by construction?
> >
> > Also note that the same function is also called through
> > bus_for_each_dev() somewhere else in i2c-core, and there is no warning
> > there because bus_for_each_dev() is not marked __must_check. How
> > consistent is this? If bus_for_each_dev() is OK without __must_check,
> > then I can't see why bus_for_each_drv() wouldn't be.
> 
> Well, I would advocate removing the __must_check then.

I have just sent a patch to LKML doing exactly this.

-- 
Jean Delvare

From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Q] i2c_new_device vs i2c_del_driver
Date: Tue, 17 Mar 2009 19:29:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0903171923230.5318@axis700.grange>
References: <Pine.LNX.4.64.0903171710350.5318@axis700.grange>
 <20090317183809.55320908@hyperion.delvare> <Pine.LNX.4.64.0903171849060.5318@axis700.grange>
 <20090317191724.7ace956f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090317191724.7ace956f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Mar 2009, Jean Delvare wrote:

> On Tue, 17 Mar 2009 18:50:50 +0100 (CET), Guennadi Liakhovetski wrote:
> > 
> > Aha, so, the driver->clients list will not contain my device, and it won't 
> > get unregistered. Ic.
> 
> Correct. Maybe I should have found a better name, like
> driver->detected_clients, to make it clearer. Want me to change it
> know? It should be straightforward.

Well, now I know the difference already, but I am not sure this would have 
helped me before you've explained it:-) So, don't bother because of me. 
Maybe adding a couple of words to Documentation/i2c/writing-clients 
explaining the different function i2c_del_driver() performs on different 
devices. Or a comment in the source - even better.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

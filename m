From: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-gpio: use deferred probing with the device tree
Date: Tue, 08 Oct 2013 15:34:56 +0200
Message-ID: <52540A00.9030505@nsn.com>
References: <52540692.9080208@nsn.com> <87ob6znb3q.fsf@thor.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87ob6znb3q.fsf-1Ae4nN3xCbAluPl5bxqUMw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08.10.2013 15:30, ext Peter Korsgaard wrote:
>>>>>> "IN" == Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org> writes:
> 
> IN> If the i2c-parent bus driver is not loaded, returning
> IN> -EINVAL will force people to unload and then reload the
> IN> module again to get it working.
> 
> IN> Also of_get_named_gpio could return -E_PROBE_DEFER or
> IN> another error code. This error should be passed further
> IN> instead of being ignored.
> 
> Two different fixes, so should be 2 separate patches. Other that that,
> it looks good.
> 
> Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> 

Right, I will split it into two patches and re-submit.

Thanks!

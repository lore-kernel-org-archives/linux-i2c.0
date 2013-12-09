From: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mux: Inherit retry count from parent controller for
 muxed bus.
Date: Mon, 9 Dec 2013 12:26:56 +0100
Message-ID: <CAGWqfig7L_+WwTC-8EeuU32SKsGGAgmcwRjVe63j13oSjCSKMQ@mail.gmail.com>
References: <1386499701-5522-1-git-send-email-eliedebrauwer@gmail.com>
	<1386499701-5522-2-git-send-email-eliedebrauwer@gmail.com>
	<20131209110810.GA2569@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131209110810.GA2569@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 9, 2013 at 12:08 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Sun, Dec 08, 2013 at 11:48:20AM +0100, Elie De Brauwer wrote:
>> Today if a mux i2c bus gets created the default retry count of the
>> muxed bus is zero. Hence it it possible that you end up with a
>> situation where the parent controller sets a default retry count
>> which gets applied and used while the muxed bus (using the same
>> controller) has a default retry count of zero. This can be solved
>> by initializing the retry count of the muxed bus by the retry count
>> of the parent at creation time.
>>
>> Signed-off-by: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Makes sense. Have you checked the timeout value, too?
>

Point taken, I hadn't bumped into this since i2c_add_mux_adapter() calls
i2c_add_adapter() which essentially sets is to 1 second if it is zero. But
it makes sense indeed to also use this value from the parent. I'll post an
updated version later today.

Thanks
E.


-- 
Elie De Brauwer

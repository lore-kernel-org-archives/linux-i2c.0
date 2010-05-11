From: Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-nomadik: release region when removed
Date: Tue, 11 May 2010 10:53:24 +0530
Message-ID: <20100511052322.GA22860@bnru02.bnr.st.com>
References: <1272344468-9411-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1272344468-9411-1-git-send-email-rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben,

On Tue, Apr 27, 2010 at 07:01:07AM +0200, Rabin VINCENT wrote:
> So that the module can be loaded again after an unload.
> 
> Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Will you be taking these two patches via your tree?

Thanks,
Rabin

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-bit: Cleanup bus_test calling convention
Date: Fri, 15 Apr 2011 18:07:53 +0200
Message-ID: <20110415180753.288b8ed7@endymion.delvare>
References: <20110415111323.51bef2ac@endymion.delvare>
	<BANLkTikBTN-3n0AUUxM2bgMKzME8zznycg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikBTN-3n0AUUxM2bgMKzME8zznycg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 15 Apr 2011 11:57:46 -0400, Alex Deucher wrote:
> On Fri, Apr 15, 2011 at 5:13 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Now that we pass the i2c_adapter as the first parameter, it makes
> > little sense to pass its name separately as the second.
> >
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > Alex, I think it would make sense to merge this into your own patch?
> >
> 
> Yeah, looks good to me.  Do you want to merge them or do you want me
> to send new patch?

I'll take care, no problem.

-- 
Jean Delvare

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Add support for deferred probing
Date: Tue, 26 Mar 2013 13:22:06 +0100
Message-ID: <20130326132206.70aea548@endymion.delvare>
References: <20130228120140.127ebb91@endymion.delvare>
	<20130322115621.GB24508@the-dreams.de>
	<20130324114301.4b5efc34@endymion.delvare>
	<20130326110908.GC8553@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130326110908.GC8553-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, 26 Mar 2013 12:09:08 +0100, Wolfram Sang wrote:
> > If you still have a concern about the types used, please clarify and
> > let me know what change you expect.
> 
> Leave it. I think the fragile part is gpio_is_valid() but this is truly
> outside the scope of this patch.
> (...)
> > Note that my patch doesn't introduce the gpio_request() calls, they
> > were there before, so this decision is actually independent from my
> > patch, and even if we decide to switch to using gpio_request_array(),
> > I'd rather do it in a separate patch for clarity.
> 
> I don't fully get it. Do you want to appl gpio_request() to this patch?
> Otherwise, I'd take it as is.

As I do not understand your question, I'd say you take my patch as is :)

Thanks,
-- 
Jean Delvare

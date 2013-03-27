From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: get the i2c pin group by pinctrl api
Date: Wed, 27 Mar 2013 16:14:39 +0100
Message-ID: <CACRpkdb=ku7fEtx7w4uJ4JGHqovVQbBK9yJt=okDXdFUYaKnLQ@mail.gmail.com>
References: <1363591361-5992-1-git-send-email-Barry.Song@csr.com>
	<CACRpkdbg=ii1XjUmVd7GOOWF_FAMq_uUcvaGstbWjiGWGEbFLQ@mail.gmail.com>
	<CAGsJ_4xN6=1myOVyz6wTagd=JCvGgta1q4wwq0RFE0XcDokoSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGsJ_4xN6=1myOVyz6wTagd=JCvGgta1q4wwq0RFE0XcDokoSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 27, 2013 at 11:36 AM, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 2013/3/27 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:

>> You only need to fetch pinctrl handles in drivers if you're
>> using anything else than the default state.
>
> well. missed this recent commit.
> it should mean we hould drop all devm_pinctrl_get_select_default() if
> the driver only takes the default pinctrl?

Yes.

> it looks like there are still a lot of drivers doing that. anyway, i
> will drop them in SiRFsoc drivers. and involve you in the coming
> patch.

I am meaning to fix that up. Just haven't had time to...
Prior to that patch it was the right thing to do.

Yours,
Linus Walleij

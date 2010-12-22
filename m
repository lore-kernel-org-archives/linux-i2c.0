From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from PM
 operations
Date: Wed, 22 Dec 2010 20:14:14 +0000
Message-ID: <20101222201413.GB8167@opensource.wolfsonmicro.com>
References: <1293041268-7707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <AANLkTin5eSg8vL4Q8yZ9tme38fbS2aAZ-xeLQSNu809B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin5eSg8vL4Q8yZ9tme38fbS2aAZ-xeLQSNu809B-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 23, 2010 at 12:49:39AM +0530, Rabin Vincent wrote:

> And even if we did want to support runtime PM interaction for legacy
> ops, the code for restore() above suffers from the problem of setting
> active even when no callback exists, like I mentioned in the same email
> for resume():

I agree it's confused, I posted an updated patch which should behave
exactly as the old code did - I think the confusion with the legacy
behaviour should be addressed seperately (and ideally in 2.6.37 or at
least a stable patch rather than 2.6.38 which is where the current patch
is targetted).

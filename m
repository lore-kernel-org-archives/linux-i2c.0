From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [PATCH] i2c-eg20t : Fix the issue of Combined R/W transfer mode
Date: Fri, 01 Jul 2011 15:19:19 +0900
Message-ID: <4E0D66E7.7070409@dsn.okisemi.com>
References: <1308813430-2697-1-git-send-email-tomoya-linux@dsn.okisemi.com> <201106230952.09286.alexander.stein@systec-electronic.com> <4E02FD74.8020503@dsn.okisemi.com> <BANLkTi=zDMnwX5xYFazM3qb17wa6yY4LZw@mail.gmail.com> <BANLkTi=y43pWQC9wxjSPCEbr47hTYbJF6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTi=y43pWQC9wxjSPCEbr47hTYbJF6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(2011/06/30 23:08), Christian Gmeiner wrote:
> I am studying the datasheet and the driver... hope to find out whats wrong.

Thank you for your report.
I will start analyze the issue next week.

-- 
tomoya
OKI SEMICONDUCTOR CO., LTD.

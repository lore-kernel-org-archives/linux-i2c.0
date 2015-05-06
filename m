From: os user <gnusercn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regarding to force bus id for channels of pca954x
Date: Thu, 7 May 2015 00:35:22 +0800
Message-ID: <CAG+qjJ9qWGYe0m9oFDYU-J=ZM2izS=bZeF5=MhDHmzaBPvb3ew@mail.gmail.com>
References: <CAG+qjJ8qEjzNkjxmUh8yng-Fcxm=_PjteoGqw38QMbP6Xe6wbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAG+qjJ8qEjzNkjxmUh8yng-Fcxm=_PjteoGqw38QMbP6Xe6wbw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi there,

For some reasons, we need to assign bus id for the channels of I2c mux pca9548.

>From the code, it seems we can use "adap_id" of

struct pca954x_platform_mode {
  int             adap_id;
  unsigned int    deselect_on_exit:1;
  unsigned int    class;
};

But my questions is, can we assign bus id through device tree and modprobe?

Thanks.

On Thu, May 7, 2015 at 12:33 AM, os user <gnusercn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi there,
>
> For some reasons, we need to assign bus id for the channels of I2c mux
> pca9548.
>
> From the code, it seems we can use "adap_id" of
>
> struct pca954x_platform_mode {
>   int             adap_id;
>   unsigned int    deselect_on_exit:1;
>   unsigned int    class;
> };
>
> But my questions is, can we assign bus id through device tree and modprobe?
>
> Thanks.
>

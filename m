From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: OMAP: send i2c message ignoring NAK
Date: Wed, 11 Jul 2012 22:22:42 +0530
Message-ID: <4FFDAF5A.8070205@ti.com>
References: <CAGm1_ktL96X7kF3tvKErtirwnL7FGU=zGe+EyhX4GcUkZUeSkQ@mail.gmail.com> <20120703103221.62fcb7ae@endymion.delvare> <CAGm1_kvBerv_Ot-NX2+ozZT3y+h4ECzwb-MM0-v=3M9aRRznzA@mail.gmail.com> <CAM=Q2cv2yCEaxjSL45PSpf8k8pgMuhr88TJ-RWc0OW1GL+n6Dg@mail.gmail.com> <CAGm1_kvLwj3iFz5M6zc+pitS_45OYPYw=aBU4bv8TdOhH600NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGm1_kvLwj3iFz5M6zc+pitS_45OYPYw=aBU4bv8TdOhH600NA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 11 July 2012 09:53 PM, Yegor Yefremov wrote:
>> OK may be you are missing patches like
>> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=464fca36d98b97ccd05e4f200ab7483d3acc8345
> No, i don't.
that's good.
>
>> > Personally will recommend the latest kernel.
> To do that, I'll have to use device tree (there is no board file) and
> I have no experience with this so far. So I'll have to postpone this
> till am335x support stabilizes.
I see.
Will check on this.

Thanks,
>
> Yegor

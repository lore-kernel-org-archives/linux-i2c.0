From: Libo Chen <chenlibo.3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/2] i2c: fix two wrong mem release
Date: Sun, 19 May 2013 10:13:06 +0800
Message-ID: <51983532.7090300@gmail.com>
References: <1368088044-20408-1-git-send-email-libo.chen@huawei.com> <20130517094301.GH17056@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130517094301.GH17056@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=E4=BA=8E 2013-5-17 17:43, Wolfram Sang =E5=86=99=E9=81=93:
> On Thu, May 09, 2013 at 04:27:22PM +0800, Libo Chen wrote:
>> >fix two wrong mem release
>> >
>> >* Changelog from v1:
>> >   * exchange out_error_no_irq and out_error_pin_mux  suggested by =
Sonic<Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>> >   * add some new tag , make code cleanly
> Thanks for the submission. I do think the proper solution would be to
> convert the drivers to use the devm_* mechanisms, though. You can che=
ck
> commit 857968434bb6dbda0911f38ec46b0c3d0c963771 ("i2c: davinci: updat=
e
> to devm_* API") as a reference.
>
> Thanks,
>
>     Wolfram

Hi, Wolfram

    It is a good idea. I will learn about it.

Thanks,
Libo

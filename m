From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-bfin-twi: handle faulty slave devices better
Date: Tue, 11 May 2010 20:03:57 -0400
Message-ID: <AANLkTilE253KvDpOGpXpxIyjqDd8Z7Uffa4JaUNneXYs@mail.gmail.com>
References: <1273403087-3326-1-git-send-email-vapier@gentoo.org>
	<1273505624-30920-1-git-send-email-vapier@gentoo.org> <20100511230901.GA31325@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100511230901.GA31325-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 11, 2010 at 19:09, Ben Dooks wrote:
> On Mon, May 10, 2010 at 11:33:44AM -0400, Mike Frysinger wrote:
>> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> Faulty slave devices might drive SDA low after a transfer finishes. =
=C2=A0So,
>> when this scenario is detected, have the master generate up to 9 ext=
ra
>> clocks until the SDA is properly released.
>
> This doesn't apply to my for-2635/i2c-bfin tree, can't find the BUFWE=
RR
> patch. will check to see if theres's something i've missed..

have you applied the other Blackfin I2C patches yet ?  the bfin i2c
branch applies cleanly to linus' current tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/vapier/blackfin.git for=
-i2c
-mike

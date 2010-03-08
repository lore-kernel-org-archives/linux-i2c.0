From: Xiaotian Feng <xtfeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: where's include/linux/i2c-xiic.h?
Date: Mon, 8 Mar 2010 11:16:57 +0800
Message-ID: <7b6bb4a51003071916v16f54d7fx9d3039826c1e1d80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

    I'm getting following compile error with current git tree, does
commit e1d5b6598cdc33257fe68302ae9db81d2f7bb883 miss file
include/linux/i2c-xiic.h?


    drivers/i2c/busses/i2c-xiic.c:39:28: error: linux/i2c-xiic.h: No
such file or directory
    drivers/i2c/busses/i2c-xiic.c: In function =E2=80=98xiic_i2c_probe=E2=
=80=99:
    drivers/i2c/busses/i2c-xiic.c:750: error: dereferencing pointer to
incomplete type
    drivers/i2c/busses/i2c-xiic.c:751: error: dereferencing pointer to
incomplete type
    make[2]: *** [drivers/i2c/busses/i2c-xiic.o] Error 1

Regards
Xiaotian

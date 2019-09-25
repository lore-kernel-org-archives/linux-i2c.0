From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL REQUEST] i2c for 5.4
Date: Tue, 24 Sep 2019 17:00:59 -0700
Message-ID: <CAHk-=wi1WroG_uZ44au_KdEcujkCvcwz+d05EDR_=6vHb8xQaw@mail.gmail.com>
References: <20190924193054.GA2215@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924193054.GA2215@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 24, 2019 at 12:31 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> - new driver for ICY, an Amiga Zorro card :)

Christ. Will that thing _never_ die?

But the reason I'm actually replying is not to comment on the apparent
death-defying Amiga hardware scene, but to point out that you should
try to fix your email configuration:

> Bj??rn Ard?? (2):
>       i2c-eeprom_slave: Add support for more eeprom models
>       i2c: slave-eeprom: Add comment about address handling

This is all fine in the git repo, being proper utf-8 "Bj=C3=B6rn Ard=C3=B6"=
.

But your mutt setup doesn't seem to be using a proper utf-8 locale and
instead uses

  Content-Type: text/plain; charset=3Dus-ascii
  Content-Disposition: inline

like it was the last century.

I don't know what the proper mutt incantation is to make it join the
modern world, but I'm sure one exists, and then your emails would get
names right too. Even if they are some funky Swedish ones with =C3=A5=C3=A4=
=C3=B6.

(And no, don't use Latin1 - it may cover Swedish and German etc, but
you really want to go with proper utf-8 and be able to handle true
complex character sets, not just the Western European ones).

            Linus

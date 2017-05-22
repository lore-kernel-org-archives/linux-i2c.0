From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL REQUEST] i2c for 4.12
Date: Mon, 22 May 2017 13:32:52 -0700
Message-ID: <CA+55aFymRrdZO-ASyZSgq4Da28fGJOSd3R-idok_L7NJdTGa0Q@mail.gmail.com>
References: <20170519204014.jumojwrdw6lfnycw@ninjato> <CA+55aFyzSD3Gt9JqGvfyyaujYnGi+kQz3vDho6LBZG+Xz2qqNA@mail.gmail.com>
 <20170522201421.zq6ao54uzubjfiiy@ninjato> <CA+55aFx2hDWoiQn2S=wHv7AQHvkq+D38EhVu67qbrHdhyGw6Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33985 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdEVUcx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 16:32:53 -0400
In-Reply-To: <CA+55aFx2hDWoiQn2S=wHv7AQHvkq+D38EhVu67qbrHdhyGw6Mg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 22, 2017 at 1:28 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Have not tested that commit, but did verify that yes it was the i2c
> pull, and am about to reboot into a kernel that just zeroes those
> variables beforehand (which seems to be the same thing that commit
> does, although it also moves lines around for some unfathomable
> reason).

Confirmed. Initializing those fields to zero fixes it.

               Linus

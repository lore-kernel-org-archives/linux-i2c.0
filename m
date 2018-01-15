From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] Documentation: i2c: drop unnecessary .owner field in examples
Date: Mon, 15 Jan 2018 22:24:52 +0200
Message-ID: <CAHp75VeamZDS=-bwGYn41y0pwKEptRE02W3bRe326Q34i68=yg@mail.gmail.com>
References: <1516018126-16119-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516018126-16119-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicholas Mc Guire <hofrat@osadl.at>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 15, 2018 at 2:08 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
> From: Nicholas Mc Guire <hofrat@osadl.at>
>
>  Currently there are a few drivers that still set the .owner
>  in the i2c_driver structure - all of which are reported by
>  coccinelle (scripts/coccinelle/api/platform_no_drv_owner.cocci)
>  and there are no cases that set the .onwer and do not call any
>  of the functions that set the .owner field anyway in any of the
>  drivers (checked by a modified coccinelle script based on the
>  above) so it seems that the examples are no longer valid and
>  .owner = THIS_MODULE, can be removed here.
>
>  While at it an obvious typo (new new) was also fixed.

AFAIU It is right only in case when someone does this, e.g.
module_i2c_driver() macro. Otherwise the field is pretty valid and
must be filled.


-- 
With Best Regards,
Andy Shevchenko

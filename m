From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] i2c: nomadik: match return type of wait_for_completion_timeout
Date: Wed, 4 Mar 2015 13:55:48 +0100
Message-ID: <CACRpkdYod8K75CnC7R6i9ghjEp6vuXfi64QUMGt=2sNexviRdw@mail.gmail.com>
References: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Alessandro Rubini <rubini@unipv.it>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 8, 2015 at 1:34 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:

> return type of wait_for_completion_timeout is unsigned long not int. as
> timeout is used for wait_for_completion_timeout exclusively here its
> type is simply changed to unsigned long.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

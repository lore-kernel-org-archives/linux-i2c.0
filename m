From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 20:29:08 +0100
Message-ID: <20170112192908.zvi7puq72rnfcj6j@ninjato>
References: <20170111091144.6881-1-ricardo.ribalda@gmail.com>
 <CAHp75VeV2TfgfaYni7oS4ax4H87euJa9ReWX+vYjZ4b5nYRsMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:43418 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750755AbdALTfv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 14:35:51 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75VeV2TfgfaYni7oS4ax4H87euJa9ReWX+vYjZ4b5nYRsMg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> After addressing below comment
> FWIW: Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>:

@andy: Please don't prefix tags. Patchwork doesn't seem to find them like this :/

> > Credit-to: Alexandre Desnoyers <alex@qtec.com>
> 
> It would be nice to put in plain test what you tell in the discussion
> here instead of non-standard (see submitting-patches.rst) tag.

@ricardo: I agree. Is this Reported-by maybe?

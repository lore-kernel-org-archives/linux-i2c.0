From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 2/2] i2c: Fix a potential use after free
Date: Sat, 28 Dec 2019 13:50:22 +0100
Message-ID: <81b35c80-74c2-e14e-4947-f23ec6197b73@web.de>
References: <1577439272-10362-1-git-send-email-vulab@iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1577439272-10362-1-git-send-email-vulab@iscas.ac.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Xu Wang <vulab@iscas.ac.cn>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

> Free the adap structure only after we are done using it.

This information can be reasonable.


> This patch just moves the put_device() down a bit to avoid the
> use after free.

I suggest to reconsider such a change because a device reference count
should eventually be decremented before decrementing the reference count
for the module which is managed by this programming interface.
Would you like to clarify the dependencies for such an use case any more?

Regards,
Markus

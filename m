From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: piix4: Avoid race conditions with IMC
Date: Thu, 12 Jan 2017 20:54:25 +0100
Message-ID: <20170112195424.mprdpyjscnj6vq6j@ninjato>
References: <20170111091144.6881-1-ricardo.ribalda@gmail.com>
 <CAHp75VeV2TfgfaYni7oS4ax4H87euJa9ReWX+vYjZ4b5nYRsMg@mail.gmail.com>
 <20170112192908.zvi7puq72rnfcj6j@ninjato>
 <CAHp75VfiwtAY6=9-Pz-NNzcYaJaHmxAB3vacMB=XMwb5wFLBkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfiwtAY6=9-Pz-NNzcYaJaHmxAB3vacMB=XMwb5wFLBkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

> > @andy: Please don't prefix tags. Patchwork doesn't seem to find them like this :/
> 
> Oops, sorry, didn't notice that. I usually use a new line for them.

Thanks for fixing it :)

> > @ricardo: I agree. Is this Reported-by maybe?
> 
> Yeah, since it was mentioned IIRC that guy is hardware engineer I
> don't think Suggested-by would work here better.

So, I changed that and applied to for-current so it can be in my next
pull-request.

Thanks!

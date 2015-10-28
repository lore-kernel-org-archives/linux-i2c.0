From: "Nicola Corna" <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Subject: Re: [PATCH v3 4/4] iio: humidity: si7020: added No Hold read mode
Date: Wed, 28 Oct 2015 06:46:28 +0000
Message-ID: <f113de76b2369d404909cfc5158feca4@rainloop.corna.info>
References: <20151027233000.GB1572@katana>
 <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1445976718-7449-4-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151027233000.GB1572@katana>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

October 28 2015 12:30 AM, "Wolfram Sang" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> Not a complete review, I just stumbled over this one:
> 
>> + if (client->adapter->quirks &&
>> + client->adapter->quirks->flags |
> 
> '|' should be '&', or?
> 
Yes, sorry. I'll update the patch.

Nicola Corna
>> + I2C_AQ_NO_CLK_STRETCH)
>> + return -ENODEV;

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c-i801: Enable interrupts for all post-ICH5 chips
Date: Sat, 15 Dec 2012 14:41:44 +0100
Message-ID: <20121215144144.0922e012@endymion.delvare>
References: <20121031120336.3229e1a2@endymion.delvare>
	<20121106203803.6af84fc8@endymion.delvare>
	<CAGS+omCzK2mj6EsCQo1q4MRFHghMzWNfHZmn3DjZuPLfDkoZXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omCzK2mj6EsCQo1q4MRFHghMzWNfHZmn3DjZuPLfDkoZXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On Thu, 13 Dec 2012 09:53:10 +0800, Daniel Kurtz wrote:
> Hi Jean,
> 
> On Wed, Nov 7, 2012 at 3:38 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > I did not receive a single bug report after interrupt support was
> > added for a limited number of chips. So I'd say the code is good and
> > should be enabled for all supported chips, that is: ICH5 and later.
> >
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > ---
> > I was able to test on Patsburg IDF channels and although I couldn't
> > test all transaction types, interrupts seem to work the same as on the
> > main SMBus channel so let's enable interrupts there too.
> 
> 
> I can confirm that the IRQ works on PantherPoint at least, if enabled
> (by this patch, for example).  However, I don't know anything about
> IDF, so I can't help there.
> Here's an R-B, if you need it:
> 
> Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Thanks for the testing and review.

> Are you targeting this for 3.8?

Yes I am. I'll send the remaining patches in my i2c queue to Linus
later today.

-- 
Jean Delvare

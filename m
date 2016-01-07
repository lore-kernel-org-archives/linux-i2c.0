From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: Re: [PATCH v2 8/8] i2c-mux: relax locking of the top i2c adapter
 during i2c controlled muxing
Date: Thu, 07 Jan 2016 09:21:36 +0100
Message-ID: <568E2010.4000202@lysator.liu.se>
References: <1452009438-27347-1-git-send-email-peda@lysator.liu.se> <1452009438-27347-9-git-send-email-peda@lysator.liu.se> <20160106144947.GA13257@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160106144947.GA13257@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Olli Salonen <olli.salonen-X3B1VOXEql0@public.gmane.org>, linux-i2c@vger.k
List-Id: linux-i2c@vger.kernel.org

Hi Rob,

On 2016-01-06 15:49, Rob Herring wrote:
> On Tue, Jan 05, 2016 at 04:57:18PM +0100, Peter Rosin wrote:
>> From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
>>
>> With a i2c topology like the following
>>
>>                        GPIO ---|  ------ BAT1
>>                         |      v /
>>    I2C  -----+----------+---- MUX
>>              |                   \
>>            EEPROM                 ------ BAT2
> 
> Yuck. One would think you would just use an I2C controlled mux in this 
> case...
>  
>> there is a locking problem with the GPIO controller since it is a client
>> on the same i2c bus that it muxes. Transfers to the mux clients (e.g. BAT1)
>> will lock the whole i2c bus prior to attempting to switch the mux to the
>> correct i2c segment. In the above case, the GPIO device is an I/O expander
>> with an i2c interface, and since the GPIO subsystem knows nothing (and
>> rightfully so) about the lockless needs of the i2c mux code, this results
>> in a deadlock when the GPIO driver issues i2c transfers to modify the
>> mux.
>>
>> So, observing that while it is needed to have the i2c bus locked during the
>> actual MUX update in order to avoid random garbage on the slave side, it
>> is not strictly a must to have it locked over the whole sequence of a full
>> select-transfer-deselect mux client operation. The mux itself needs to be
>> locked, so transfers to clients behind the mux are serialized, and the mux
>> needs to be stable during all i2c traffic (otherwise individual mux slave
>> segments might see garbage, or worse).
>>
>> Add devive tree properties (bool named i2c-controlled) to i2c-mux-gpio and
>> i2c-mux-pinctrl that asserts that the the gpio/pinctrl is controlled via
>> the same i2c bus that it muxes.
> 
> Can't you determine this condition by checking the mux parent and gpio 
> parent are the same i2c controller?

Good suggestion, I wrote code that implements this, and will include it in
v3. Do not expect v3 to hit the dt crowd though, since no dt changes will
be needed then, but I'm sure that is not a problem...

> Alternatively, can't you just always do the locking like i2c-controlled 
> is set when a mux is involved? What is the harm in doing that if the 
> GPIO is controlled somewhere else?

No, that is not possible. If you change a non-i2c-controlled gpio in the
middle of some i2c-access, the slave side of the mux might see partial
i2c transfers, and that is a recipe for disaster.

> I would prefer to see a solution not requiring DT updates to fix and 
> this change seems like it is working around kernel issues.

Right, I'll make it so.

Cheers,
Peter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
